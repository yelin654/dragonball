#ifndef RPC_H
#define RPC_H

class Tunnel;
class ParamList;

class RPC {
public:
    RPC(short idx, const ParamList& params);
private:
    short _idx;
    const char* data;
    int data_len;
    Tunnel* tunnel;
};

#endif
