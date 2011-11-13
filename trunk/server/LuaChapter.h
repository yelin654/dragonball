#ifndef LUACHAPTER_H
#define LUACHAPTER_H

#include <map>
using namespace std;

#include "script.h"
#include "GameObject.h"

class LuaSpace;

class LuaChapter:public GameObject {
    DECLARE_GAME_OBJECT(LuaChapter, GameObject)
public:
    int idx;
    void compile();

public:
    virtual void serialize(Stream* stream);
    virtual void unserialize(Stream* stream);
    void save();
    void load();

private:
    map<int, LuaSpace*> _spaces;
};


#endif
