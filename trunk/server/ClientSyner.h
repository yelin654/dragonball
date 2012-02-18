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
class Player;

class ClientSyner: public IDataReceiver {
public:
    ClientSyner();
    ~ClientSyner();
    GameClient* client;
private:
    Tunnel* _tunnel;

public:
    static const short COMMAND_RPC = 1;
    static const short COMMAND_GROUP_START = 2;
    static const short COMMAND_GROUP_ROC = 3;
    static const short COMMAND_GROUP_END = 4;
    static const short COMMAND_NEW_INSTANCE = 5;
    static const short COMMAND_DISPATCH_EVENT = 6;
    static const short COMMAND_ROC = 7;

public:
    TunnelOutputStream* get_command_stream(short id, int size);
    virtual void on_connect(Tunnel* tunnel);
    virtual void on_data(TunnelInputStream* stream);
    virtual void on_disconnect(Tunnel* tunnel);

public:
    void roc(GameObject* object, const char* method_name) {
        ParamList params;
        _roc(object, method_name, &params);
    };
    template<class ...ARGS>
    void roc(GameObject* object, const char* method_name, ARGS ...args) {
        ParamList params(args...);
        _roc(object,  method_name, &params);
    };
protected:
    void _roc(GameObject* object, const char* method_name, ParamList* params);

public:
    void roc(ParamList* key, const char* method_name) {
        ParamList params;
        _roc(key, method_name, &params);
    };
    template<class ...ARGS>
    void roc(ParamList* key, const char* method_name, ARGS ...args) {
        ParamList params(args...);
        _roc(key,  method_name, &params);
    };
public:
    void _roc(ParamList* key, const char* method_name, ParamList* params);


public:
    void rpc(const char* method_name) {
        ParamList params;
        _rpc(method_name, &params);
    };
    template<class ...ARGS>
    void rpc(const char* method_name, ARGS ...args) {
        ParamList params(args...);
        _rpc(method_name, &params);
    };
public:
    void _rpc(const char* method_name, ParamList* params);


public:
    void _command(int id, ParamList* key, const char* method_name, ParamList* params);

public:
    void group_start(ParamList* key, const char* method_name) {
        ParamList params;
        _command(COMMAND_GROUP_START, key, method_name, &params);
    };
    template<class ...ARGS>
    void group_start(ParamList* key, const char* method_name, ARGS ...args) {
        ParamList params(args...);
        _command(COMMAND_GROUP_START, key,  method_name, &params);
    };

public:
    void group_end(ParamList* key, const char* method_name) {
        ParamList params;
        _command(COMMAND_GROUP_START, key, method_name, &params);
    };
    template<class ...ARGS>
    void group_end(ParamList* key, const char* method_name, ARGS ...args) {
        ParamList params(args...);
        _command(COMMAND_GROUP_START, key,  method_name, &params);
    };

private:
    void invoke_method_recv(TunnelInputStream* stream);


public:
    Player* player;
};

#endif
