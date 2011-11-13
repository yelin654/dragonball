#ifndef CLIENT_H
#define CLIENT_H

#include <map>
using namespace std;

#include "Param.h"
#include "GameObject.h"
#include "IDataReceiver.h"

class Tunnel;
class TunnelOutputStream;
class TunnelInputStream;
class IObjectFinder;
class GameClient;

class ClientSyner: public IDataReceiver {
public:
    ClientSyner();
    ~ClientSyner();
    GameClient* client;
private:
    Tunnel* _tunnel;

public:
    static const short COMMAND_INVOKE_METHOD = 1;
    static const short COMMAND_NEW_INSTANCE = 2;
    static const short COMMAND_DISPATCH_EVENT = 3;

public:
    TunnelOutputStream* get_command_stream(short id, int size);
    virtual void on_connect(Tunnel* tunnel);
    virtual void on_data(TunnelInputStream* stream);
    virtual void on_disconnect(Tunnel* tunnel);

public:
    void rpc(GameObject* object, const char* method_name) {
        ParamList params;
        _rpc(object, method_name, &params);
    };
    template<class ...ARGS>
    void rpc(GameObject* object, const char* method_name, ARGS ...args) {
        ParamList params(args...);
        _rpc(object,  method_name, &params);
    };
protected:
    void _rpc(GameObject* object, const char* method_name, ParamList* params);

public:
    void rpc(ParamList* key, const char* method_name) {
        ParamList params;
        _rpc(key, method_name, &params);
    };
    template<class ...ARGS>
    void rpc(ParamList* key, const char* method_name, ARGS ...args) {
        ParamList params(args...);
        _rpc(key,  method_name, &params);
    };
public:
    void _rpc(ParamList* key, const char* method_name, ParamList* params);


// public:
//     static void invoke_method_sends(set<ClientSyner*>& clients, GameObject* object, const string method_name) {};
//     template<class ...ARGS>
//     static void invoke_method_sends(set<ClientSyner*>& clients, GameObject* object, const string method_name, ARGS ...args) {};
//     static void _invoke_method_sends(set<ClientSyner*>& clients, GameObject* object, const string method_name, ParamList& params) {};

private:
    void invoke_method_recv(TunnelInputStream* stream);

};

#endif
