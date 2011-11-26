#include <stdio.h>
#include <string.h>

#include "EditorService.h"
#include "Stream.h"
#include "common.h"
#include "PlayerWorks.h"
#include "ClientSyner.h"
#include "Log.h"
#include "luastory.h"

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

void EditorService::success(ParamList* result) {
    ParamList key("EditorClient");
    Param* id = new Param(qid);
    result->unshift(id);
    _invoke_from->_rpc(&key, "querySuccess", result);
}

void EditorService::failed(int reason) {
    ParamList key("EditorClient");
    ParamList result(qid, reason);
    _invoke_from->_rpc(&key, "queryResult", &result);
}

void EditorService::login(const char* name) {
    debug("login, name(%s)", name);
    ParamList result;
    success(&result);
}

void EditorService::loadMetaWork(const char* name) {
    char filename[64]; bzero(filename, 64);
    sprintf(filename, "db/%s/metawork", name);
    int size; char* buf;
    load_file(buf, size, filename);
    ByteArray bytes(buf, size);
    ParamList result(&bytes);
    success(&result);
    delete [] buf;
}

void EditorService::saveMetaWork(const char* name, const ByteArray* bytes) {
    char filename[64]; bzero(filename, 64);
    sprintf(filename, "db/%s/metawork", name);
    save_file(bytes->data, bytes->length, filename);
    debug("save file, length(%d)", bytes->length);
    ParamList result(1);
    success(&result);
}

void EditorService::loadStory(const char* name, int idx) {
    load_story(name, idx);
}
