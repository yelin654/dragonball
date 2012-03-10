#include "Stream.h"
#include "Param.h"
#include "script.h"

char string_buf[64];

void push_param(Stream* stream) {
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

void dispatch_lua_rpc(Stream* stream) {
    stream->read_string(string_buf);
    lua_getglobal(L, string_buf);
    int num = stream->read_byte();
    for (int i = 0; i < num; ++i) {
        push_param(stream);
    }
    luaerrorcall(num, 0);
}
