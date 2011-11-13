#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

#include "LuaStory.h"
#include "LuaTimeLine.h"
#include "LuaTimeStamp.h"
#include "utils.h"
#include "Stream.h"
#include "script.h"

DEFINE_GAME_OBJECT(LuaTimeStamp)

LuaTimeStamp::LuaTimeStamp() {
    _script = NULL;
}

void LuaTimeStamp::compile() {
    int story_idx = timeline->story->idx;
    int timeline_idx = timeline->idx;
    int size = strlen(_script) + 100;
    char* script = new char[size];
    bzero(script, size);
    sprintf(script,
            "local timestamp = function()\n%s\nend\n"
            "add_timestamp(%d, %d, %d, timestamp)\n",
            _script, story_idx, timeline_idx, idx);
    luaL_dostring(L, script);
}

void LuaTimeStamp::excute() {
    int story_idx = timeline->story->idx;
    int timeline_idx = timeline->idx;
    lua_getglobal(L, "excute_timestamp");
    lua_pushinteger(L, story_idx);
    lua_pushinteger(L, timeline_idx);
    lua_pushinteger(L, idx);
    lua_pcall(L, 3, 0, 0);
}

void LuaTimeStamp::serialize(Stream* stream) {
    stream->write_int(idx);
    stream->write_string(_script);
}

void LuaTimeStamp::unserialize(Stream* stream) {
    idx = stream->read_int();
    short len = stream->read_short();
    _script = new char[len+1];
    _script[len] = '\0';
    stream->read_bytes(_script, len);
}

void LuaTimeStamp::save() {
    char name[32];
    bzero(name, 32);
    sprintf(name, "script/%s/%d/%d_%d.lua",
            owner, timeline->story->idx, timeline->idx, idx);
    FILE* wf = fopen(name, "w");
    fwrite(_script, strlen(_script), 1, wf);
    fclose(wf);
}

void LuaTimeStamp::load() {
    char name[32];
    bzero(name, 32);
    sprintf(name, "script/%s/%d/%d_%d.lua",
            owner, timeline->story->idx, timeline->idx, idx);
    FILE* rf = fopen(name, "r");
    fseek(rf, SEEK_SET, SEEK_END);
    int size = ftell(rf);
    _script = new char[size+1];
    fread(_script, size, 1, rf);
    _script[size] = '\0';
    fclose(rf);
}

void LuaTimeStamp::set_script(char* s) {
    if (NULL != _script)
        delete [] _script;
    _script = s;
}
