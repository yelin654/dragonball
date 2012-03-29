#include "GameProgress.h"
#include "StoryProgress.h"
#include "utils.h"

DEFINE_GAME_OBJECT(GameProgress)

void GameProgress::serialize(OutputStream* stream)
{
    stream->write_short(storys.size());
    FOR_LIST(StoryProgress*, storys) {
        (*it)->serialize(stream);
    }
}
