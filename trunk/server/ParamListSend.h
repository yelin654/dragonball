#ifndef PARAMLISTSEND_H
#define PARAMLISTSEND_H

#include "OutputStream.h"
#include "Log.h"
#include "Array.h"
#include "type.h"
#include "Object.h"

class ParamListSend {
public:
    void attach(OutputStream* stream, int num) {
        this->stream = stream;
        stream->write_byte(num);
    };

    template<class ...ARGS>
    void push_params(ARGS ...args) {
        _add_param(args...);
    };

    template<class T, class ...ARGS>
    void _add_param(T t, ARGS ...args) {
        push(t);
        _add_param(args...);
    };

    template<class T>
    void _add_param(T t) {
        push(t);
    };

    void write_type(int type) {
        stream->write_bytes(&type, 1);
    }

    void push(int t)
    {
        debug("push int(%d)", t);
        write_type(TYPE_INT);
        stream->write_int(t);
    };

    void push(char* t)
    {
        debug("push string(%s)", t);
        write_type(TYPE_STRING);
        stream->write_string(t);
    };

    void push(const char* t)
    {
        push((char*)t);
    };

    void push(Object* t)
    {
        write_type(TYPE_OBJECT);
        stream->write_bytes(&t->pass_as_reference, 1);
        if (t->pass_as_reference) {
            error("dont use");
            //stream->copy(t->key());
        } else {
            stream->write_string(t->class_name());
            t->serialize(stream);
        }
    };

    void push(Array<int>* t)
    {
        push(t->data, t->length);
    };

    void push(int* data, int len)
    {
        write_type(TYPE_INT_ARRAY);
        stream->write_int_array(data, len);
    };

    void push(const int* data, int len)
    {
        push((int*)data, len);
    };

    void push(Array<char*>* t)
    {
        write_type(TYPE_STRING);
        stream->write_string_array(t->data, t->length);
    };

    void push(Array<const char*>* t)
    {
        write_type(TYPE_STRING);
        stream->write_string_array((char**)t->data, t->length);
    };

    void push(Array<Object*>* t) {
        write_type(TYPE_OBJECT_ARRAY);
        Object** data = t->data;
        stream->write_int(t->length);
        Object* o;
        for (int i = 0; i < t->length; ++i) {
            o = data[i];
            stream->write_bytes(&o->pass_as_reference, 1);
            if (o->pass_as_reference) {
                error("dont use");
                //stream->copy(o->key());
            } else {
                stream->write_string(o->class_name());
                o->serialize(stream);
            }
        }
    };

    void push(Array<char>* t)
    {
        write_type(TYPE_BYTE_ARRAY);
        stream->write_int(t->length);
        stream->write_bytes(t->data, t->length);
    };

    OutputStream* stream;
};

// template<>
// inline void ParamListSend::_push<int>(int t)
// {
//     stream->write_bytes(&TYPE_INT, 1);
//     stream->write_int(t);
// }

// template<>
// inline void ParamListSend::_push<char*>(char* t)
// {
//     stream->write_bytes(&TYPE_STRING, 1);
//     stream->write_string(t);
// }

// template<>
// inline void ParamListSend::_push<Object*>(Object* t)
// {
//     stream->write_bytes(&TYPE_OBJECT, 1);
//     stream->write_bytes(&t->pass_as_reference, 1);
//     if (t->pass_as_reference) {
//         stream->copy(t->key());
//     } else {
//         stream->write_string(t->class_name());
//         t->serialize(stream);
//     }
// }

// template<>
// inline void ParamListSend::_push< Array<int>* >(Array<int>* t)
// {
//     stream->write_bytes(&TYPE_INT_ARRAY, 1);
//     stream->write_int_array(t->data, t->length);
// }

// template<>
// inline void ParamListSend::_push< Array<const char*>* >(Array<const char*>* t)
// {
//     stream->write_bytes(&TYPE_STRING, 1);
//     stream->write_string_array((char**)t->data, t->length);
// }

// template<>
// inline void ParamListSend::_push< Array<char*>* >(Array<char*>* t)
// {
//     stream->write_bytes(&TYPE_STRING, 1);
//     stream->write_string_array(t->data, t->length);
// }

// template<>
// inline void ParamListSend::_push< Array<Object*>* >(Array<Object*>* t)
// {
//     stream->write_bytes(&TYPE_OBJECT_ARRAY, 1);
//     Object** data = t->data;
//     stream->write_int(t->length);
//     Object* o;
//     for (int i = 0; i < t->length; ++i) {
//         o = data[i];
//         stream->write_bytes(&o->pass_as_reference, 1);
//         if (o->pass_as_reference) {
//             stream->copy(o->key());
//         } else {
//             stream->write_string(o->class_name());
//             o->serialize(stream);
//         }
//     }
// }

// template<>
// inline void ParamListSend::_push< ByteArray* >(ByteArray* t)
// {
//     stream->write_bytes(&TYPE_BYTE_ARRAY, 1);
//     stream->write_int(t->length);
//     stream->write_bytes(t->data, t->length);
// }

extern ParamListSend* g_pls;

#endif
