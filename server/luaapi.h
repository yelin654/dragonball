#ifndef LUAAPI_H
#define LUAAPI_H

class Player;
class ParamList;

class LuaContext {
public:
    LuaContext() {
        player = NULL;
    };

    Player* player;
};

void register_lua();

void lua_to_param(ParamList*);

int lua_push_params(ParamList*);

extern LuaContext lua_context;

#endif
