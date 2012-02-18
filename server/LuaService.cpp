#include "LuaService.h"
#include "script.h"
#include "luaapi.h"

DEFINE_GAME_OBJECT(LuaService)

void LuaService::invoke_service_method(const string& name, ParamList* params)
{
    Param* p = params->shift();
    lua_getglobal(L, name.c_str());
    int in_num = lua_push_params(params);
    int out_num = p->to_int();
    delete p;

    ParamList result;

    if (lua_pcall(L, in_num, out_num, 0) != 0)
    {
        p = new Param(lua_tostring(L, -1), true);
        result.push(p);
        failed(&result);
        lua_pop(L, 1);
    }
    else
    {
        for (int i = 0; i < out_num; i++)
        {
            lua_to_param(&result);
        }
        success(&result);
        lua_pop(L, out_num);
    }
}
