#ifndef RPCSENDER_H
#define RPCSENDER_H

class Tunnel;

class RPCSender {
    void sync_method(Tunnel* tunnel, Stream& stream);
};

#endif
