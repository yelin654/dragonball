#include "Tunnel.h"

class ClientEventDispatcher;
class RPC;

class RPCReceiver {
public:
    static const int SEND_OBJECT = 1;
    static const int RPC_EVENT = 2;
    static const int RPC_METHOD = 3;

    ClientEventDispatcher* _client_event_dispatcher;
    void handle(const RPC& rpc);
private:
    void handle_event(const RPC& rpc);
};
