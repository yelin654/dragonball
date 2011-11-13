#ifndef IOBJECTFINDER_H
#define IOBJECTFINDER_H

class Object;
class ParamList;

class IObjectFinder {
public:
    virtual Object* find(ParamList* params)=0;
};

extern IObjectFinder* finder;
extern void* fcontext;

#endif
