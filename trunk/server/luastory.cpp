#include "script.h"

void load_story(const char* name, int idx) {
    lc("load", 0, name, idx);
    lc("load", 0);
    //lua_getglobal(L, "load");
    //    lua_pushstring(L,name);
    //    lua_pushinteger(idx);
    //    lua_pcall(
};
