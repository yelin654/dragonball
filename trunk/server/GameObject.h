#ifndef GAMEOBJECT_H
#define GAMEOBJECT_H

#include <set>
using namespace std;

#include "Object.h"
#include "Serializable.h"
#include "Param.h"

class GameObject;
class ClientSyner;

class GameObject: public Object {
    DECLARE_CLASS(GameObject)

public:
    GameObject(){};

public:
    virtual void serialize(OutputStream* stream) {};
    virtual void unserialize(InputStream* stream) {};

protected:
    ClientSyner* _invoke_from;
public:
    virtual void invoke_method_from(ClientSyner* syner, const string& name, ParamList* params) {
        _invoke_from = syner;
        invoke_method(name, params);
    }

    virtual void invoke_method(const string& name, const ParamList* params);

// public:
//     void seriailze_method(const string& name);
//     template<class ...ARGS>
//     void seriailze_method(Stream& stream, const string& name, ARGS ...args) {
//         ParamList params(args...);
//         _call_mirror_method(name, params);
//     };
    //private:
    //    static void _seriailze_method(Stream& stream, const string& name, ParamList& params);
    //    static void _unseriailze_method(Stream& stream, const string& name, ParamList& params);

    // template<class M>
    // void syn_method(const string& name, M method) {
    //     (this->*method)();
    //     call_method_remote(name);
    // };
    // template<class M, class ...ARGS>
    // void syn_method(const string& name, M method, ARGS ...args) {
    //     (this->*method)(args...);
    //     call_method_remote(name, args...);
    // };

};
////////////////////////////////////////////////////////////////////////////
#define GEN_TYPE_0
#define GEN_TYPE_1 , class T1
#define GEN_TYPE_2 GEN_TYPE_1, class T2
#define GEN_TYPE_3 GEN_TYPE_2, class T3
#define GEN_TYPE(n) GEN_TYPE_##n

#define GEN_PARAM_0
#define GEN_PARAM_1 (T1)params[0]
#define GEN_PARAM_2 GEN_PARAM_1, (T2)params[1]
#define GEN_PARAM_3 GEN_PARAM_2, (T3)params[2]
#define GEN_PARAM(n) GEN_PARAM_##n

#define GEN_TEMPLATE(n) \
template<class Method, Method method GEN_TYPE(n)>       \
void call(ParamList& params) { \
    (this->*method)(GEN_PARAM(n));   \
}

#define GEN_SYN_0 GEN_TEMPLATE(0)
#define GEN_SYN_1 GEN_SYN_0;GEN_TEMPLATE(1)
#define GEN_SYN_2 GEN_SYN_1;GEN_TEMPLATE(2)
#define GEN_SYN_3 GEN_SYN_2;GEN_TEMPLATE(3)
#define GEN_SYN(n) GEN_SYN_##n

#define REG_SYN(ClassName, Method, ...) \
typedef void (ClassName::*__##ClassName##Method)(__VA_ARGS__); \
ClassName::_index_string_method[#Method] = &ClassName::call< __##ClassName##Method, &ClassName::Method, ##__VA_ARGS__ >;

#define DECLARE_GAME_OBJECT(ClassName, SuperClassName)  \
DECLARE_CLASS(ClassName) \
public: \
typedef void (ClassName::*Func)(ParamList& params); \
static map<string, Func> _index_string_method; \
virtual void invoke_method(const string& name, ParamList* params) { \
    if (_index_string_method.find(name) != _index_string_method.end()) \
        (this->*_index_string_method[name])(*params); \
    else \
        SuperClassName::invoke_method(name, params); \
}; \
GEN_SYN(3);


#define DEFINE_GAME_OBJECT(T) \
typedef void (T::*T##Method)(ParamList& params); \
map<string, T##Method> T::_index_string_method; \
DEFINE_CLASS(T)
//////////////////////////////////////////////////////////////////////////////////////




#endif
