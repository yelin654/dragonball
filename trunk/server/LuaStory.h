#ifndef LUASTORY_H
#define LUASTORY_H

#include <map>
using namespace std;

#include "script.h"
#include "Story.h"

class LuaTimeLine;
class LuaSpace;
class LuaChapter;
class LuaSpace;

class LuaStory: public Story {
    DECLARE_GAME_OBJECT(LuaStory, Story)
public:
    void compile();
    void goon();
    char* owner;

public:
    virtual void serialize(Stream* stream) ;
    virtual void unserialize(Stream* stream);
    void load();
    void save();

private:

    LuaTimeLine* _current_timeline;
    map<int, LuaTimeLine*> _timelines;

    map<int, LuaSpace*> _spaces;
    map<int, LuaChapter*> _chapters;

};

#endif
