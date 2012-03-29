#include "GameClient.h"
#include "ClientSyner.h"
#include "OutputStream.h"
#include "InputStream.h"

DEFINE_GAME_OBJECT(GameClient)

GameClient::GameClient() {
    ParamList pl("GameClient");
    set_key(&pl);
}

void GameClient::unserialize(InputStream* stream) {
    short slen = stream->read_short();
    name = new char[slen];
    stream->read_bytes(name, slen);
    name[slen] = '\0';
    pw = stream->read_int();
}

void GameClient::serialize(OutputStream* stream) {

}
