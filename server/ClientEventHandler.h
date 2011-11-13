#ifndef CLIENTEVENTHANDLER_H
#define CLIENTEVENTHANDLER_H

#include "Event.h"

class ClientEventListener : public EventListener {
    DECLARE_EVENT_LISTENER(ClientEventListener)
public:
    ClientEventListener(){};
};

#endif
