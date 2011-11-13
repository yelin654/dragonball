#ifndef CLIENTTUNNELFACTORY_H
#define CLIENTTUNNELFACTORY_H

#include "ITunnelFactory.h"

class ClientTunnelFactory: public ITunnelFactory {

public:
    virtual Tunnel* create_tunnel(int fd);
    virtual void destroy(Tunnel* tunnel);
};

#endif
