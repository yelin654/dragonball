#ifndef OBJECT_H
#define OBJECT_H

#include <stdio.h>

#include <string>
#include <map>
using namespace std;
#include "Serializable.h"


class Object;

class Class {
public:
    Class(const char* class_name):name(class_name){};
    const char* name;
    virtual Object* new_instance() const = 0;
};

//extern map<string, Class*> CLASS_INDEX;

inline map<string, Class*>& CLASS_INDEX()
{
    static map<string, Class*> index;
    return index;
}

inline Object* NEW_INSTANCE(const string& class_name)
{
    auto it = CLASS_INDEX().find(class_name);
    if (it != CLASS_INDEX().end())
        return it->second->new_instance();
    return NULL;
}

class ParamList;
class Stream;

class Object: public Serializable {
public:
    Object();
    virtual ~Object();

public:
    virtual const Class* get_class() const = 0;
    const char* class_name() const {return get_class()->name;};

public:
    const Stream* key();
    void set_key(ParamList* params);
private:
    Stream* _key;

public:
    bool pass_as_reference;
};

#define DECLARE_CLASS(T) \
public: \
    virtual const Class* get_class() const;

#define DEFINE_CLASS(T) \
extern map<string, Class*> CLASS_INDE; \
class Class##T:public Class { \
public: \
 Class##T():Class(#T){printf("[%d] Class %s\n",CLASS_INDEX().size(),name);CLASS_INDEX()[name] = this;}; \
    virtual Object* new_instance() const {return new T();}; \
}; \
const Class##T Class_##T; \
const Class* T::get_class() const { \
    return (Class*)&Class_##T; \
};

#endif
