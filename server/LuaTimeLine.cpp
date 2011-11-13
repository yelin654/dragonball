#include "LuaStory.h"
#include "LuaTimeLine.h"
#include "LuaTimeStamp.h"
#include "utils.h"
#include "Stream.h"

DEFINE_GAME_OBJECT(LuaTimeLine)

void LuaTimeLine::compile() {
    lua_getglobal(L, "add_timeline");
    lua_pushinteger(L, story->idx);
    lua_pushinteger(L, idx);
    lua_pcall(L, 2, 0, 0);
    FOR_MAP(int, LuaTimeStamp*, _stamps) {
        it->second->compile();
    }
};

void LuaTimeLine::goon() {
    _current_stamp->excute();
};


void LuaTimeLine::serialize(Stream* stream) {
    stream->write_int(idx);
    stream->write_int(_stamps.size());
    while (NULL != _current_stamp)
    {
        _current_stamp->serialize(stream);
        _current_stamp = _current_stamp->next;
    }
}

void LuaTimeLine::unserialize(Stream* stream) {
    idx = stream->read_int();
    int size = stream->read_int();
    int i; LuaTimeStamp* ts;
    for (i = 0; i < size; ++i)
    {
        ts = new LuaTimeStamp();
        ts->unserialize(stream);
        _stamps[ts->idx] = ts;
    }
}

void LuaTimeLine::save() {

}

void LuaTimeLine::load() {
    FOR_MAP(int, LuaTimeStamp*, _stamps) {
        it->second->load();
    }
}

void LuaTimeLine::add_stamp(LuaTimeStamp* ts)
{
    _stamps[ts->idx] = ts;
}
