#include <string.h>
#include <stdio.h>

#include "ClientSyner.h"
#include "InputStream.h"
#include "GameObject.h"
#include "Object.h"
#include "IObjectFinder.h"
#include "Tunnel.h"
#include "Log.h"
#include "dispatch_rpc.h"
#include "Player.h"
#include "rpc.h"

ParamListRecv* g_plr = new ParamListRecv();

ClientSyner::ClientSyner() {
    //    client = new GameClient();
    //client->syner = this;
    player = NULL;
}

ClientSyner::~ClientSyner() {
    //    delete client;
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

void ClientSyner::invoke_method_recv(TunnelInputStream* stream) {
    ParamList* key = new ParamList;
    key->unserialize(stream);
    GameObject* object = dynamic_cast<GameObject*>(finder->find(key));
    delete key;

    short sh = stream->read_short();
    char* name = new char[sh+1];
    stream->read_bytes(name, sh); name[sh] = '\0';
    ParamList params;
    params.unserialize(stream);

    if (NULL == object) {
        error("no object found");
    } else {
        //object->invoke_method_from(this, name, &params);
    }

    delete [] name;
}

void ClientSyner::_roc(GameObject* object, const char* method_name, ParamList* params) {
    error("unuse method");
    TunnelOutputStream* stream = get_command_stream(COMMAND_ROC);
    stream->write_string(method_name);
    params->serialize(stream);
    stream->flush();
}

void ClientSyner::_roc(ParamList* key, const char* method_name, ParamList* params) {
    _command(COMMAND_ROC, key, method_name, params);
}

void ClientSyner::_command(int id, ParamList* key, const char* method_name, ParamList* params) {
    TunnelOutputStream* stream = get_command_stream(id);
    key->serialize(stream);
    stream->write_string(method_name);
    params->serialize(stream);
    stream->flush();
}

void ClientSyner::_rpc(const char* method_name, ParamList* params) {
    TunnelOutputStream* stream = get_command_stream(COMMAND_RPC);
    stream->write_string(method_name);
    params->serialize(stream);
    stream->flush();
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
    case COMMAND_ROC:
        invoke_method_recv(stream);
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
