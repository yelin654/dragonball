#include <string>
using namespace std;

#include "GameServer.h"
#include "ClientSyner.h"
#include "Log.h"
#include "Player.h"
#include "StoryProgress.h"
#include "script.h"
#include "luaapi.h"
#include "rpc.h"


void enter_story(int qid, const char* owner, int idx) {
    ClientSyner* syner = rpc_context->from;
    syner->query_success(qid);
    Player* player = syner->player;
    player->current = new StoryProgress();
    lua_context.player = player;
    string filename = "progress/" + player->name;
    FILE* progress = fopen(filename.c_str(), "r");
    if (NULL == progress) {
        player->current->chapter_idx = 0;
    } else {
        fread(&(player->current->chapter_idx), 4, 1, progress);
        fclose(progress);
    }
    lc("start_story", 0, player->current->chapter_idx);
}
