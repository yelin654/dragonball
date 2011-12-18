#include "script.h"

lua_State* L;

void init_lua()
{
    L = lua_open();
    luaL_openlibs(L);
    luaL_dofile(L, "script/story.lua");
}

int lua_table_length(int index)
{
    int num = 0;
    lua_pushnil(L);
    int i = index - 1;
    while (lua_next(L, i) != 0)
    {
        num++;
        lua_pop(L, 1);
    }
    return num;
}

void lua_tointeger_array(int index, int& len, int*& result)
{
    int num = lua_table_length(index);
    result = new int[num];
    for (int i=0; i<num; ++i)
    {
        lua_rawgeti(L, index, i+1);
        result[i] = lua_tointeger(L, -1);
        lua_pop(L, 1);
    }
}

