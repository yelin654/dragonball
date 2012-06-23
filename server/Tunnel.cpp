#include <sys/ioctl.h>
#include <string.h>
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

#include <algorithm>
using namespace std;

#include "Tunnel.h"
#include "IDataReceiver.h"
#include "Log.h"

char Tunnel::IN_BUF[READ_MAX];

TunnelOutputStream* Tunnel::_out_stream = new TunnelOutputStream(WRITE_MAX);
TunnelInputStream* Tunnel::_in_stream = new TunnelInputStream();


Tunnel::Tunnel(int socket_fd, IDataReceiver* receiver):connecting(true), _socket_fd(socket_fd), receiver(receiver){
    receiver->on_connect(this);
    _readingHead = true;
    _expectRead = HEAD_LENGTH;
    _out_cache = new OutputStream(1);
    _in_cache = new OutputStream(1);
    write_pending = false;
}

Tunnel::~Tunnel() {
    delete _out_cache;
    delete _in_cache;
    debug("destory tunnel %d", _socket_fd);
}

void Tunnel::on_data_in() {
    _in_stream->tunnel = this;
    int nread = read(_socket_fd, IN_BUF, READ_MAX);
    int last = nread;
    char* index = IN_BUF;
    while (_expectRead <=last) {
        last -= _expectRead;
        if (_readingHead) {
            if (_in_cache->length() > 0) {
                _in_cache->write_bytes(index, _expectRead);
                index += _expectRead;
                memcpy(&_expectRead, _in_cache->data, HEAD_LENGTH);
                _in_cache->reset();
            } else {
                memcpy(&_expectRead, index, HEAD_LENGTH);
                index += HEAD_LENGTH;
            }
            _readingHead = false;
        } else {
            if (_in_cache->length() > 0) {
                _in_cache->write_bytes(index, _expectRead);
                _in_stream->attach_data(_in_cache->data, _in_cache->length());
                _in_cache->reset();
            } else {
                _in_stream->attach_data(index, _expectRead);
            }
            receiver->on_data(_in_stream);
            index += _expectRead;
            _expectRead = HEAD_LENGTH;
            _readingHead = true;
        }
    }

    if (last > 0) {
        _in_cache->write_bytes(index, last);
        _expectRead -= last;
    }

    if (0 == nread) {
        connecting = false;
        read_pending = false;
        debug("nread 0, socket(%d)", _socket_fd);
        return;
    }

    if (nread < 0) {
        debug("nread -1, socket(%d), errno(%d), errstr(%s)", _socket_fd, errno, strerror(errno));
        if (errno == EAGAIN) {
            debug("read socket(%d) buff end", _socket_fd);
        } else {
            connecting = false;
        }
        read_pending = true;
        return;
    }

    read_pending = (nread == READ_MAX);

    return;
}

void Tunnel::on_data_out() {
    if (!write_pending) return;
    write_cache();
}

void Tunnel::write_cache() {
    int to_write = WRITE_MAX;
    to_write = min(to_write, _out_cache->length());
    int nwrite = write(_socket_fd, _out_cache->data, to_write);
    write_pending = nwrite < _out_cache->length();
    _out_cache->shift(nwrite);
}

TunnelOutputStream* Tunnel::get_output_stream() {
    _out_stream->tunnel = this;
    _out_stream->reset();
    int size = 0;
    _out_stream->write_bytes(&size, Tunnel::HEAD_LENGTH);
    return _out_stream;
}

void TunnelOutputStream::flush() {
    write_head();
    if (tunnel->write_pending)
    {
        tunnel->_out_cache->write_bytes(data, length());
        return;
    }
    write_sock();
}

void TunnelOutputStream::write_sock() {
    int to_write = Tunnel::WRITE_MAX;
    to_write = min(to_write, length());
    int nwrite = write(tunnel->_socket_fd, data, to_write);
    if (nwrite < length()) {
        tunnel->_out_cache->write_bytes(data+nwrite, length()-nwrite);
        tunnel->write_pending = true;
        debug("[WARNING] socket write pending");
    }

    // Block* tb = _rb;
    // char* ti = _ri;
    // int nread = 0;
    // int nwrite;
    // while (tb != _start) {
    //     nread += tb->end - ti;
    //     tb = tb->next;
    //     if (NULL != tb)
    //         ti = tb->data;
    // }
    // if (NULL != tb)
    //     nread += _from - ti;
    // if (Tunnel::WRITE_MAX < nread)
    //     nread = Tunnel::WRITE_MAX;
    // //    nread = min(Tunnel::WRITE_MAX, nread);

    // tb = _rb;
    // ti = _ri;
    // read_bytes(Tunnel::_WRITE_BUF, nread);
    // nwrite = write(tunnel->_socket_fd, Tunnel::_WRITE_BUF, nread);

    // if (nwrite < nread) {
    //     _rb = tb;
    //     _ri = ti;
    //     skip(nwrite);
    //     tunnel->write_pending = true;
    // }

    // while (_begin != _rb) {
    //     if (!_begin->copy)
    //         delete [] _begin->data;
    //     tb = _begin;
    //     _begin = _begin->next;
    //     delete tb;
    // }
}

void TunnelOutputStream::write_head() {
    int head = length() - Tunnel::HEAD_LENGTH;
    memcpy(data, &head, Tunnel::HEAD_LENGTH);
    // int len = _start->end - _from - 4;
    // Block* ite = _start;
    // if (ite != _wb) {
    //     while (ite != _wb->next) {
    //         len = len + ite->end - ite->data;
    //         ite = ite->next;
    //     }
    // }
    // int left = _start->end - _from;
    // if (left < Tunnel::HEAD_LENGTH) {
    //     memcpy(_from, &len, left);
    //     memcpy(_start->next->data, (char*)&len+left,
    //            Tunnel::HEAD_LENGTH-left);
    // } else {
    //     memcpy(_from, &len, Tunnel::HEAD_LENGTH);
    // }
    // _start = _wb;
    // _from = _wi;
}

