#ifndef STLITE_H
#define STLITE_H

#define FOR_MAP(key, value, container) for(map<key, value>::iterator it = container.begin(); it != container.end(); ++it)

#define FOR_LIST(type, container) for(list<type>::iterator it = container.begin(); it != container.end(); ++it)

#define FOR_SET(type, container) for(set<type>::iterator it = container.begin(); it != container.end(); ++it)

#define FOR_MULTIMAP(key, value, container, find_key) for (multimap<key, value>::iterator it = container.lower_bound(find_key); it != container.upper_bound(find_key); ++it)


#include <string.h>

#include <functional>
using namespace std;

struct c_str_less: public binary_function<const char*, const char*, bool>
{
    bool operator() (const char* s1, const char* s2)
    {
        return strcmp(s1, s2) < 0;
    }
};


#endif
