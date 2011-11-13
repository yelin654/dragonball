#include <stdio.h>

#include "Object.h"
#include "Param.h"
#include "Stream.h"



Object::Object():_key(NULL), pass_as_reference(false){
    ParamList pl;
    set_key(&pl);
};


void Object::set_key(ParamList* params) {
    if (NULL != _key)
        delete _key;
    _key = new Stream(32);
    params->serialize(_key);
}

const Stream* Object::key() {
    if (NULL == _key)
        _key = new Stream;
    return _key;
};


Object::~Object() {
    if (NULL != _key)
        delete _key;
}

