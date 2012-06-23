#ifndef CLIENT_H
#define CLIENT_H

#include <map>
using namespace std;

#include "ParamListSend.h"
#include "IDataReceiver.h"

class Tunnel;
class TunnelOutputStream;
class TunnelInputStream;
class Player;

class ClientSyner: public IDataReceiver {
public:
    ClientSyner();
    ~ClientSyner();
private:
    Tunnel* _tunnel;

public:
    static const short COMMAND_RPC = 1;
    static const short COMMAND_GROUP_START = 2;
    static const short COMMAND_GROUP_ROC = 3;
    static const short COMMAND_GROUP_END = 4;
    static const short COMMAND_ROC = 7;
    static const short COMMAND_LUA_RPC = 8;
    static const short COMMAND_TEST = 9;

    static const short COMMAND_QUERY = 10;
    static const short COMMAND_QUERY_SUCCESS = 11;

public:
    TunnelOutputStream* get_command_stream(short id);
    virtual void on_connect(Tunnel* tunnel);
    virtual void on_data(TunnelInputStream* stream);
    virtual void on_disconnect(Tunnel* tunnel);

public:
    void rpc(const char* method_name) {
        ParamListSend* params = get_params_send(method_name, 0);
        _send(params);
    };
    template<class ...ARGS>
    void rpc(const char* method_name, ARGS ...args) {
        ParamListSend* params = get_params_send(method_name, sizeof...(args));
        params->push_params(args...);
        _send(params);
    };

    void query_success(int qid) {
        ParamListSend* params = get_query_result(qid, 0);
        _send(params);
    };
    template<class ...ARGS>
    void query_success(int qid, ARGS ...args) {
        ParamListSend* params = get_query_result(qid, sizeof...(args)+1);
        params->push_params(args...);
        _send(params);
    };

private:
    void _send(ParamListSend* params);
    void _rpc_recv(TunnelInputStream* stream);

// public:
//     void group_start(ParamList* key, const char* method_name) {
//         ParamList params;
//         _command(COMMAND_GROUP_START, key, method_name, &params);
//     };
//     template<class ...ARGS>
//     void group_start(ParamList* key, const char* method_name, ARGS ...args) {
//         ParamList params(args...);
//         _command(COMMAND_GROUP_START, key,  method_name, &params);
//     };

// public:
//     void group_end(ParamList* key, const char* method_name) {
//         ParamList params;
//         _command(COMMAND_GROUP_START, key, method_name, &params);
//     };
//     template<class ...ARGS>
//     void group_end(ParamList* key, const char* method_name, ARGS ...args) {
//         ParamList params(args...);
//         _command(COMMAND_GROUP_START, key,  method_name, &params);
//     };

public:
    ParamListSend*  get_params_send(const char* method_name, int num);
    ParamListSend*  get_query_result(int qid, int num);

public:
    Player* player;
};

#endif
