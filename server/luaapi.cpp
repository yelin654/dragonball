#include "script.h"
#include "Param.h"
#include "luaapi.h"
#include "ClientSyner.h"
#include "Player.h"
#include "Array.h"

LuaContext lua_context;

void add_param(ParamList* pl, lua_State* L) {
    int type = lua_type(L, -1);
    switch (type) {
    case LUA_TSTRING: {
        const char* str = lua_tostring(L, -1);
        pl->add_param(str);
        break;
    }
    case LUA_TNUMBER: {
        int i = lua_tointeger(L, -1);
        pl->add_param(i);
        break;
    }
    case LUA_TTABLE: {
        int len; int* arr_int;
        lua_tointeger_array(-1, len, arr_int);
        Array<int> Arr_int(arr_int, len);
        pl->add_param(Arr_int);
        break;
    }
    }
}

int C_as_call(lua_State* L) {
    const char* func_name = lua_tostring(L, -1);
    ParamList pl;
    lua_pushnil(L);
    while (lua_next(L, -3) != 0)
    {
        add_param(&pl, L);
        lua_pop(L, 1);
    }
    ClientSyner* syner = lua_context.player->syner;
    syner->_rpc(func_name, &pl);
    return 1;
}

#define REG_LUA(name) \
    lua_pushcfunction(L, name); \
    lua_setglobal(L, #name);

void register_lua() {
    REG_LUA(C_as_call);
}
