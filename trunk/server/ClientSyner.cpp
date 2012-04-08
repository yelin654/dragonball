#include <string.h>
#include <stdio.h>

#include "ClientSyner.h"
#include "InputStream.h"
#include "Tunnel.h"
#include "Log.h"
#include "dispatch_rpc.h"
#include "Player.h"
#include "rpc.h"

ParamListRecv* g_plr = new ParamListRecv();

ClientSyner::ClientSyner() {
    player = NULL;
}

ClientSyner::~ClientSyner() {
    if (NULL != player) {
        if (NULL != player->log) {
            fclose(player->log);
        }
        delete player;
    }
}

TunnelOutputStream* ClientSyner::get_command_stream(short id) {
    TunnelOutputStream* stream = _tunnel->get_output_stream();
    stream->write_short(id);
    return stream;
}

void ClientSyner::on_connect(Tunnel* tunnel) {
    _tunnel = tunnel;
}

void ClientSyner::on_disconnect(Tunnel* tunnel) {

}

void ClientSyner::on_data(TunnelInputStream* stream) {
    //fcontext = client;
    short command = stream->read_short();
    switch (command) {
    case COMMAND_RPC:
        _rpc_recv(stream);
        break;
    case COMMAND_LUA_RPC:
        dispatch_lua_rpc(stream, player);
        break;
    case COMMAND_TEST:
        handle_test(stream);
        break;
    default:
        error("unknown command %d\n", command);
    }
}

void ClientSyner::_rpc_recv(TunnelInputStream* stream) {
    const char* method = stream->read_string();
    g_plr->attach(stream);
    rpc_context->from = this;
    call_func(method, g_plr);
}

ParamListSend*  ClientSyner::get_params_send(const char* name, int num) {
    TunnelOutputStream* stream = get_command_stream(COMMAND_RPC);
    stream->write_string(name);
    g_pls->attach(stream, num);
    return g_pls;
}

ParamListSend*  ClientSyner::get_query_result(int qid, int num) {
    TunnelOutputStream* stream = get_command_stream(COMMAND_QUERY_SUCCESS);
    stream->write_int(qid);
    g_pls->attach(stream, num);
    return g_pls;
}

void ClientSyner::_send(ParamListSend* params) {
    TunnelOutputStream* stream = dynamic_cast<TunnelOutputStream*>(params->stream);
    if (NULL != stream) {
        stream->flush();
    } else {
        error("...");
    }
}
