#include "StoryProgress.h"

DEFINE_GAME_OBJECT(StoryProgress)

void StoryProgress::serialize(OutputStream* stream)
{
    stream->write_string(name);
    stream->write_byte(has_progress);
}
