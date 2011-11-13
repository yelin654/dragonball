#ifndef ILOCAL_H
#define ILOCAL_H

class OutputStream;
class InputStream;
class ISynchronizer;

class ILocal {
public:
    //    virtual OutputStream* get_command_stream(short id, int size) = 0;
    virtual void on_connect(ISynchronizer* syn) = 0;
    virtual void on_disconnect(ISynchronizer* syn) = 0;
};

#endif
