#include <string.h>

#include "Stream.h"

Stream::Stream(int cap):inc(0) {
    _begin = _end = NULL;
    if (cap > 0)
        extend(cap);
    _length = cap;
}

Stream::Stream(char* data, int len):inc(0) {
    _begin = _end = NULL;
    append(data, len);
    _length = len;
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
    int left = _wb->data + _wb->cap - _wi;
    char* index = (char*)buf;
    if (left < len) {
        if (left != 0) {
            _write_bytes(buf, left);
            index += left;
        }
        extend(len - left + inc);
        wnext();
    }
    _write_bytes(index, (char*)buf + len - index);
}

inline void Stream::_write_bytes(const void* buf, int len) {
    memcpy(_wi, buf, len);
    _wi += len;
    _wb->end = _wi;
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
    int left;
    int nread = 0;
    char* cbuf = (char*)buf;
    while (nread < len && _rb != NULL) {
        left = _rb->end - _ri;
        if (left < len-nread) {
            if (left != 0) {
                _read_bytes(cbuf+nread, left);
                nread += left;
            }
            rnext();
        } else {
            _read_bytes(cbuf+nread, len-nread);
            return len;
        }
    }
    return nread;
}

inline void Stream::_read_bytes(void* buf, int len) {
    memcpy(buf, _ri, len);
    _ri += len;
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

inline void Stream::wnext() {
    _wb = _wb->next;
    if (NULL != _wb)
        _wi = _wb->data;
}

inline void Stream::rnext() {
    _rb = _rb->next;
    if (NULL != _rb)
        _ri = _rb->data;
}

void Stream::skip(int len) {
    int left;
    int nread = 0;
    while (nread < len && _rb != NULL) {
        left = _rb->end - _ri;
        if (left < len-nread) {
            _ri += left;
            nread += left;
            rnext();
        } else {
            _ri = _ri + len - nread;
            return;
        }
    }
}

void Stream::extend(int len) {
    append_block(new char[len] , len);
    _end->copy = false;
}

void Stream::append(char* data, int len) {
    append_block(data, len);
    _end->copy = true;
    _end->end = _end->data+_end->cap;
    _wb = _end;
    _wi = _end->data;
}

void Stream::append_block(char* data, int len) {
    Block* b = new Block(data, len);
    if (NULL == _end) {
        _wb = _rb = _begin = b;
        _wi = _ri = b->data;
    } else {
        _end->next = b;
    }
    _end = b;
    _length += len;
}

void Stream::copy(const Stream* stream) {
    Block* b = stream->_begin;
    while (NULL != b) {
        write_bytes(b->data, b->end - b->data);
        b = b->next;
    }
}

int Stream::length() const {
    return _length;
}

void Stream::clear() {
    Block* b;
    while (_begin != NULL) {
        if (!_begin->copy)
            delete [] _begin->data;
        b = _begin;
        _begin = _begin->next;
        delete b;
    }
    _end = NULL;
}

Stream::~Stream() {
    clear();
}
