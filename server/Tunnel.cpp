#include <sys/ioctl.h>
#include <string.h>

#include "Tunnel.h"
#include "IDataReceiver.h"
#include "Log.h"

char Tunnel::_READ_BUF[READ_MAX];
TunnelOutputStream* Tunnel::_out_stream = new TunnelOutputStream(WRITE_MAX);

Tunnel::Tunnel(int socket_fd, IDataReceiver* receiver):connecting(true), _socket_fd(socket_fd), receiver(receiver){
    receiver->on_connect(this);
    _readingHead = true;
    _expectRead = HEAD_LENGTH;
    _in_stream = new TunnelInputStream(this, 0);
    _out_cache = new OutputStream(1);
    write_pending = false;
}

Tunnel::~Tunnel() {
    delete _out_cache;
    delete _in_stream;
}

void Tunnel::on_data_in2() {
    int nread = read(_socket_fd, _READ_BUF, READ_MAX);
    int last = nread;
    char* index = _READ_BUF;
    char* old;
    int len;
    char* combo;
    while (_expectRead <=last) {
        last -= _expectRead;
        if (_readingHead) {
            if (NULL == _in_buf) {
                memcpy(&_expectRead, index, HEAD_LENGTH);
            } else {
                len = _expectRead;
                memcpy(&_expectRead, _in_buf, _in_buf_len);
                memcpy(&_expectRead+_in_buf_len, index, len);
                delete [] _in_buf;
                _in_buf = NULL;
            }
            index += HEAD_LENGTH;
            _readingHead = false;
        } else {
            if (NULL == _in_buf) {
                //_INPUT_STREAM->change_source(index, _expectRead);
                //receiver->on_data(this, _INPUT_STREAM);
            } else {
                combo = new char[_in_buf_len + _expectRead];
                memcpy(combo, _in_buf, _in_buf_len);
                memcpy(combo+_in_buf_len, index, _expectRead);
                delete [] _in_buf;
                _in_buf = NULL;
                //_INPUT_STREAM->change_source(combo, _in_buf_len+_expectRead);
                //receiver->on_data(this, _INPUT_STREAM);
                delete [] combo;
                combo = NULL;
            }
            index += _expectRead;
            _expectRead = HEAD_LENGTH;
            _readingHead = true;
        }
    }

    if (last > 0) {
        if (NULL == _in_buf) {
            _in_buf = new char[last];
            memcpy(_in_buf, index, last);
        } else {
            old = _in_buf;
            _in_buf = new char[_in_buf_len + last];
            memcpy(_in_buf, old, _in_buf_len);
            delete [] old;
            memcpy(_in_buf+_in_buf_len, index, last);
            _in_buf_len += last;
        }
        _expectRead -= last;
    }

    if (0 == nread) {
        close(_socket_fd);
        connecting = false;
        if (NULL != _in_buf) {
            delete [] _in_buf;
            _in_buf = NULL;
        }
        read_pending = false;
        return;
    }

    if (nread < 0) {
        if (errno == EAGAIN) {
            printf("[socket] read buff end\n");
        } else {
            printf("[error] socket read\n");
        }
        read_pending = false;
        return;
    }

    read_pending = (nread == READ_MAX);

    return;

    // char buf[40];
    // int nread = read(_socket_fd, buf, 1);
    // printf("read %d bytes", nread);

    // char buf2[1024*1024];
    // int nwrite = write(_socket_fd, buf2, 1024*1024);
    // printf("write %d bytes\n", nwrite);
    // nwrite  = write(_socket_fd, buf2, 1024*1024);
    // printf("write %d bytes\n", nwrite);
    // if (nwrite < 0)
    //     if (errno == EAGAIN)
    //         printf("[socket] write eagain\n");
    // return false;
}

void Tunnel::on_data_in() {
    int nread = read(_socket_fd, _READ_BUF, READ_MAX);
    int last = nread;
    char* index = _READ_BUF;
    while (_expectRead <=last) {
        // TODO:check 4 length
        _in_stream->append(index, _expectRead);
        index += _expectRead;
        last -= _expectRead;
        if (_readingHead) {
            _in_stream->read_bytes(&_expectRead, HEAD_LENGTH);
            _readingHead = false;
        } else {
            receiver->on_data(_in_stream);
            _expectRead = HEAD_LENGTH;
            _readingHead = true;
        }
        _in_stream->clear();
    }

    if (last > 0) {
        _in_stream->write_bytes(index, last);
        _expectRead -= last;
    }

    if (0 == nread) {
        close(_socket_fd);
        debug("close socket %d", _socket_fd);
        connecting = false;
        read_pending = false;
        return;
    }

    if (nread < 0) {
        if (errno == EAGAIN) {
            debug("read socket(%d) buff end", _socket_fd);
        } else {
            debug("close socket %d", _socket_fd);
            connecting = false;
        }
        read_pending = false;
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

TunnelOutputStream* Tunnel::get_output_stream(int size) {
    _out_stream->tunnel = this;
    _out_stream->reset();
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

