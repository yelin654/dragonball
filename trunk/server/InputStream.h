#ifndef INPUTSTREAM_H
#define INPUTSTREAM_H

#include <algorithm>
using namespace std;

class Object;

class InputStream {
public:
    void attach_data(char* d, int len);

    char read_byte();
    short read_short();
    int read_int();
    void read_int_array(int* buf, int& len);
    int read_bytes(void* buf, int len);

    int read_string(char* buf);
    const char* read_string(int& len);
    const char* read_string();

    Object* read_object();

    int available() {return data+cap-ri;}
    void skip(int num) {ri = ri + min(available(), num);};

    char* ri;
    char* data;
    int cap;
};

#endif
