#ifndef LUATIMESTAMP_H
#define LUATIMESTAMP_H

class LuaTimeLine;

class LuaTimeStamp:public GameObject {
    DECLARE_GAME_OBJECT(LuaTimeStamp, GameObject)
public:
    LuaTimeStamp();

public:


public:
    int idx;
    LuaTimeLine* timeline;
    LuaTimeStamp* next;
    char* owner;
    void compile();
    void excute();

public:
    virtual void serialize(Stream* stream) ;
    virtual void unserialize(Stream* stream);
    void save();
    void load();
    void set_script(char* s);

private:
    char* _script;
};

#endif
