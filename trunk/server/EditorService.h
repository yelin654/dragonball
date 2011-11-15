#ifndef EDITORSERVICE_H
#define EDITORSERVICE_H


#include "GameObject.h"

class ParamList;

class EditorService: public GameObject {
    DECLARE_GAME_OBJECT(EditorService, GameObject)
public:
    virtual void invoke_method_from(ClientSyner* syner, const string& name, ParamList* params);


    void login(const char* name);
    void loadMetaWork(const char* name);
    void saveMetaWork(const char* name, const ByteArray* bytes);

protected:
    int qid;
    void response(ParamList* result);
    void success(ParamList* params);
    void failed(int reason);
};

extern EditorService* editor_service;

#endif
