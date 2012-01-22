#ifndef SCRIPT_H
#define SCRIPT_H

extern "C" {
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
}

extern lua_State* L;

void init_lua();

void lua_newinteger_array(int index, int& len, int*& result);


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
void push_params(T t) {
    push_one(t);
};

template<class T, class ...ARGS>
void push_params(T t, ARGS ...args) {
    push_one(t);
    push_params(args...);
};

template<class ...ARGS>
void lc(const char* method_name, int num_out, ARGS ...args) {
    lua_getglobal(L, method_name);
    push_params(args...);
    lua_pcall(L, sizeof...(args), num_out, 0);
};

inline void lc(const char* method_name, int num_out) {
    lua_getglobal(L, method_name);
    lua_pcall(L, 0, num_out, 0);
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
void lt(ARGS ...args) {
    to_params(args...);
    //    lua_pop(L, sizeof...(args));
};



#endif
