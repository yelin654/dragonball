#ifndef GAMESEVER_H
#define GAMESEVER_H

#include "ILocal.h"
#include "GameObject.h"

class GameClient;

class GameServer: public GameObject, public ILocal {
    DECLARE_GAME_OBJECT(GameServer, GameObject)
public:
    GameServer(){};
    virtual const ParamList* find_key() {return NULL;};
    virtual void on_connect(ISynchronizer* syn) {};
    virtual void on_disconnect(ISynchronizer* syn) {};

public:
    void login(char* name);
};

extern GameServer* server;

#endif
