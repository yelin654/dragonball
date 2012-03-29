#ifndef STREAM_H
#define STREAM_H

#include <string>
#include <list>
using namespace std;

class Stream {
public:
    Stream(int cap);
    Stream();
    virtual ~Stream();

    void attach_data(char* d, int len);
    void shift(int len);
    void reset();

    void write_byte(char);
    void write_short(short);
    void write_int(int);
    void write_int_array(int* buf, int len);
    virtual void write_bytes(const void* buf, int len);
    void write_string(const char*);
    void write_string_array(char** buf, int len);
    void write_stream(const Stream& stream);
    void change_at(char* pos, void* data, int len);

    char read_byte();
    short read_short();
    int read_int();
    void read_int_array(int* buf, int& len);
    virtual int read_bytes(void* buf, int len);
    int read_string(char* buf);

    int length() const {return wi-data;} ;

    char* ri;
    char* wi;
    char* data;
    int cap;
};

#endif
