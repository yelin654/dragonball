#include <string.h>

#include <algorithm>
using namespace std;

#include "InputStream.h"

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
    read_bytes(buf, len);
    buf[len+1] = '\0';
    return len;
}

