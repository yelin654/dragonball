#ifndef LUAAPI_H
#define LUAAPI_H

class Player;
class ParamList;
class Stream;
class ParamListSend;

class LuaContext {
public:
    LuaContext() {
        player = NULL;
    };

    Player* player;
};

void register_lua();

void lua_read_param(int index, ParamListSend* params);

int lua_push_params(ParamList*);

extern LuaContext lua_context;

#endif
