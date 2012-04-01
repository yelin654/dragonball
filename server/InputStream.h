#ifndef INPUTSTREAM_H
#define INPUTSTREAM_H

class InputStream {
public:
    void attach_data(char* d, int len);

    char read_byte();
    short read_short();
    int read_int();
    void read_int_array(int* buf, int& len);
    int read_string(char* buf);

    int read_bytes(void* buf, int len);

    char* ri;
    char* data;
    int cap;
};

#endif
