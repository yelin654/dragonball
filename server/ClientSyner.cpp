#include <string.h>

#include "ClientSyner.h"
#include "Stream.h"
#include "GameObject.h"
#include "Object.h"
#include "IObjectFinder.h"
#include "Tunnel.h"
#include "GameClient.h"

ClientSyner::ClientSyner() {
    client = new GameClient();
    client->syner = this;
}

ClientSyner::~ClientSyner() {
    delete client;
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
    object->invoke_method_from(this, name, &params);

    delete [] name;
}

void ClientSyner::_rpc(GameObject* object, const char* method_name, ParamList* params) {
    const Stream* key = object->key();
    int size = key->length() + strlen(method_name);
    TunnelOutputStream* stream = get_command_stream(COMMAND_INVOKE_METHOD, size);
    stream->copy(key);
    stream->write_string(method_name);
    params->serialize(stream);
    stream->flush();
}

void ClientSyner::_rpc(ParamList* key, const char* method_name, ParamList* params) {
    int size = key->size() + strlen(method_name);
    TunnelOutputStream* stream = get_command_stream(COMMAND_INVOKE_METHOD, size);
    key->serialize(stream);
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
    fcontext = client;
    short command = stream->read_short();
    switch (command) {
    case COMMAND_INVOKE_METHOD:
        invoke_method_recv(stream);
        break;
    default:
        printf("unknown command %d\n", command);
    }
}
