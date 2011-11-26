#include "script.h"

lua_State* L;

void init_lua()
{
    L = lua_open();
    luaL_openlibs(L);
    luaL_dofile(L, "script/story.lua");
}

void LUA_tointeger_array(int index, int num, int* result)
{
    for (int i=0; i<num; ++i)
    {
        lua_rawgeti(L, index, i+1);
        result[i] = lua_tointeger(L, -1);
        lua_pop(L, 1);
    }
}

template<>
void push_one<int>(int t) {
    lua_pushinteger(L, t);
}

template<>
void push_one<const char*>(const char* t) {
    lua_pushstring(L, t);
}



