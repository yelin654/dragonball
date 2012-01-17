#include "LoginService.h"
#include "Log.h"

DEFINE_GAME_OBJECT(LoginService)

LoginService* login_service = new LoginService;

void LoginService::login(const char* name) {
    debug("login, name(%s)", name);
    ParamList result;
    success(&result);
}


