#ifndef EDITORSERVICE_H
#define EDITORSERVICE_H


#include "GameObject.h"
#include "Service.h"

class EditorService: public Service {
    DECLARE_GAME_OBJECT(EditorService, Service)
public:
    void login(const char* name);
    void loadMetaWork(const char* name);
    void saveMetaWork(const char* name, const ByteArray* bytes);
    void loadStory(const char* name, int idx);
};

extern EditorService* editor_service;

#endif
