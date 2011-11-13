#include "macro.h"
#include "PlayerWorks.h"
#include "Stream.h"
#include "LuaStory.h"

DEFINE_CLASS(MetaStory)
DEFINE_CLASS(PlayerWorks)

void MetaStory::serialize(Stream* stream)
{

}

void MetaStory::unserialize(Stream* stream)
{

}


void PlayerWorks::serialize(Stream* stream)
{
    stream->write_int(_storys.size());
    FOR_LIST(MetaStory*, _storys) {
        (*it)->serialize(stream);
    }
}

void PlayerWorks::unserialize(Stream* stream)
{
    int size = stream->read_int();
    MetaStory* story;
    for (int i = 0; i < size; i++) {
        story = new MetaStory();
        story->unserialize(stream);
        _storys.push_back(story);
    }
}
