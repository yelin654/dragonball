#include "ClientTunnelFactory.h"
#include "ClientSyner.h"


Tunnel* ClientTunnelFactory::create_tunnel(int fd) {
    return new Tunnel(fd, new ClientSyner());
};

void ClientTunnelFactory::destroy(Tunnel* tunnel) {
    delete tunnel->receiver;
    delete tunnel;
};
