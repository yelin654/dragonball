#include "GameEvent.h"
#include "Param.h"
#include "Stream.h"

void GameEvent::serialize(Stream* stream) const {
    stream->write_int(type);
    params->serialize(stream);
};

void GameEvent::unserialize(Stream* stream){
    type = stream->read_int();
    params->unserialize(stream);
};
