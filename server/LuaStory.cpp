#include <stdio.h>
#include <string.h>

#include "Stream.h"
#include "Log.h"
#include "utils.h"

#include "LuaStory.h"
#include "LuaChapter.h"
#include "LuaTimeLine.h"
#include "LuaTimeStamp.h"
#include "LuaSpace.h"



DEFINE_GAME_OBJECT(LuaStory)

void LuaStory::compile() {
    lua_getglobal(L, "add_story");
    lua_pushinteger(L, idx);
    lua_pcall(L, 1, 0, 0);
    FOR_MAP(int, LuaTimeLine*, _timelines) {
        it->second->compile();
    }
};


void LuaStory::serialize(Stream* stream) {
    stream->write_int(idx);
    stream->write_int(_timelines.size());
    FOR_MAP(int, LuaTimeLine*, _timelines) {
        it->second->serialize(stream);
    }
}

void LuaStory::unserialize(Stream* stream) {
    idx = stream->read_int();
    int size = stream->read_int();
    int i;
    LuaTimeLine* tl;
    for (i = 0; i < size; ++i) {
        tl = new LuaTimeLine();
        tl->unserialize(stream);
        _timelines[tl->idx] = tl;
    }
}

void LuaStory::save() {

}

void LuaStory::load() {
    debug(">>>>>> load story %s/%d", owner, idx);

    char name[32];
    bzero(name, 32);
    sprintf(name, "script/%s/%d/meta.lua",
            owner, idx);
    luaL_loadfile(L, name);

    debug("load meta file %s", name);

    lua_pcall(L, 0, 1, 0);

    lua_getfield(L, -1, "spaces");

    int space_idx;
    LuaSpace* sp;
    lua_pushnil(L);
    while (lua_next(L, -2) != 0)
    {
        space_idx = lua_tointeger(L, -1);
        lua_pop(L, 1);

        debug("create Space  %d", space_idx);
        bzero(name, 32);
        sp = new LuaSpace();
        sp->idx = space_idx;
        sp->story_idx = idx;
        sprintf(name, "script/%s/%d/%d.lua",
                owner, idx, space_idx);
        sp->load(name);
        _spaces[space_idx] = sp;
    }

    lua_pop(L, 1); // pop spaces

    lua_pop(L, 1); //pop meta

    debug("end load story %s/%d    <<<<<<", owner, idx);
}

// void LuaStory::load() {
//     debug("<<<<<<    start load story %s/%d", owner, idx);

//     char name[32];
//     bzero(name, 32);
//     sprintf(name, "script/%s/%d/meta.lua",
//             owner, idx);
//     luaL_loadfile(L, name);

//     debug("load meta file %s", name);

//     lua_pcall(L, 0, 1, 0);
//     lua_pushnil(L);
//     int k1, v2;
//     LuaTimeLine* tl;
//     LuaTimeStamp* ts;
//     FILE* rf;
//     int size;
//     char* script;
//     while (lua_next(L, -2) != 0)
//     {
//         k1 = lua_tointeger(L, -2);
//         tl = new LuaTimeLine();
//         tl->idx = k1;
//         tl->story = this;
//         _timelines[k1] = tl;
//         debug("create TimeLine %d", k1);

//         lua_pushnil(L);
//         while (lua_next(L, -2) != 0)
//         {
//             v2 = lua_tointeger(L, -1);
//             ts = new LuaTimeStamp();
//             ts->idx = v2;
//             ts->timeline = tl;

//             bzero(name, 32);
//             sprintf(name, "script/%s/%d/%d.lua",
//                     owner, idx, v2);
//             rf = fopen(name, "r");
//             fseek(rf, SEEK_SET, SEEK_END);
//             size = ftell(rf);
//             script = new char[size+1];
//             fseek(rf, 0, SEEK_SET);
//             fread(script, size, 1, rf);
//             script[size] = '\0';
//             fclose(rf);
//             ts->set_script(script);
//             tl->add_stamp(ts);
//             lua_pop(L, 1); //pop v2

//             debug("load TimeStamp %s %dB", name, size);
//         }

//         lua_pop(L, 1); //pop v1
//     }
//     lua_pop(L, 1); //pop meta table
//     debug("end load story %s/%d    >>>>>", owner, idx);
// }
