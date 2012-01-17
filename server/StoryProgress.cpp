#include "StoryProgress.h"
#include "Stream.h"

DEFINE_GAME_OBJECT(StoryProgress)

void StoryProgress::serialize(Stream* stream)
{
    stream->write_string(name);
    stream->write_byte(has_progress);
}
