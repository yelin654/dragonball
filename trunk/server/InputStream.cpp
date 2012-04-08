#include <string.h>

#include <algorithm>
using namespace std;

#include "InputStream.h"
#include "Log.h"
#include "Object.h"

void InputStream::attach_data(char* d, int len) {
    ri = data = d;
    cap = len;
}

char InputStream::read_byte() {
    char t;
    read_bytes(&t, 1);
    return t;
}

short InputStream::read_short() {
    short t;
    read_bytes(&t, 2);
    return t;
}

int InputStream::read_int() {
    int t;
    read_bytes(&t, 4);
    return t;
}

void InputStream::read_int_array(int* buf, int& len) {
    len = 0;
    read_bytes(&len, 1);
    read_bytes(buf, 4 * len);
}

int InputStream::read_bytes(void* buf, int len) {
    int nread = min(data+cap-ri, len);
    memcpy(buf, ri, nread);
    ri += nread;
    return nread;
}

int InputStream::read_string(char* buf) {
    int len = read_short();
    read_bytes(buf, len+1);
    return len;
}

const char* InputStream::read_string(int& len) {
    len = read_short();
    const char* result = ri;
    skip(len);
    if (*ri != '\0') {
        error("string(%s) no end symbol", result);
    } else {
        skip(1);
    }
    return result;
}

const char* InputStream::read_string() {
    int len;
    return read_string(len);
}

Object* InputStream::read_object() {
    const char* name = read_string();
    Object* ob = NEW_INSTANCE(name);
    if (NULL != ob) {
        ob->unserialize(this);
    }
    return ob;
}
