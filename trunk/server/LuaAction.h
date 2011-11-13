#ifndef LUAACTION_H
#define LUAACTION_H

#include "script.h"
#include "GameObject.h"

class LuaAction:public GameObject {
    //    DECLARE_GAME_OBJECT(LuaAction, GameObject)
public:
    int idx;

public:
    virtual void on_start()=0;
    virtual void on_end()=0;
    virtual void on_update()=0;

public:
    int next;
    int story_idx;
    int space_idx;

private:
};

#endif
