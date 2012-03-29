#include <stdio.h>
#include <string.h>

#include "EditorService.h"
#include "common.h"
#include "ClientSyner.h"
#include "Log.h"
#include "script.h"

DEFINE_GAME_OBJECT(EditorService)

EditorService* editor_service = new EditorService;

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
    lc("load_story", 0, name, idx);
}
