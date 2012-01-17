#include "macro.h"
#include "PlayerWorks.h"
#include "Stream.h"
#include "LuaStory.h"
#include "Player.h"
#include "StoryProgress.h"

DEFINE_GAME_OBJECT(Player)

void Player::continue_story(int idx) {
    StoryProgress* progress = _progress.find(idx)->second;
    if (progress->offset == 0) {
        lc("action_on_start", 0,
           idx, progress->space_idx, progress->chapter_idx, progress->action_idx);
    }
}

void Player::start_story(int idx) {
    lc("start_story", 0, idx);
}
