#include <stdio.h>
#include <string.h>

#include "EditorService.h"
#include "Stream.h"
#include "common.h"
#include "PlayerWorks.h"
#include "ClientSyner.h"

DEFINE_GAME_OBJECT(EditorService)

EditorService* editor_service = new EditorService;

void EditorService::invoke_method_from(ClientSyner* syner, const string& name, ParamList* params) {
    _invoke_from = syner;
    Param* p = params->shift();
    qid = p->to_int();
    invoke_method(name, params);
    delete p;
}

void EditorService::response(ParamList* result) {
    ParamList key("EditorClient");
    Param* id = new Param(qid);
    result->unshift(id);
    _invoke_from->_rpc(&key, "queryResult", result);
}

void EditorService::login(const char* name) {
    ParamList result(1);
    response(&result);
}

void EditorService::loadMetaWork(int qid, const char* name) {
    char filename[64]; bzero(filename, 64);
    sprintf(filename, "db/%s/story", name);
    int size; char* buf;
    load_file(buf, size, filename);
    Stream s(buf, size);
    PlayerWorks* meta = new PlayerWorks();
    meta->unserialize(&s);
    meta->pass_as_reference = false;
    ParamList key("EditorClient");
    ParamList result(qid, meta);
    _invoke_from->_rpc(&key, "queryResult", &result);
}

void EditorService::saveMetaWork(int qid, const char* name, const ByteArray* bytes) {
    // char filename[64]; bzero(filename, 64);
    // sprintf(filename, "db/%s/story", name);
    // save_file(bytes->data, bytes->length, filename);
    ParamList result(1);
    response(&result);

    // ParamList key("EditorClient");
    // ParamList result(qid, 1);
    // _invoke_from->_rpc(&key, "queryResult", &result);
}



