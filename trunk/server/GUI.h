#ifndef GUI_H
#define GUI_H

#include "Event.h"

class GUI: public EventDispatcher {
    DECLARE_GAME_OBJECT(GUI, EventDispatcher)
public:
    GUI(){};
};

#endif
