#ifndef GAMEEVENT_H
#define GAMEEVENT_H

#include "Serializable.h"

class ParamList;

class GameEvent: public Serializable {
public:
    int type;
    ParamList* params;
    GameEvent(){};
    GameEvent(int type, ParamList* params){
        this->type = type;
        this->params = params;
    };
    virtual void serialize(Stream* stream) const;
    virtual void unserialize(Stream* stream);
};

#endif
