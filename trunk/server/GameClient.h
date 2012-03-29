#ifndef GAMECLIENT_H
#define GAMECLIENT_H

#include "GameObject.h"
#include "IRemote.h"

class ClientSyner;
class ISynchronizer;

class GameClient: public GameObject {
    DECLARE_GAME_OBJECT(GameClient, GameObject)
public:
    GameClient();
    virtual void serialize(OutputStream* stream);
    virtual void unserialize(InputStream* stream);
    virtual const ParamList* find_key() {return NULL;};

    char* name;
    int pw;

public:
    ClientSyner* syner;

};

#endif
