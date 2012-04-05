#include <string.h>

#include "InputStream.h"
#include "Param.h"
#include "script.h"
#include "luaapi.h"
#include "Log.h"
#include "Tunnel.h"

char string_buf[64];

void push_param(InputStream* stream) {
    int type = stream->read_byte();
    switch (type) {
        case Param::TYPE_INT: {
            lua_pushinteger(L, stream->read_int());
            break;
        }
        case Param::TYPE_STRING: {
            stream->read_string(string_buf);
            lua_pushstring(L, string_buf);
            break;
        }
    }
}

void dispatch_lua_rpc(InputStream* stream, Player* player) {
    lua_context.player = player;
    bzero(string_buf, 64);
    stream->read_string(string_buf);
    debug("begin to call lua rpc %s", string_buf);
    lua_getglobal(L, string_buf);
    int num = stream->read_byte();
    for (int i = 0; i < num; ++i) {
        push_param(stream);
    }
    luaerrorcall(num, 0);
}

void handle_test(TunnelInputStream* in) {
    Tunnel* tunnel = in->tunnel;
    TunnelOutputStream* out = tunnel->get_output_stream(4);
    out->write_short(9);
    out->write_bytes(in->ri, in->available());
    out->flush();
}
