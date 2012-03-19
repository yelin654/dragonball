#ifndef TUNNEL_H
#define TUNNEL_H

#include <sys/socket.h>
#include <netinet/in.h>

#include "Stream.h"
#include "OutputStream.h"

class Tunnel;

class TunnelOutputStream: public OutputStream {
public:
    TunnelOutputStream(int cap): OutputStream(cap), tunnel(NULL) {};
    Tunnel* tunnel;
    void flush();
    void write_sock();

private:
    void write_head();
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
    void write_cache();

    bool connecting;
    bool writable;
    int _socket_fd;
    struct sockaddr_in client_addr;

    bool write_pending;
    bool read_pending;

    IDataReceiver* receiver;

    static TunnelOutputStream* _out_stream;
    OutputStream* _out_cache;

    //static char _WRITE_BUF[];

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

};

#endif
