#ifndef GAMESEVER_H
#define GAMESEVER_H

#include "GameObject.h"
#include "Service.h"

class GameClient;

class GameServer: public Service {
    DECLARE_GAME_OBJECT(GameServer, Service)
public:
    GameServer(){};
    virtual const ParamList* find_key() {return NULL;};

public:
    void login(char* name);
    void enter_story(char* owner, int idx);
};

extern GameServer* server;

void enter_story(int qid, const char* owner, int idx);

#endif
