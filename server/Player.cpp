#include "macro.h"
#include "Player.h"
#include "StoryProgress.h"

map<string, Player*> G_players;

DEFINE_GAME_OBJECT(Player)

void Player::continue_story(int idx) {
}

void Player::start_story(int idx) {
}

Player::~Player() {
}
