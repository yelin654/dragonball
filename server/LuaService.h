#ifndef LUASERVICE_H
#define LUASERVICE_H

#include "GameObject.h"
#include "Service.h"

class LuaQuery: public Service {
    DECLARE_GAME_OBJECT(LuaQuery, Service)
public:
    virtual void invoke_service_method(const string& name, ParamList* params);
};

extern LuaQuery* lua_query;


class LuaRPC: public Service {
    DECLARE_GAME_OBJECT(LuaRPC, Service)
public:
    virtual void invoke_service_method(const string& name, ParamList* params);
};

extern LuaRPC* lua_rpc;

#endif
