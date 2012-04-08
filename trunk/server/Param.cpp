#include <string.h>

#include <string.h>
#include "Param.h"
#include "Object.h"
#include "OutputStream.h"
#include "InputStream.h"
#include "stlite.h"
#include "Log.h"

Param::Param(const char* v, bool copy):_data(v), _type(TYPE_STRING), _delete(copy)
{
    int len;
    if (copy)
    {
        len = strlen(v) + 1;
        _data = new char[len];
        memcpy((void*)_data, v, len);
    }
}

typedef void (Param::*SERIALIZE_FUNC)(OutputStream* stream) const;
const SERIALIZE_FUNC Param::_serialize_func_table[TYPE_NUM] = {
    &Param::serialize_int,
    &Param::serialize_string,
    &Param::serialize_object,
    &Param::serialize_int_array,
    &Param::serialize_string_array,
    &Param::serialize_object_array,
    &Param::serialize_byte_array
};

inline void Param::serialize(OutputStream* stream) {
    stream->write_bytes((char*)(&_type), 1);
    (this->*_serialize_func_table[_type])(stream);
}

inline void Param::serialize_int(OutputStream* stream) const {
    stream->write_int((int)_data);
};

inline void Param::serialize_string(OutputStream* stream) const {
    stream->write_string((char*)_data);
};

void Param::serialize_object(OutputStream* stream) const {
    Object* o = (Object*)_data;
    stream->write_bytes((char*)&o->pass_as_reference, 1);
    if (o->pass_as_reference) {
        error("dont use");
        //stream->copy(o->key());
    } else {
        stream->write_string(o->class_name());
        o->serialize(stream);
    }
};

void Param::serialize_int_array(OutputStream* stream) const {
    Array<int>& array = *((Array<int>*)_data);
    int* data = array.data;
    stream->write_int(array.length);
    for (int i = 0; i < array.length; ++i)
        stream->write_int(data[i]);
}

void Param::serialize_string_array(OutputStream* stream) const {
    Array<char*>& array = *((Array<char*>*)_data);
    char** data = array.data;
    stream->write_int(array.length);
    for (int i = 0; i < array.length; ++i)
        stream->write_string(data[i]);
}

void Param::serialize_object_array(OutputStream* stream) const {
    Array<Object*>& array = *((Array<Object*>*)_data);
    Object** data = array.data;
    stream->write_int(array.length);
    Object* o;
    for (int i = 0; i < array.length; ++i) {
        o = data[i];
        stream->write_bytes((char*)&o->pass_as_reference, 1);
        if (o->pass_as_reference) {
            error("dont use");
            //stream->copy(o->key());
        } else {
            stream->write_string(o->class_name());
            o->serialize(stream);
        }
    }
}

void Param::serialize_byte_array(OutputStream* stream) const {
    const Array<char>* bytes = to_byte_array();
    stream->write_int(bytes->length);
    stream->write_bytes(bytes->data, bytes->length);
}


typedef void (Param::*UNSERIALIZE_FUNC)(InputStream* stream);
const UNSERIALIZE_FUNC Param::_unserialize_func_table[TYPE_NUM] = {
    &Param::_unserialize_int,
    &Param::_unserialize_string,
    &Param::_unserialize_object,
    &Param::_unserialize_int_array,
    &Param::_unserialize_string_array,
    &Param::_unserialize_object_array,
    &Param::_unserialize_byte_array
};

inline void Param::unserialize(InputStream* stream) {
    _type = stream->read_byte();
    (this->*_unserialize_func_table[_type])(stream);
    _delete = true;
};

inline void Param::_unserialize_int(InputStream* stream) {
    _data = (void*)stream->read_int();
};

inline void Param::_unserialize_string(InputStream* stream) {
    int len = stream->read_short();
    char* buf = new char[len+1];
    buf[len] = '\0';
    stream->read_bytes(buf, len);
    _data = (void*)buf;
};

void Param::_unserialize_object(InputStream* stream) {
    if (stream->read_byte()) {
        ParamList key;
        key.unserialize(stream);
        //_data = finder->find(&key);
    } else {
        int len = stream->read_short();
        char* name = new char[len+1];
        name[len] = '\0';
        stream->read_bytes(name, len);
        Object* o = NEW_INSTANCE(name);
        if (NULL != o) {
            o->unserialize(stream);
            _data = o;
        }
        delete [] name;
    }
};

void Param::_unserialize_int_array(InputStream* stream) {
    int len = stream->read_int();
    int* array = new int[len];
    for (int i = 0; i < len; ++i)
        array[i] = stream->read_int();
    _data = (void*)(new Array<int>(array, len));
};

void Param::_unserialize_string_array(InputStream* stream) {
    int len = stream->read_int();
    char** array = new char*[len];
    char* str; int size;
    for (int i = 0; i < len; ++i) {
        size = stream->read_short();
        str = new char[size+1];
        str[len] = '\0';
        stream->read_bytes(str, size);
        array[i] = str;
    }
    _data = (void*)(new Array<char*>(array, len));
};

void Param::_unserialize_object_array(InputStream* stream) {
    int num = stream->read_int();
    Object** array = new Object*[num];
    Object* o;
    char* name; int len;
    for (int i = 0; i < num; ++i) {
        if (stream->read_byte()) {
            ParamList key;
            key.unserialize(stream);
            //_data = finder->find(&key);
        } else {
            len = stream->read_short();
            name = new char[len+1];
            name[len] = '\0';
            stream->read_bytes(name, len);
            o = ::NEW_INSTANCE(name);
            o->unserialize(stream);
            array[i] = o;
        }
        delete [] name;
    }
    _data = (void*)(new Array<Object*>(array, num));
};

void Param::_unserialize_byte_array(InputStream* stream) {
    int len = stream->read_int();
    char* data = new char[len];
    stream->read_bytes(data, len);
    _data = new Array<char>(data, len);
}

Param::~Param() {
    if (!_delete) return;
    (this->*(_delete_func_table[_type]))();
};

typedef void (Param::*DELETE_FUNC)();
const DELETE_FUNC Param::_delete_func_table[TYPE_NUM] = {
    &Param::_delete_int,
    &Param::_delete_string,
    &Param::_delete_object,
    &Param::_delete_int_array,
    &Param::_delete_string_array,
    &Param::_delete_object_array,
    &Param::_delete_byte_array
};

void Param::_delete_int() {

}

void Param::_delete_string() {
    delete [] (char*)_data;
}

void Param::_delete_object() {
    delete (Object*)_data;
}

void Param::_delete_int_array() {
    Array<int>* array = (Array<int>*)_data;
    delete [] array->data;
    delete array;
}

void Param::_delete_string_array() {
    Array<char*>* array = (Array<char*>*)_data;
    char** data = array->data;
    for (int i = 0; i < array->length; ++i)
        delete [] data[i];
    delete array;
}

void Param::_delete_object_array() {
    Array<Object*>* array = (Array<Object*>*)_data;
    Object** data = array->data;
    for (int i = 0; i < array->length; ++i)
        delete [] data[i];
    delete array;
}

void Param::_delete_byte_array() {
    const Array<char>* bytes = to_byte_array();
    delete [] bytes->data;
    delete bytes;
}


//ParamList::ParamList() {
    //    _params = new _List(0);
//}

// ParamList::ParamList(const Param& param1):_delete(false) {
//     _params = new ParamArray(1);
//     (*_params)[0] = &param1;
// }

// ParamList::ParamList(const Param& param1, const Param& param2):_delete(false) {
//     _params = new ParamArray(2);
//     (*_params)[0] = &param1;
//     (*_params)[1] = &param2;
// }

// ParamList::ParamList(const Param& param1, const Param& param2, const Param& param3):_delete(false){
//     _params = new ParamArray(3);
//     (*_params)[0] = &param1;
//     (*_params)[1] = &param2;
//     (*_params)[2] = &param3;
// };

void ParamList::add(const Param& param) {
    //    _params.push_back(&param);
}

void ParamList::serialize(OutputStream* stream) {
    char size = _list.size();
    stream->write_bytes(&size, 1);
    FOR_LIST(Param*, _list) {
        (*it)->serialize(stream);
    }
    // for (int i = 0; i < size; ++i) {
    //     (*_params)[i]->serialize(stream);
    // }
}

void ParamList::unserialize(InputStream* stream) {
    int size = stream->read_byte();
    if (size <= 0) return;
    _delete = true;
    // _params = new ParamArray(size);
    Param* param;
    for (int i = 0; i < size; ++i) {
        param = new Param();
        _list.push_back(param);
        param->unserialize(stream);
    }
    // for (int i = 0; i < size; ++i) {
    //     param = new Param();
    //     (*_params)[i] = param;
    //     param->unserialize(stream);
    // }
};

ParamList::~ParamList() {
    if (_delete) {
        FOR_LIST(Param*, _list) {
            delete (*it);
        }
        //        for (unsigned i = 0; i < _params->size(); ++i) {
        //            delete (*_params)[i];
        //        }
    }
    //    delete _params;
}

const Param* ParamList::at(uint index) {
    //assert(index < _params->size());
    //        return *((*_params)[index]);
    uint i = 0;
    list<Param*>::iterator it = _list.begin();
    for (; it != _list.end(); ++it) {
        if (i == index)
            return *it;
        ++i;
    }
    return  *it;
}

Param* ParamList::shift() {
    Param* p = _list.front();
    _list.pop_front();
    return p;
}

void ParamList::unshift(Param* p) {
    _list.push_front(p);
}

void ParamList::push(Param* p) {
    _list.push_back(p);
}

