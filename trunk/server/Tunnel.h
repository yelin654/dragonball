#ifndef TUNNEL_H
#define TUNNEL_H

#include <sys/socket.h>
#include <netinet/in.h>

#include "InputStream.h"
#include "OutputStream.h"

class Tunnel;

class TunnelOutputStream: public OutputStream {
public:
    TunnelOutputStream(int cap, Tunnel* t=0): OutputStream(cap), tunnel(t) {};
    Tunnel* tunnel;
    void flush();
    void write_sock();

private:
    void write_head();
};

class TunnelInputStream: public InputStream {
public:
    TunnelInputStream() {};

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
    static TunnelInputStream* _in_stream;

    OutputStream* _out_cache;
    OutputStream* _in_cache;

    static char IN_BUF[];

private:
    bool _readingHead;
    int _expectRead;
};

#endif
