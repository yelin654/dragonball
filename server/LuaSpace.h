#ifndef LUASPACE_H
#define LUASPACE_H

#include <map>
using namespace std;

#include "GameObject.h"
#include "LuaAction.h"

class LuaStory;
class LuaTalk;

class LuaSpace:public GameObject {
    DECLARE_GAME_OBJECT(LuaSpace, GameObject)
public:
    int idx;
    int story_idx;
    LuaStory* story;
    void compile();
    void goon();

public:
    virtual void serialize(Stream* stream);
    virtual void unserialize(Stream* stream);
    void save();
    void load(const char* filename);

    virtual void on_start();
    virtual void on_end();
    virtual void on_update();

private:
    map<int, LuaAction*> _actions;
    char* _script;
};

#endif
