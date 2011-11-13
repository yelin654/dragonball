#ifndef SCRIPT_H
#define SCRIPT_H

extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}

extern lua_State* L;

void init_lua();

void lua_tointeger_array(int index, int num, int* result);


#endif
