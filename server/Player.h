#ifndef PLAYER_H
#define PLAYER_H

#include <list>
using namespace std;

#include "GameObject.h"

class LuaStory;
class Stream;

class Player: public GameObject {
    DECLARE_GAME_OBJECT(Player, GameObject)
};

#endif
