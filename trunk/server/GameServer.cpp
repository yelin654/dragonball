#include "GameServer.h"
#include "GameClient.h"
#include "ClientSyner.h"
#include "Log.h"
#include "Player.h"
#include "StoryProgress.h"
#include "script.h"
#include "luaapi.h"

DEFINE_GAME_OBJECT(GameServer)

GameServer* server = new GameServer;

void GameServer::login(char* name) {
    debug("login name:%s", name);
    ParamList key("Client");
    _invoke_from->roc(&key, "loginR", 1);
}

void find_progress(char* name, int idx) {

}

void GameServer::enter_story(char* owner, int idx) {
    ParamList result;
    success(&result);
    Player* player = _invoke_from->player;
    player->current = new StoryProgress();
    lua_context.player = player;
    lc("start_story", 0, idx);
}
