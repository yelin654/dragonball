#include "LuaTalk.h"

DEFINE_GAME_OBJECT(LuaTalk);

void LuaTalk::on_start() {
    lua_getglobal(L, "talk_on_start");
    lua_pushinteger(L, story_idx);
    lua_pushinteger(L, space_idx);
    lua_pushinteger(L, idx);
    lua_pcall(L, 3, 0, 0);
}

void LuaTalk::on_end() {

}

void LuaTalk::on_update() {

}

void LuaTalk::load() {
    lua_getfield(L, -1, "idx");
    idx = lua_tointeger(L, -1);
    lua_pop(L, 1);
    lua_getfield(L, -1, "next");
    next = lua_tointeger(L, -1);
    lua_pop(L, 1);
}

void LuaTalk::serialize(Stream* stream) {
}

void LuaTalk::unserialize(Stream* stream) {
}
