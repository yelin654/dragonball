#include <stdio.h>

#include "Object.h"
#include "Param.h"
#include "Log.h"


Object::Object():_key(NULL), pass_as_reference(false){
};


void Object::set_key(ParamList* params) {
    if (NULL != _key)
        delete _key;
    _key = new OutputStream(32);
    params->serialize(_key);
}

const OutputStream* Object::key() {
    return _key;
};


Object::~Object() {
    if (NULL != _key)
        delete _key;
}

