#ifndef LOGINSERVICE_H
#define LOGINSERVICE_H

#include "GameObject.h"
#include "Service.h"

class LoginService: public Service {
    DECLARE_GAME_OBJECT(LoginService, Service)
public:
    void login(const char* name);
};

extern LoginService* login_service;

void login(int qid, const char* name);

#endif
