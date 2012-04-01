#include "string.h"

#include "ObjectFinder.h"
#include "Object.h"
#include "Param.h"
#include "GameServer.h"
#include "GameClient.h"
#include "EditorService.h"
#include "LoginService.h"

IObjectFinder* finder = new ObjectFinder();

//void* fcontext;

ObjectFinder::ObjectFinder() {
    //    _finders["Character"] = &ObjectFinder::find_character;
    //    _finders["GUI"] = &ObjectFinder::find_gui;
}

Object* ObjectFinder::find(ParamList* key) {
    const char* name = key->at(0)->to_string();
    if (0 == strcmp(name, "GameServer"))
        return ::server;
    //    if (0 == strcmp(name, "GameClient"))
    //        return (GameClient*)fcontext;
    if (0 == strcmp(name, "LoginService"))
        return ::login_service;
    if (0 == strcmp(name, "EditorService"))
        return ::editor_service;
    if (0 == strcmp(name, "Service"))
        return ::login_service;
    return NULL;
    //    return (this->*_finders[className])(key);
}

// Object* ObjectFinder::find_character(const ParamList& params) {
//     return NULL;
// }

// Object* ObjectFinder::find_gui(const ParamList& params) {
//     const char* name = params.at(0).to_string();
//     Character* ch = Character::find_by_name(name);
//     return ch->ui;
//     return NULL;
// }
