#ifndef STORY_H
#define STORY_H

#include "GameObject.h"

class Story:public GameObject {
    DECLARE_GAME_OBJECT(Story, GameObject)
public:
    int idx;
    void a() {};
};

#endif
