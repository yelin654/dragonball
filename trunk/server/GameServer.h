#ifndef GAMESEVER_H
#define GAMESEVER_H

#include "ILocal.h"
#include "GameObject.h"
#include "Service.h"

class GameClient;

class GameServer: public Service, public ILocal {
    DECLARE_GAME_OBJECT(GameServer, Service)
public:
    GameServer(){};
    virtual const ParamList* find_key() {return NULL;};
    virtual void on_connect(ISynchronizer* syn) {};
    virtual void on_disconnect(ISynchronizer* syn) {};

public:
    void login(char* name);
    void enter_story(char* owner, int idx);
};

extern GameServer* server;

#endif
