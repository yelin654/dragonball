#ifndef PLAYER_H
#define PLAYER_H

#include <stdio.h>

#include <list>
#include <map>
using namespace std;

#include "GameObject.h"

class StoryProgress;
class ClientSyner;

class Player: public GameObject {
    DECLARE_GAME_OBJECT(Player, GameObject)

public:
    Player():current(NULL), log(NULL){};
    virtual ~Player();

private:
    map<int, StoryProgress*> _progress;
public:
    StoryProgress* current;

public:
    void continue_story(int idx);
    void start_story(int idx);
public:
    ClientSyner* syner;
    string name;
    FILE* log;
};

extern map<string, Player*> G_players;

#endif
