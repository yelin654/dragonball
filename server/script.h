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


template<class T>
void push_one(T t);

template<>
void push_one<int>(int t);

template<>
void push_one<const char*>(const char* t);

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

#endif
