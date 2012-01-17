#ifndef SERVICE_H
#define SERVICE_H

#include "GameObject.h"

class ParamList;

class Service: public GameObject {
    DECLARE_GAME_OBJECT(Service, GameObject)
public:
    virtual void invoke_method_from(ClientSyner* syner, const string& name, ParamList* params);

protected:
    int qid;
    void success(ParamList* params);
    void failed(int reason);
};

#endif
