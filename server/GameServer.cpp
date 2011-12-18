#include "GameServer.h"
#include "GameClient.h"
#include "ClientSyner.h"
#include "Log.h"

DEFINE_GAME_OBJECT(GameServer)

GameServer* server = new GameServer;

void GameServer::login(char* name) {
    debug("login name:%s", name);
    ParamList key("Client");
    _invoke_from->roc(&key, "loginR", 1);
}

void GameServer::enter_story(char* name, int idx) {

}
