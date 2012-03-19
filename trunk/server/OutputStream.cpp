#include <string.h>

#include "OutputStream.h"

OutputStream::OutputStream(int len) {
    attach_data(new char[len], len);
}

OutputStream::~OutputStream() {
    delete [] data;
}

void OutputStream::attach_data(char* d, int len) {
    wi = data = d;
    cap = len;
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

