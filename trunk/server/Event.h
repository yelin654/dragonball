#ifndef EVENT_H
#define EVENT_H

#include <stdio.h>
#include <map>
using namespace std;

#include "Serializable.h"
#include "GameObject.h"
class ParamList;

class Event : public Serializable{
    DECLARE_CLASS(Event);
public:
    int type;
    ParamList* params;
    Event(){};
    virtual void serialize(Stream* stream) const;
    virtual void unserialize(Stream* stream);
};

class EventListener {
public:
    virtual void handle_event(const Event* event, const string& method)=0;
};

#define DECLARE_EVENT_LISTENER(ClassName)                              \
public: \
    typedef void (ClassName::*ListenMethod)(const Event* event);    \
    static map<string, ListenMethod> name_method_index;               \
    virtual void handle_event(const Event* event, const string& method) { \
        (this->*name_method_index[method])(event);                      \
    }

#define DEFINE_EVENT_LISTENER(ClassName) \
typedef void (ClassName::*ClassName##ListenMethod)(const Event* event);    \
map<string, ClassName##ListenMethod> ClassName::name_method_index;


#define REGISTER_EVENT_LISTENER(dispather, type, instance, class_name, method) \
    class_name::name_method_index[#method] = &class_name::method;        \
    (dispather)->add_event_listener(type, instance, #method);


class EventDispatcher:public GameObject {
    DECLARE_GAME_OBJECT(EventDispatcher, GameObject)
public:
    void add_event_listener(int type, EventListener* listener, const char* method);
    //    void remove_event_listener(int type,
    void dispatch_event(const Event* event);
private:
    typedef pair<EventListener*, string> _listener;
    multimap<int, _listener> _listeners;
};

class UIEventListener: public EventListener {
    DECLARE_EVENT_LISTENER(UIEventListener);
public:
    UIEventListener() {
    };
    void method_a(const Event* event) {
        printf("method_a\n");
    }
};


#endif
