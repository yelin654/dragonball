#include <string.h>

#include "Log.h"
#include "OutputStream.h"

OutputStream::OutputStream(int len) {
    wi = data = new char[len];
    cap = len;
}

OutputStream::~OutputStream() {
    delete [] data;
}

void OutputStream::write_byte(char c) {
    write_bytes(&c, 1);
}

void OutputStream::write_short(short s) {
    write_bytes(&s, 2);
}

void OutputStream::write_int(int v) {
    write_bytes(&v, sizeof(int));
}

void OutputStream::write_string(const char* str) {
    short len = strlen(str);
    write_bytes(&len, 2);
    write_bytes(str, len);
}

void OutputStream::write_string_array(char** buf, int len) {
    write_bytes(&len, 2);
    for (int i = 0; i < len; ++i)
        write_string(buf[i]);
}

void OutputStream::write_int_array(int* buf, int len) {
    write_bytes(&len, 1);
    write_bytes(buf, sizeof(int) * len);
}

void OutputStream::write_bytes(const void* buf, int len) {
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

void OutputStream::change_at(char* pos, void* data, int len) {
    memcpy(pos, data, len);
}

void OutputStream::shift(int num) {
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
    wi = data = new_data;
}

void OutputStream::reset() {
    wi = data;
}

