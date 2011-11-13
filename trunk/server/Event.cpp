#include "Event.h"
#include "utils.h"
#include "Param.h"
#include "Stream.h"

void Event::serialize(Stream* stream) const{
    stream->write_int(type);
    params->serialize(stream);
}

void Event::unserialize(Stream* stream) {
    type = stream->read_int();
    params = new ParamList();
    params->unserialize(stream);
}

DEFINE_GAME_OBJECT(EventDispatcher)

typedef pair<EventListener*, string> _listener;

void EventDispatcher::add_event_listener(int type, EventListener* listener, const char* method) {
    _listeners.insert(make_pair(type, _listener(listener, method)));
}

void EventDispatcher::dispatch_event(const Event* event) {
    FOR_MULTIMAP(int, _listener, _listeners, event->type)
        it->second.first->handle_event(event, it->second.second);
}

DEFINE_EVENT_LISTENER(UIEventListener)
