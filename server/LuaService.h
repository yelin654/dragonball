#ifndef LUASERVICE_H
#define LUASERVICE_H

#include "GameObject.h"
#include "Service.h"

class LuaService: public Service {
    DECLARE_GAME_OBJECT(LuaService, Service)
public:
    virtual void invoke_service_method(const string& name, ParamList* params);
};

extern LuaService* lua_service;

#endif
