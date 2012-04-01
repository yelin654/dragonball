#include <string.h>
#include <stdio.h>

#include "ClientSyner.h"
#include "InputStream.h"
#include "GameObject.h"
#include "Object.h"
#include "IObjectFinder.h"
#include "Tunnel.h"
#include "GameClient.h"
#include "Log.h"
#include "dispatch_rpc.h"
#include "Player.h"

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

TunnelOutputStream* ClientSyner::get_command_stream(short id, int size) {
    TunnelOutputStream* stream = _tunnel->get_output_stream(size + sizeof(id));
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
        object->invoke_method_from(this, name, &params);
    }

    delete [] name;
}

void ClientSyner::_roc(GameObject* object, const char* method_name, ParamList* params) {
    error("unuse method");
    const OutputStream* key = object->key();
    int size = key->length() + strlen(method_name);
    TunnelOutputStream* stream = get_command_stream(COMMAND_ROC, size);
    //stream->copy(key);
    stream->write_string(method_name);
    params->serialize(stream);
    stream->flush();
}

void ClientSyner::_roc(ParamList* key, const char* method_name, ParamList* params) {
    _command(COMMAND_ROC, key, method_name, params);
}

void ClientSyner::_command(int id, ParamList* key, const char* method_name, ParamList* params) {
    int size = key->size() + strlen(method_name);
    TunnelOutputStream* stream = get_command_stream(id, size+2);
    key->serialize(stream);
    stream->write_string(method_name);
    params->serialize(stream);
    stream->flush();
}

void ClientSyner::_rpc(const char* method_name, ParamList* params) {
    int size = strlen(method_name);
    TunnelOutputStream* stream = get_command_stream(COMMAND_RPC, size+2);
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
    case COMMAND_ROC:
        invoke_method_recv(stream);
        break;
    case COMMAND_LUA_RPC:
        dispatch_lua_rpc(stream, player);
        break;
    default:
        error("unknown command %d\n", command);
    }
}
