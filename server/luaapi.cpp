#include "script.h"
#include "Param.h"
#include "luaapi.h"
#include "ClientSyner.h"
#include "Player.h"
#include "Array.h"
#include "StoryProgress.h"
#include "stlite.h"
#include "Stream.h"
#include "Tunnel.h"
#include "ParamListSend.h"

LuaContext lua_context;

void update_lua_progress(StoryProgress* p)
{
    lc("lua_update_progress", p->story_idx, p->space_idx,
       p->chapter_idx, p->action_idx);
}

void lua_read_table(int index, ParamListSend* params) {
    int size = lua_table_size(index);
    params->stream->write_bytes(&size, 1);
    lua_pushnil(L);
    int i = index - 1;
    while (lua_next(L, i) != 0)
    {
        lua_read_param(-2, params);
        lua_read_param(-1, params);
        lua_pop(L, 1);
    }
}

void lua_read_param(int index, ParamListSend* params) {
    int type = lua_type(L, index);
    //int len;
    //const int* arr_int;
    switch (type) {
    case LUA_TSTRING: {
        params->push(lua_tostring(L, index));
        break;
    }
    case LUA_TNUMBER: {
        params->push(lua_tointeger(L, index));
        break;
    }
    case LUA_TTABLE: {
        //        if (lua_isarray(-1)) {
        //            arr_int = lua_toint_array(-1, len);
        //            params->push(arr_int, len);
        //        } else {
        params->stream->write_byte(Param::TYPE_LUA_TABLE);
        lua_read_table(index, params);
        //        }
        break;
    }
    default: {
        params->push(0);
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
    const char* func_name = lua_tostring(L, -2);
    ClientSyner* syner = lua_context.player->syner;
    TunnelOutputStream* stream = syner->get_command_stream(ClientSyner::COMMAND_RPC, sizeof(func_name));
    stream->write_string(func_name);
    int len = lua_array_length(-1);
    g_pls->attach(stream, len);
    lua_pushnil(L);
    while (lua_next(L, -2) != 0)
    {
        lua_read_param(-1, g_pls);
        lua_pop(L, 1);
    }
    stream->flush();
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
