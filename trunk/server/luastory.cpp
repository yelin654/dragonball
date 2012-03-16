#include "script.h"

void load_story(const char* name, int idx) {
    lc("load", 0, name, idx);
    lc("load", 0);
    int i = 0;
    const char* s = NULL;
    lr(i, s);
};
