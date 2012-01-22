#ifndef SERVICE_H
#define SERVICE_H

#include "GameObject.h"

class Service: public GameObject {
    DECLARE_GAME_OBJECT(Service, GameObject)
public:
    virtual void invoke_method_from(ClientSyner* syner, const string& name, ParamList* params
);

    virtual void invoke_service_method(const string& name, ParamList* params);
protected:
    int qid;
    void success(ParamList* params);
    void failed(ParamList* params);
};

#endif
