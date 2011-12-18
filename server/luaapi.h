#ifndef LUAAPI_H
#define LUAAPI_H

class Player;

class LuaContext {
public:
    LuaContext() {
        player = NULL;
    };

    Player* player;
};

void register_lua();

extern LuaContext lua_context;

#endif
