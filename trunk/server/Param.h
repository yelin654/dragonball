#ifndef PARAM_H
#define PARAM_H
#include <assert.h>
#include <stdio.h>
#include <string>
#include <vector>
#include <list>
using namespace std;

#include "Object.h"
#include "Array.h"

//class Object;

typedef unsigned int uint;
typedef char byte;

class ByteArray {
public:
    char* data;
    int length;
    ByteArray(char* data, int length) {
        this->data = data;
        this->length = length;
    }
};

class Param:public Serializable {
public:
    static const int TYPE_INT = 0;
    static const int TYPE_STRING = 1;
    static const int TYPE_OBJECT = 2;
    static const int TYPE_INT_ARRAY = 3;
    static const int TYPE_STRING_ARRAY = 4;
    static const int TYPE_OBJECT_ARRAY = 5;
    static const int TYPE_BYTE_ARRAY = 6;
    static const int TYPE_LUA_TABLE = 7;

    Param(){};
    Param(int v):_data((void*)v), _type(TYPE_INT), _delete(false){};
    Param(const char* v, bool copy=false);
    Param(Object* v):_data(v), _type(TYPE_OBJECT), _delete(false){};
    Param(const Array<int>* v, bool del=false):_data(v), _type(TYPE_INT_ARRAY), _delete(del){};
    Param(const Array<char*>* v, bool del=false):_data(v), _type(TYPE_INT_ARRAY), _delete(del){};
    Param(const Array<const char*>* v, bool del=false):_data(v), _type(TYPE_INT_ARRAY), _delete(del){};
    Param(const Array<Object*>* v):_data(&v), _type(TYPE_INT_ARRAY), _delete(false){};
    Param(const ByteArray* v):_data(&v), _type(TYPE_INT_ARRAY), _delete(false){};

    ~Param();

    virtual void serialize(Stream* stream);
    virtual void unserialize(Stream* stream);

    int to_int() const {
        return (int)_data;
    };

    const char* to_string() const {
        return (const char*)_data;
    };

    const Object* to_object() const {
        return (const Object*)_data;
    };

    const Array<int>& to_int_array() const {
        return *((Array<int>*)_data);
    };

    const Array<char*>& to_string_array() const{
        return *((Array<char*>*)_data);
    };

    const Array<Object*>& to_object_array() const{
        return *((Array<Object*>*)_data);
    };

    const ByteArray* to_byte_array() const {
        return (ByteArray*)_data;
    };

    template<class T>
    operator const T() const {return (T)_data;};

    operator const int() const {return to_int();};
    operator const char*() const {return to_string();};
    operator const Array<int>() const {return *((Array<int>*)_data);};
    operator const Array<char*>() const {return *((Array<char*>*)_data);};
    operator const Array<Object*>() const {return *((Array<Object*>*)_data);};
    operator const ByteArray*() const {return (ByteArray*)_data;};

public:

    const void* _data;
    int _data_len;
    int _type;
    bool _delete;

    static const int TYPE_NUM = 7;

    void serialize_int(Stream* stream) const;
    void serialize_string(Stream* stream) const;
    void serialize_object(Stream* stream) const;
    void serialize_int_array(Stream* stream) const;
    void serialize_string_array(Stream* stream) const;
    void serialize_object_array(Stream* stream) const;
    void serialize_byte_array(Stream* stream) const;
    typedef void (Param::*SERIALIZE_FUNC)(Stream* stream) const;
    static const SERIALIZE_FUNC _serialize_func_table[TYPE_NUM];

    void _unserialize_int(Stream* stream);
    void _unserialize_string(Stream* stream);
    void _unserialize_object(Stream* stream);
    void _unserialize_int_array(Stream* stream);
    void _unserialize_string_array(Stream* stream);
    void _unserialize_object_array(Stream* stream);
    void _unserialize_byte_array(Stream* stream);
    typedef void (Param::*UNSERIALIZE_FUNC)(Stream* stream);
    static const UNSERIALIZE_FUNC _unserialize_func_table[TYPE_NUM];

    void _delete_int() ;
    void _delete_string() ;
    void _delete_object() ;
    void _delete_int_array() ;
    void _delete_string_array();
    void _delete_object_array();
    void _delete_byte_array();
    typedef void (Param::*_DELETE_FUNC)() ;
    static const _DELETE_FUNC _delete_func_table[TYPE_NUM];

};

class ParamList:public Serializable {
public:
    ParamList() {};
    template<class ...ARGS>
    ParamList(ARGS ...args) {
        //  _params = new _List(sizeof...(args));
        //        _param_acc = 0;
        _add_param(args...);
    };

    template<class T, class ...ARGS>
    void _add_param(T t, ARGS ...args) {
        //        cout << "add param " << t << endl;
        //        (*_params)[_param_acc++] = new Param(t);
        _list.push_back(new Param(t));
        _add_param(args...);
    };

    template<class T>
    void _add_param(T t) {
        //        (*_params)[_param_acc] = new Param(t);
        _list.push_back(new Param(t));
        //        cout << "add param " << t << endl;
    };

    Param* shift();
    void unshift(Param*);

    void push(Param*);

    // ParamList(const Param&);
    // ParamList(const Param&, const Param&);
    // ParamList(const Param&, const Param&, const Param&);
    ~ParamList();

    virtual void serialize(Stream* stream);
    virtual void unserialize(Stream* stream);

    const Param* at(uint index);

    const Param& operator[](uint index) {
        return *at(index);
    }

    void add(const Param& param);

    list<Param*> _list;

private:
    int _param_acc;
    //vector<Param*>* _params;

    bool _delete;
};

#endif
