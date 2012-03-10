#include <string.h>

#include "script.h"
#include "Log.h"

lua_State* L;
char* luaerror = NULL;

void log_lua_error() {
    const char* err = lua_tostring(L, -1);
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
    L = luaL_newstate();
    luaL_openlibs(L);
}

int lua_table_size(int index)
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

int lua_array_length(int index)
{
    lua_len(L, index);
    int result = lua_tointeger(L, -1);
    lua_pop(L, 1);
    return result;
}

bool lua_isarray(int index) {
    lua_pushnil(L);
    int i = index - 1;
    if (lua_next(L, i) != 0)
    {
        if (lua_isnumber(L, -2))
        {
            lua_pop(L, 2);
            return true;
        }
        lua_pop(L, 2);
        return false;
    }
    return true;
}

int lua_array_buf[16];

const int* lua_toint_array(int index, int& len)
{
    int num = lua_table_size(index);
    for (int i=0; i<num; ++i)
    {
        lua_rawgeti(L, index, i+1);
        lua_array_buf[i] = lua_tointeger(L, -1);
        lua_pop(L, 1);
    }
    return lua_array_buf;
}

void luaerrorcall(int num_in, int num_out) {
    if (NULL != luaerror) {
        delete [] luaerror;
        luaerror = NULL;
    }
    if (lua_pcall(L, num_in, num_out, 0) == 0) return;
    log_lua_error();
};
