#include "Net.h"
#include "Log.h"

#include <time.h>
#include <sys/stat.h>
#include <sys/fcntl.h>
#include <syslog.h>
#include <signal.h>

void Net::init(const char* server_ip, int accept_port, int epoll_size, int accept_size, int delay) {
    _listen_fd = socket(AF_INET, SOCK_STREAM, 0);
    set_non_block(_listen_fd);

    _epoll_fd = epoll_create(epoll_size);
    _ev.data.fd = _listen_fd;
    _ev.events = EPOLLIN | EPOLLET;
    epoll_ctl(_epoll_fd, EPOLL_CTL_ADD, _listen_fd, &_ev);

    _events = new struct epoll_event[epoll_size];
    _epoll_size = epoll_size;
    _epoll_delay = delay;

    struct sockaddr_in server_addr;
    bzero(&server_addr, sizeof(server_addr));
    server_addr.sin_family = AF_INET;
    inet_aton(server_ip, &(server_addr.sin_addr));
    server_addr.sin_port = htons(accept_port);
    struct linger so_linger;
    so_linger.l_onoff = 1;
    so_linger.l_linger = 0;
    if (setsockopt(_listen_fd,
                   SOL_SOCKET,
                   SO_LINGER,
                   &so_linger,
                   sizeof so_linger))
    {
        error("setsockopt(2)");
    }

    if (bind(_listen_fd,(sockaddr*)&server_addr,
             sizeof(server_addr)) == -1)
    {
        error("bind failed");
    }
    if (listen(_listen_fd, accept_size) == -1)
    {
        error("listen failed");
    }
}

void Net::dispatch() {
    _epoll_fd_num = epoll_wait(_epoll_fd, _events, _epoll_size, _epoll_delay);
    struct epoll_event* e;
    for (int i = 0; i < _epoll_fd_num; ++i) {
        e = &_events[i];
        if (e->data.fd == _listen_fd) {
            debug("new connect");
            link();
            continue;
        }
        if (e->events & EPOLLOUT) {
            debug("epoll out event");
            handle_out(e);
        }
        if (e->events & EPOLLIN) {
            debug("epoll in event");
            handle_in(e);
        }
    }
}

void Net::mod(Tunnel* tunnel) {
    if (!tunnel->write_pending && !tunnel->read_pending)
        return;
    _ev.data.fd = tunnel->_socket_fd;
    _ev.data.ptr = tunnel;
    _ev.events = EPOLLET;
    if (tunnel->write_pending)
        _ev.events |= EPOLLOUT;
    if (tunnel->read_pending)
        _ev.events |= EPOLLIN;
    epoll_ctl(_epoll_fd, EPOLL_CTL_MOD, tunnel->_socket_fd, &_ev);
}

void Net::mod_out(Tunnel* tunnel) {
    _ev.data.fd = tunnel->_socket_fd;
    _ev.data.ptr = tunnel;
    _ev.events = EPOLLET | EPOLLOUT;
    if (tunnel->read_pending)
        _ev.events |= EPOLLIN;
    epoll_ctl(_epoll_fd, EPOLL_CTL_MOD, tunnel->_socket_fd, &_ev);
}

void Net::mod_in(Tunnel* tunnel) {
    _ev.data.fd = tunnel->_socket_fd;
    _ev.data.ptr = tunnel;
    _ev.events = EPOLLET | EPOLLIN;
    if (tunnel->write_pending)
        _ev.events |= EPOLLOUT;
    epoll_ctl(_epoll_fd, EPOLL_CTL_MOD, tunnel->_socket_fd, &_ev);
}

void Net::link() {
    struct sockaddr_in client_addr;
    socklen_t client_len = sizeof(client_addr);
    int client_fd = 0;
    while(true) {
        client_fd = accept(_listen_fd, (sockaddr *)&client_addr, &client_len);
        if (client_fd < 0) break;
        set_non_block(client_fd);
        Tunnel* tunnel = _tunnel_factory->create_tunnel(client_fd);
        tunnel->client_addr = client_addr;
        _ev.data.fd = client_fd;
        _ev.data.ptr = tunnel;
        _ev.events = EPOLLET | EPOLLIN;
        epoll_ctl(_epoll_fd, EPOLL_CTL_ADD, client_fd, &_ev);
    }
}

void Net::handle_in(struct epoll_event* e) {
    Tunnel* tunnel = (Tunnel*)e->data.ptr;
    tunnel->on_data_in();
    if (tunnel->read_pending)
        mod_in(tunnel);

    if (!tunnel->connecting) {
        epoll_ctl(_epoll_fd, EPOLL_CTL_DEL, tunnel->_socket_fd, NULL);
        _tunnel_factory->destroy(tunnel);
    }
}


void Net::handle_out(struct epoll_event* e) {
    Tunnel* tunnel = (Tunnel*)e->data.ptr;
    tunnel->on_data_out();
    if (tunnel->write_pending)
        mod_out(tunnel);
}

void Net::set_non_block(int socket_fd) {
    int opts = fcntl(socket_fd, F_GETFL);
    if (opts < 0) {
        perror("fcntl(socket_fd,GETFL)");
        exit(1);
    }
    opts = opts | O_NONBLOCK;
    if (fcntl(socket_fd,F_SETFL,opts)<0) {
        perror("fcntl(socket_fd,SETFL,opts)");
        exit(1);
    }
}

void Net::set_block(int socket_fd) {
    int opts = fcntl(socket_fd, F_GETFL);
    if (opts < 0) {
        perror("fcntl(socket_fd,GETFL)");
        exit(1);
    }
    opts = opts & (~O_NONBLOCK);
    if (fcntl(socket_fd, F_SETFL, opts)<0) {
        perror("fcntl(socket_fd,SETFL,opts)");
        exit(1);
    }
}

