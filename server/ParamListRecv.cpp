#include <string.h>

#include "ParamListRecv.h"
#include "InputStream.h"
#include "type.h"
#include "Object.h"
#include "Array.h"

void ParamListRecv::attach(InputStream* stream) {
    bzero(datas, ARGS_LEN_MAX * sizeof(datas[0]));
    bzero(lens, ARGS_LEN_MAX * sizeof(lens[0]));
    bzero(types, ARGS_LEN_MAX * sizeof(types[0]));
    int size = stream->read_byte();
    size = min(size, ARGS_LEN_MAX);
    if (size == 0) return;
    int len;
    for (int i = 0; i < size; ++i) {
        switch (types[i] = stream->read_byte()) {
        case TYPE_INT: {
            lens[i] = sizeof(int);
            datas[i] = stream->ri;
            stream->skip(lens[i]);
            break;
        }
        case TYPE_STRING: {
            datas[i] = (void*)stream->read_string(len);
            lens[i] = len;
            break;
        }
        case TYPE_OBJECT: {
            datas[i] = stream->read_object();
            lens[i] = 0;
            break;
        }
        case TYPE_BYTE_ARRAY: {
            lens[i] = stream->read_int();
            datas[i] = stream->ri;
            stream->skip(lens[i]);
            break;
        }
        case TYPE_INT_ARRAY: {
            lens[i] = stream->read_int();
            datas[i] = stream->ri;
            stream->skip(lens[i] * sizeof(int));
            break;
        }
        case TYPE_STRING_ARRAY: {
            lens[i] = len = stream->read_int();
            char** array = new char*[len];
            for (int j = 0; j < len; ++j) {
                array[j] = (char*)stream->read_string();
            }
            Array<char*>* arr = new Array<char*>(array, len);
            datas[i] = (void*)arr;
            break;
        }
        case TYPE_OBJECT_ARRAY: {
            lens[i] = len = stream->read_int();
            Object** array = new Object*[len];
            for (int j = 0; j < len; ++j) {
                array[j] = stream->read_object();
            }
            datas[i] = (void*)(new Array<Object*>(array, len));
            break;
        }
        }
    }
}
