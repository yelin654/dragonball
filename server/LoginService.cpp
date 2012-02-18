#include "LoginService.h"
#include "Log.h"
#include "ClientSyner.h"
#include "Player.h"

DEFINE_GAME_OBJECT(LoginService)

LoginService* login_service = new LoginService;

void LoginService::login(const char* name) {
    debug("login, name(%s)", name);
    Player* player = new Player();
    player->name = name;
    _invoke_from->player = player;
    G_players[name] = player;
    ParamList result;
    success(&result);
}


