#ifndef OUTPUTSTREAM_H
#define OUTPUTSTREAM_H

#include "Stream.h"

class OutputStream:public Stream {
public:
    OutputStream(int len);
    ~OutputStream();
    void attach_data(char* d, int len);
    virtual void write_bytes(const void* buf, int len);
    void change_at(char* pos, void* data, int len);
    void reset();
    void shift(int len);
    int length() {return wi-data;};
    //    void copy(const Stream* stream);

    char* wi;
    char* data;
    int cap;
};

#endif
