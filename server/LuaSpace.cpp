#include "script.h"
#include "common.h"
#include "LuaSpace.h"
#include "LuaTalk.h"

DEFINE_GAME_OBJECT(LuaSpace)

void LuaSpace::load(const char* filename) {
    int size;
    load_file(_script, size, filename);

    luaL_loadstring(L, _script);
    lua_pcall(L, 0, 1, 0);

    lua_getfield(L, 1, "talks");

    LuaTalk* lt;
    lua_pushnil(L);
    while (lua_next(L, -2) != 0)
    {
        lt = new LuaTalk();
        lt->story_idx = story_idx;
        lt->space_idx = idx;
        lt->load();
        _actions[lt->idx] = lt;
        lua_pop(L, 1);//pop value
    }

    lua_pop(L, 1); //pop talks

    lua_pop(L, 1); //pop space
}

void LuaSpace::on_start() {
}

void LuaSpace::on_end() {
}

void LuaSpace::on_update() {
}

void LuaSpace::serialize(Stream* stream) {
}

void LuaSpace::unserialize(Stream* stream) {
}
