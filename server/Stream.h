#ifndef STREAM_H
#define STREAM_H

#include <string>
#include <list>
using namespace std;

class Block {
public:
    Block(char* dt, int len):data(dt), end(dt), cap(len), next(NULL){};
    char* data;
    char* end;
    bool copy;
    int cap;
    Block* next;
};

typedef const char* const_char;

class Stream {
public:
    Stream(int cap=0);
    Stream(char* data, int len);
    virtual ~Stream();
    void write_byte(char);
    void write_short(short);
    void write_int(int);
    void write_int_array(int* buf, int len);
    virtual void write_bytes(const void* buf, int len);
    void write_string(const char*);
    void write_string_array(char** buf, int len);
    void write_stream(const Stream& stream);

    char read_byte();
    short read_short();
    int read_int();
    void read_int_array(int* buf, int& len);
    int read_bytes(void* buf, int len);
    int read_string(char* buf);

    void append(char* data, int len);
    void copy(const Stream* stream);
    void clear();
    int length() const;

    void extend(int len);
    void skip(int len);

    int inc;

protected:
    Block*_wb;
    char* _wi;
    Block*_rb;
    char* _ri;
    Block* _begin;
    Block* _end;
    void wnext();
    void rnext();
    void _write_bytes(const void* buf, int len);
    void _read_bytes(void* buf, int len);

private:
    void append_block(char* data, int len);

    int _length;
};

#endif
