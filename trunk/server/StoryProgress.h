#ifndef STORYPROGRESS_H
#define STORYPROGRESS_H

#include "GameObject.h"

class StoryProgress: public GameObject {
    DECLARE_GAME_OBJECT(StoryProgress, GameObject)
public:
    char* name;
    bool has_progress;
    int story_idx;
    int space_idx;
    int chapter_idx;
    int action_idx;
    int offset;
    virtual void serialize(Stream* stream);
};

#endif
