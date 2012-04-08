#include "rpc.h"
#include "Log.h"

cstr_map METHOD_INDEX;

RPCContext* rpc_context = new RPCContext;

void call_func(const char* name, ParamListRecv* pl)
{
    cstr_map::iterator ite = METHOD_INDEX.find(name);
    if (METHOD_INDEX.end() != ite) {
        ite->second(*pl);
    } else {
        error("call unregistor method %s", name);
    }
}


