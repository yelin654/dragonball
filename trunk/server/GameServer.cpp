#include "GameServer.h"
#include "GameClient.h"
#include "ClientSyner.h"
#include "Log.h"

DEFINE_GAME_OBJECT(GameServer)

GameServer* server = new GameServer;

void GameServer::login(char* name) {
    debug("login name:%s", name);
    ParamList key("Client");
    _invoke_from->rpc(&key, "loginR", 1);
}


