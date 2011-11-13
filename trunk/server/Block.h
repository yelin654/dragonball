#ifndef RPCSTREAM_H
#define RPCSTREAM_H

#include "Serializable.h"
#include "Stream.h"

class OutputStream: public Stream {
public:
    OutputStream(int length=1024):Stream(length+4) {
        _position += 4;
    };

    virtual void write_bytes(const char* buf, int len) {
        Stream::write_bytes(buf, len);
        (*((int*)_data)) = length() - 4;
    }
};

#endif
