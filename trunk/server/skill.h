#ifndef SKILL_H
#define SKILL_H

#include "Serializable.h"
#include "Object.h"

class Skill:public Object {
public:
    virtual const Class* get_class() const {return NULL;};
    virtual void serialize(Stream& stream) const;
    virtual void unserialize(Stream& stream);
    Skill(){};
};


#endif
