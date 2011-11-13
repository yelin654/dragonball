#ifndef ITUNNELFACTORY_H
#define ITUNNELFACTORY_H

#include "Tunnel.h"

class ITunnelFactory {
public:
    virtual Tunnel* create_tunnel(int fd)=0;
    virtual void destroy(Tunnel* tunnel)=0;
};


#endif
