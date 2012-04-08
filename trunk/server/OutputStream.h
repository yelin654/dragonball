#ifndef OUTPUTSTREAM_H
#define OUTPUTSTREAM_H

class OutputStream {
public:
    OutputStream(int len);
    virtual ~OutputStream();

    void write_byte(char);
    void write_short(short);
    void write_int(int);
    void write_int_array(int* buf, int len);
    void write_string(const char*);
    void write_string_array(char** buf, int len);

    void write_bytes(const void* buf, int len);

    void change_at(char* pos, void* data, int len);
    void reset();
    void shift(int len);
    int length() const {return wi-data;};

    char* wi;
    char* data;
    int cap;
};

#endif
