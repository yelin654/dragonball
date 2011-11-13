#ifndef OBJECTMIRROR_H
#define OBJECTMIRROR_H

class GameObject;
class Stream;

class ObjectMirror {
public:
    ObjectMirror(GameObject* o):object(o){};
    GameObject* object;

public:
    virtual void syn_method(const Stream& method)=0;
};

#endif
