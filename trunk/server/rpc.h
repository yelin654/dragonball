#ifndef RPC_H
#define RPC_H

#include "generation.h"
#include "ParamListRecv.h"
#include "stlite.h"

typedef void (*METHOD)(ParamListRecv& params);

typedef map<const char*, METHOD, c_str_less> cstr_map;

extern cstr_map METHOD_INDEX;

#define GEN_TEMPLATE(n) \
template<class Method, Method method GEN_TYPE(n)>       \
void call(ParamListRecv& params) { \
    (*method)(GEN_PARAM(n));   \
}

#define GEN_SYN_0 GEN_TEMPLATE(0)
#define GEN_SYN_1 GEN_SYN_0;GEN_TEMPLATE(1)
#define GEN_SYN_2 GEN_SYN_1;GEN_TEMPLATE(2)
#define GEN_SYN_3 GEN_SYN_2;GEN_TEMPLATE(3)
#define GEN_SYN_4 GEN_SYN_3;GEN_TEMPLATE(4)
#define GEN_SYN_5 GEN_SYN_4;GEN_TEMPLATE(5)
#define GEN_SYN_6 GEN_SYN_5;GEN_TEMPLATE(6)
#define GEN_SYN_7 GEN_SYN_6;GEN_TEMPLATE(7)
#define GEN_SYN_8 GEN_SYN_7;GEN_TEMPLATE(8)
#define GEN_SYN(n) GEN_SYN_##n

GEN_SYN(8)

#define REG_RPC(Method, ...) \
typedef void (*__##Method)(__VA_ARGS__); \
METHOD_INDEX[#Method] = &call< __##Method, Method, ##__VA_ARGS__ >;

void call_func(const char* name, ParamListRecv* pl);

class ClientSyner;

class RPCContext {
public:
    ClientSyner* from;
};

extern RPCContext* rpc_context;

#endif
