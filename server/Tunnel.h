#ifndef TUNNEL_H
#define TUNNEL_H

#include "Stream.h"
#include <sys/socket.h>
#include <netinet/in.h>

class Tunnel;

class TunnelOutputStream: public Stream {
public:
    TunnelOutputStream(Tunnel* t, int cap): Stream(cap), tunnel(t), writing(false) {};
    void new_block(int size);
    Tunnel* tunnel;
    void flush();
    void write_sock();

private:
    Block* _start;
    char* _from;
    char* _sock_ite;
    bool writing;
    void write_head();
    bool read_end();
};

class TunnelInputStream: public Stream {
public:
    TunnelInputStream(Tunnel* t, int cap): Stream(cap), tunnel(t) {};

    Tunnel* tunnel;
};

class IDataReceiver;

class Tunnel {
public:
    static const int READ_MAX = 1024;
    static const int WRITE_MAX = 1024;
    static const int HEAD_LENGTH = sizeof(int);

public:
    Tunnel(int socket_fd, IDataReceiver* receiver);
    ~Tunnel();

    TunnelOutputStream* get_output_stream(int length);
    void on_data_in();
    void on_data_in2();
    void on_data_out();

    bool connecting;
    bool writable;
    int _socket_fd;
    struct sockaddr_in client_addr;

    bool write_pending;
    bool read_pending;

    IDataReceiver* receiver;

    static char _WRITE_BUF[];

private:

    char* read_buf;
    char* write_buf;
    bool _readingHead;
    int _expectRead;

private:
    static char _READ_BUF[];

    char* _in_buf;
    int _in_buf_len;
    TunnelInputStream* _in_stream;
    TunnelOutputStream* _out_stream;
};

#endif
