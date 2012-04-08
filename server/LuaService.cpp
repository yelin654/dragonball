#include "LuaService.h"
#include "script.h"
#include "luaapi.h"
#include "ParamListSend.h"
#include "Tunnel.h"

//void LuaQuery::invoke_service_method(const string& name, ParamList* params)
//{
    // lua_getglobal(L, name.c_str());
    // int in_num = lua_push_params(params);

    // Param* p;
    // ParamList result;
    // if (lua_pcall(L, in_num, 1, 0) != 0)
    // {
    //     p = new Param(lua_tostring(L, -1), true);
    //     result.push(p);
    //     failed(&result);
    //     lua_pop(L, 1);
    //     return;
    // }

    // TunnelOutputStream* stream = get_success_stream();
    // int len = lua_array_length(-1);
    // g_pls->attach(stream, len+1);
    // g_pls->push(qid);
    // lua_pushnil(L);
    // while (lua_next(L, -2) != 0)
    // {
    //     lua_read_param(-1, g_pls);
    //     lua_pop(L, 1);
    // }
    // stream->flush();
//}

//void LuaRPC::invoke_service_method(const string& name, ParamList* params)
//{
    // lua_getglobal(L, name.c_str());
    // int in_num = lua_push_params(params);

    // Param* p;
    // ParamList result;
    // if (lua_pcall(L, in_num, 0, 0) != 0)
    // {
    //     p = new Param(lua_tostring(L, -1), true);
    //     result.push(p);
    //     failed(&result);
    //     lua_pop(L, 1);
    // }
//}
