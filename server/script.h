#ifndef SCRIPT_H
#define SCRIPT_H

extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}

extern lua_State* L;

void load_lua_file(const char* name);
void log_lua_error();
void init_lua();
bool lua_isarray(int index);
const int* lua_toint_array(int index, int& len);
int lua_array_length(int index);
int lua_table_size(int index);

template<class T>
void push_one(T t);

template<>
inline void push_one<int>(int t) {
    lua_pushinteger(L, t);
};

template<>
inline void push_one<const char*>(const char* t) {
    lua_pushstring(L, t);
};

template<class T>
void lua_push_params(T t) {
    push_one(t);
};

template<class T, class ...ARGS>
void lua_push_params(T t, ARGS ...args) {
    push_one(t);
    lua_push_params(args...);
};

extern char* luaerror;

void luaerrorcall(int num_in, int num_out);

template<class ...ARGS>
void lc(const char* method_name, int num_out, ARGS ...args) {
    lua_getglobal(L, method_name);
    lua_push_params(args...);
    luaerrorcall(sizeof...(args), num_out);
};

inline void lc(const char* method_name, int num_out) {
    lua_getglobal(L, method_name);
    luaerrorcall(0, num_out);
};

template<class T>
void to_one(T& t);

template<>
inline void to_one<int>(int& t) {
    t = lua_tointeger(L, -1);
    lua_pop(L, 1);
};

template<>
inline void to_one<const char*>(const char*& t) {
    t = lua_tostring(L, -1);
    lua_pop(L, 1);
};

template<class T>
void to_params(T& t) {
    to_one(t);
};

template<class T, class ...ARGS>
void to_params(T& t, ARGS ...args) {
    to_one(t);
    to_params(args...);
};

template<class ...ARGS>
void lr(ARGS ...args) {
    to_params(args...);
    //    lua_pop(L, sizeof...(args));
};



#endif
