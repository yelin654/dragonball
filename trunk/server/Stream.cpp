#include <string.h>

#include "Stream.h"

Stream::Stream(int cap) {
    attach_data(new char[cap], cap);
}

Stream::~Stream() {
    if (NULL != data)
        delete [] data;
}

void Stream::attach_data(char* d, int len) {
    ri = wi = data = d;
    cap = len;
}

void Stream::write_byte(char c) {
    write_bytes(&c, 1);
}

void Stream::write_short(short s) {
    write_bytes(&s, 2);
}

void Stream::write_int(int v) {
    write_bytes(&v, sizeof(int));
}

void Stream::write_string(const char* str) {
    short len = strlen(str);
    write_bytes(&len, 2);
    write_bytes(str, len);
}

void Stream::write_string_array(char** buf, int len) {
    write_bytes(&len, 2);
    for (int i = 0; i < len; ++i)
        write_string(buf[i]);
}

void Stream::write_int_array(int* buf, int len) {
    write_bytes(&len, 1);
    write_bytes(buf, sizeof(int) * len);
}

void Stream::write_bytes(const void* buf, int len) {
    int has = length();
    if (cap - has < len) {
        char* new_data = new char[cap+len];
        memcpy(new_data, data, has);
        wi = new_data + has;
        cap += len;
        delete [] data;
        data = new_data;
    }
    memcpy(wi, buf, len);
    wi += len;
}

char Stream::read_byte() {
    char t;
    read_bytes(&t, 1);
    return t;
}

short Stream::read_short() {
    short t;
    read_bytes(&t, 2);
    return t;
}

int Stream::read_int() {
    int t;
    read_bytes(&t, 4);
    return t;
}

void Stream::read_int_array(int* buf, int& len) {
    len = 0;
    read_bytes(&len, 1);
    read_bytes(buf, 4 * len);
}

int Stream::read_bytes(void* buf, int len) {
    int nread = min(data+cap-ri, len);
    memcpy(buf, ri, nread);
    ri += nread;
    return nread;
}

int Stream::read_string(char* buf) {
    int len = read_short();
    read_bytes(buf, len);
    buf[len+1] = '\0';
    // short len = read_short();
    // char* buf = new char[len+1];
    // read_bytes(buf, len);
    // buf[len] = '\0';
    // string s(buf);
    // delete [] buf;
    // return s;
    return len;
}

void Stream::reset() {
    ri = wi = data;
}

void Stream::change_at(char* pos, void* data, int len) {
    memcpy(pos, data, len);
}

void Stream::shift(int num) {
    char* new_data;
    int has = length();
    if (num < has) {
        has -= num;
        new_data = new char[has];
        memcpy(new_data, wi+num, has);
        cap = has;
    } else {
        new_data = new char[1];
        cap = 1;
    }
    delete [] data;
    ri = wi = data = new_data;
}

