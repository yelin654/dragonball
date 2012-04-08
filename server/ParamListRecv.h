#ifndef PARAMLISTRECV_H
#define PARAMLISTRECV_H

#include "generation.h"

class InputStream;

class ParamListRecv {
public:
    void* datas[ARGS_LEN_MAX];
    int lens[ARGS_LEN_MAX];
    int types[ARGS_LEN_MAX];

    void attach(InputStream* stream);

    template<class T>
    T at(int i);

};

template<>
inline int ParamListRecv::at<int>(int i)
{
    return *((int*)datas[i]);
}

template<>
inline const char* ParamListRecv::at<const char*>(int i)
{
    return (const char*)datas[i];
}


#endif
