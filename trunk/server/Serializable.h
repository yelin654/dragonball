#ifndef SERIALIZABLE_H
#define SERIALIZABLE_H

#include <string>
#include <map>
using namespace std;

class Stream;

class Serializable {
public:
    virtual void serialize(Stream* stream) = 0;
    virtual void unserialize(Stream* stream) = 0;

    static const int DEFAULT_SIZE = 256;
    virtual int size() {return DEFAULT_SIZE;};
};



#endif
