#include <string.h>

#include "LoginService.h"
#include "Log.h"
#include "ClientSyner.h"
#include "Player.h"
#include "rpc.h"

DEFINE_GAME_OBJECT(LoginService)

LoginService* login_service = new LoginService;

void LoginService::login(const char* name) {
    debug("login, name(%s)", name);
    Player* player = new Player();
    player->name = name;
    int len = strlen(name) + 5;
    char* filename = new char[len];
    sprintf(filename, "log/%s", name);
    filename[len-1] = '\0';
    player->log = fopen(filename, "a");
    delete [] filename;
    _invoke_from->player = player;
    player->syner = _invoke_from;
    G_players[name] = player;
    ParamList result;
    success(&result);
}

void login(int qid, const char* name) {
    debug("login, name(%s)", name);
    Player* player = new Player();
    player->name = name;
    int len = strlen(name) + 5;
    char* filename = new char[len];
    sprintf(filename, "log/%s", name);
    filename[len-1] = '\0';
    player->log = fopen(filename, "a");
    delete [] filename;
    ClientSyner* syner = rpc_context->from;
    syner->player = player;
    //_invoke_from->player = player;
    player->syner = syner;
    syner->query_success(qid);
    //G_players[name] = player;
    //ParamList result;
    //success(&result);
}
