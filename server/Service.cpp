#include "Service.h"
#include "ClientSyner.h"

DEFINE_GAME_OBJECT(Service)

void Service::invoke_method_from(ClientSyner* syner, const string& name, ParamList* params) {
    _invoke_from = syner;
    Param* p = params->shift();
    qid = p->to_int();
    invoke_method(name, params);
    delete p;
}

void Service::success(ParamList* result) {
    ParamList key("Client");
    Param* id = new Param(qid);
    result->unshift(id);
    _invoke_from->_roc(&key, "querySuccess", result);
}

void Service::failed(int reason) {
    ParamList key("Client");
    ParamList result(qid, reason);
    _invoke_from->_roc(&key, "queryResult", &result);
}

