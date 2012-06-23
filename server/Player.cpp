#include "Player.h"
#include "Log.h"

//map<string, Player*> G_players;

DEFINE_GAME_OBJECT(Player)

void Player::continue_story(int idx) {
}

void Player::start_story(int idx) {
}

Player::~Player() {
    debug("destory player %s", name.c_str());
}
