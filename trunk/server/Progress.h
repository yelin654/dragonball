#ifndef PROGRESS_H
#define PROGRESS_H

#include "GameObject.h"

class Progress:public GameObject {
    DECLARE_GAME_OBJECT(Progress, GameObject)
public:
    virtual void serialize(Stream* stream);
    virtual void unserialize(Stream* stream);

    int story_idx;
    int space_idx;
    int chapter_idx;
    int action_idx;
    int offset;
};

#endif
