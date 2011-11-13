#ifndef LUATALK_H
#define LUATALK_H

#include "LuaAction.h"

class LuaTalk: public LuaAction {
    DECLARE_GAME_OBJECT(LuaTalk, GameObject)
public:
    virtual void serialize(Stream* stream);
    virtual void unserialize(Stream* stream);

public:
    virtual void on_start();
    virtual void on_end();
    virtual void on_update();
    void load();
};

#endif
