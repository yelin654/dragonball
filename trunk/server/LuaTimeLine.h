#ifndef LUATIMELINE_H
#define LUATIMELINE_H

#include <map>
using namespace std;

#include "GameObject.h"

class LuaStory;
class LuaTimeStamp;

class LuaTimeLine:public GameObject {
    DECLARE_GAME_OBJECT(LuaTimeLine, GameObject)
public:
    int idx;
    LuaStory* story;
    void compile();
    void goon();

    void add_stamp(LuaTimeStamp* ts);

public:
    virtual void serialize(Stream* stream);
    virtual void unserialize(Stream* stream);
    void save();
    void load();

private:
    LuaTimeStamp* _current_stamp;
    map<int, LuaTimeStamp*> _stamps;
};

#endif
