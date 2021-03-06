#include <string.h>

#include "InputStream.h"
#include "script.h"
#include "luaapi.h"
#include "Log.h"
#include "Tunnel.h"
#include "type.h"

char string_buf[64];

void push_param(InputStream* stream) {
    int type = stream->read_byte();
    switch (type) {
        case TYPE_INT: {
            lua_pushinteger(L, stream->read_int());
            break;
        }
        case TYPE_STRING: {
            const char* str = stream->read_string();
            lua_pushstring(L, str);
            break;
        }
    }
}

void dispatch_lua_rpc(InputStream* stream, Player* player) {
    lua_context.player = player;
    const char* name = stream->read_string();
    debug("begin to call lua rpc %s", name);
    lua_getglobal(L, name);
    int num = stream->read_byte();
    for (int i = 0; i < num; ++i) {
        push_param(stream);
    }
    luaerrorcall(num, 0);
}

void handle_test(TunnelInputStream* in) {
    Tunnel* tunnel = in->tunnel;
    TunnelOutputStream* out = tunnel->get_output_stream();
    out->write_short(9);
    out->write_bytes(in->ri, in->available());
    out->flush();
}

