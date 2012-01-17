#ifndef GAMEPROGRESS_H
#define GAMEPROGRESS_H

#include <list>
using namespace std;

#include "GameObject.h"

class Stream;
class StoryProgress;

class GameProgress: public GameObject {
    DECLARE_GAME_OBJECT(GameProgress, GameObject)
public:
    list<StoryProgress*> storys;
    virtual void serialize(Stream* stream);
};

#endif
