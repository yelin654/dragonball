#include "script.h"
#include "Param.h"
#include "luaapi.h"
#include "ClientSyner.h"
#include "Player.h"
#include "Array.h"
#include "StoryProgress.h"
#include "stlite.h"

LuaContext lua_context;

void update_lua_progress(StoryProgress* p)
{
    lc("lua_update_progress", p->story_idx, p->space_idx,
       p->chapter_idx, p->action_idx);
}

void lua_to_param(ParamList* pl) {
    int type = lua_type(L, -1);
    Param* p;
    switch (type) {
    case LUA_TSTRING: {
        p = new Param(lua_tostring(L, -1), true);
        pl->push(p);
        break;
    }
    case LUA_TNUMBER: {
        p = new Param(lua_tointeger(L, -1));
        pl->push(p);
        break;
    }
    case LUA_TTABLE: {
        int len; int* arr_int;
        lua_newinteger_array(-1, len, arr_int);
        Array<int>* Arr_int = new Array<int>(arr_int, len);
        p = new Param(Arr_int, true);
        pl->push(p);
        delete [] arr_int;
        break;
    }
    }
}

int lua_push_params(ParamList* pl) {
    Param* p;
    int in_num = 0;
    FOR_LIST(Param*, pl->_list) {
        p = *it;
        in_num++;
        switch (p->_type) {
        case Param::TYPE_INT: {
            lua_pushinteger(L, p->to_int());
            break;
        }
        case Param::TYPE_STRING: {
            lua_pushstring(L, p->to_string());
            break;
        }
        case Param::TYPE_INT_ARRAY: {
            break;
        }
        case Param::TYPE_STRING_ARRAY: {
            break;
        }
        }
    }
    return in_num;
}

int c_rpc(lua_State* L) {
    const char* func_name = lua_tostring(L, -1);
    ParamList pl;
    lua_pushnil(L);
    while (lua_next(L, -3) != 0)
    {
        lua_to_param(&pl);
        lua_pop(L, 1);
    }
    ClientSyner* syner = lua_context.player->syner;
    syner->_rpc(func_name, &pl);
    return 0;
}

int c_update_progress(lua_State* L)
{
    int story_idx=0, space_idx=0, chapter_idx=0, action_idx=0;
    lt(story_idx, space_idx, chapter_idx, action_idx);
    StoryProgress* progress = lua_context.player->current;
    progress->story_idx = story_idx;
    progress->space_idx = space_idx;
    progress->chapter_idx = chapter_idx;
    progress->action_idx = action_idx;
    return 0;
}

#define REG_LUA(name) \
    lua_pushcfunction(L, name); \
    lua_setglobal(L, #name);

void register_lua() {
    REG_LUA(c_rpc);
    REG_LUA(c_update_progress);
}
