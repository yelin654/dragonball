#ifndef PLAYERWORKS_H
#define PLAYERWORKS_H

#include <list>
using namespace std;

#include "GameObject.h"

class LuaStory;
class Stream;

class MetaStory: public Object {
    DECLARE_CLASS(MetaStory)
public:
    virtual void serialize(Stream* stream);
    virtual void unserialize(Stream* stream);
};

class PlayerWorks: public GameObject {
    DECLARE_CLASS(PlayerWorks)
public:
    virtual void serialize(Stream* stream);
    virtual void unserialize(Stream* stream);

private:
    list<MetaStory*> _storys;
};

#endif
