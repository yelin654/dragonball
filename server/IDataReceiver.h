#ifndef IDATARECEIVER_H
#define IDATARECEIVER_H

class Tunnel;
class TunnelInputStream;

class IDataReceiver {
public:
    virtual void on_connect(Tunnel* tunnel)=0;
    virtual void on_data(TunnelInputStream* stream)=0;
    virtual void on_disconnect(Tunnel* tunnel)=0;
};

#endif
