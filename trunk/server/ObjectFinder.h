#ifndef OBJECTFINDER_H
#define OBJECTFINDER_H

#include <map>
#include <string>
using namespace std;

#include "IObjectFinder.h"

class ObjectFinder: public IObjectFinder {
private:
    //    typedef Object* (ObjectFinder::*FIND_FUNC)(const ParamList&);
    //    map<string, FIND_FUNC> _finders;
public:
    ObjectFinder();
    virtual Object* find(ParamList* params);
    //    Object* find_character(const ParamList& params);
    //    Object* find_gui(const ParamList& params);
};

#endif
