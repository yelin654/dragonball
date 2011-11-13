#ifndef IREMOTE_H
#define IREMOTE_H

class ISynchronizer;

class IRemote {
public:
    virtual ISynchronizer* get_syner()=0;
};

#endif
