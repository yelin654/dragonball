#ifndef SERIALIZABLE_H
#define SERIALIZABLE_H

#include <string>
#include <map>
using namespace std;

#include "OutputStream.h"
#include "InputStream.h"

class Serializable {
public:
    virtual void serialize(OutputStream* stream) = 0;
    virtual void unserialize(InputStream* stream) = 0;

    static const int DEFAULT_SIZE = 256;
    virtual int size() {return DEFAULT_SIZE;};
};



#endif
