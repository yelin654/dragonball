#ifndef NET_H
#define NET_H

#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/resource.h>
#include <sys/epoll.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>

#include "ITunnelFactory.h"

class Net {
public:
    Net(ITunnelFactory* tunnel_factory):_tunnel_factory(tunnel_factory){};
    void init(const char* server_ip, int accept_port, int epoll_size, int accept_size, int delay=0);
    void dispatch();

private:
    int _listen_fd;
    struct epoll_event* _events;
    int _epoll_fd;
    int _epoll_size;
    int _epoll_fd_num;
    int _epoll_delay;
    struct epoll_event _ev;

    void set_non_block(int socket_fd);
    void set_block(int socket_fd);
    void mod_out(Tunnel* tunnel);
    void mod_in(Tunnel* tunnel);
    void mod(Tunnel* tunnel);
    int set_keep_alive(int socket_fd);

    void link();
    void handle_in(struct epoll_event* e);
    void handle_out(struct epoll_event* e);

private:
    ITunnelFactory* _tunnel_factory;
};

#endif
