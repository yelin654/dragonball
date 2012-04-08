#include "Service.h"
#include "ClientSyner.h"
#include "Tunnel.h"
#include "ParamListSend.h"

DEFINE_GAME_OBJECT(Service)

void Service::invoke_method_from(ClientSyner* syner, const string& name, ParamList* params) {
    _invoke_from = syner;
    Param* p = params->shift();
    qid = p->to_int();
    invoke_service_method(name, params);
    delete p;
}

inline void Service::invoke_service_method(const string& name, ParamList* params)
{
    //invoke_method(name, params);
}

void Service::success(ParamList* result) {
    ParamList key("Client");
    Param* id = new Param(qid);
    result->unshift(id);
    _invoke_from->_roc(&key, "querySuccess", result);
}

void Service::failed(ParamList* reason) {
    ParamList key("Client");
    Param* id = new Param(qid);
    reason->unshift(id);
    _invoke_from->_roc(&key, "queryFailed", reason);
}

TunnelOutputStream* Service::get_success_stream() {
    TunnelOutputStream* stream = _invoke_from->get_command_stream(ClientSyner::COMMAND_ROC);
    g_pls->attach(stream, 1);
    g_pls->push("Client");
    stream->write_string("querySuccess");
    return stream;
}
