#include <string.h>

#include "script.h"
#include "Log.h"

lua_State* L;
char* luaerror = new char[1];

void log_lua_error() {
    const char* err = lua_tostring(L, -1);
    delete [] luaerror;
    luaerror = new char[strlen(err)+1];
    strcpy(luaerror, err);
    error("[lua] %s", luaerror);
    lua_pop(L, 1);
}

void load_lua_file(const char* name) {
    if (luaL_dofile(L, name) != 0)
    {
        log_lua_error();
    }
}

void init_lua()
{
    L = lua_open();
    luaL_openlibs(L);
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

void lua_newinteger_array(int index, int& len, int*& result)
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

void luaerrorcall(int num_in, int num_out) {
    if (lua_pcall(L, num_in, num_out, 0) == 0) return;
    log_lua_error();
};
