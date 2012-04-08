#include "GameObject.h"

#include "stlite.h"
#include "Tunnel.h"
#include "Log.h"

DEFINE_CLASS(GameObject)

void GameObject::invoke_method(const string& name, const ParamListRecv* params) {
    error("%s has no method %s", class_name(), name.c_str());
}

// void GameObject::_seriailze_method(Stream& stream, const string& name, ParamList& params) {

// }

// void GameObject::_unseriailze_method(Stream& stream, const string& name, ParamList& params) {

// }

// void GameObject::_call_method_local(Stream& stream) {
//     short sh = stream.read_short();
//     char* name = new char[sh+1];
//     stream.read_bytes(name, sh);
//     name[sh] = '\0';
//     ParamList params;
//     params.unserialize(stream);
//     _invoke_method(name, params);
// }

// void GameObject::call_method_remote(const string& name) {
//     ParamList params;
//     _call_mirror_method(name, params);
// }

