#ifndef GAMEOBJECT_H
#define GAMEOBJECT_H

#include <set>
using namespace std;

#include "Object.h"
#include "Serializable.h"
#include "ParamListRecv.h"

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
    virtual void invoke_method_from(ClientSyner* syner, const string& name, ParamListRecv* params) {
        _invoke_from = syner;
        invoke_method(name, params);
    }

    virtual void invoke_method(const string& name, const ParamListRecv* params);

// public:
//     void seriailze_method(const string& name);
//     template<class ...ARGS>
//     void seriailze_method(Stream& stream, const string& name, ARGS ...args) {
//         ParamListRecv params(args...);
//         _call_mirror_method(name, params);
//     };
    //private:
    //    static void _seriailze_method(Stream& stream, const string& name, ParamListRecv& params);
    //    static void _unseriailze_method(Stream& stream, const string& name, ParamListRecv& params);

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
#include "generation.h"

#define GEN_CLASS_TEMPLATE(n) \
template<class Method, Method method GEN_TYPE(n)>       \
void call(ParamListRecv& params) { \
    (this->*method)(GEN_PARAM(n));   \
}

#define GEN_CLASS_SYN_0 GEN_CLASS_TEMPLATE(0)
#define GEN_CLASS_SYN_1 GEN_CLASS_SYN_0;GEN_CLASS_TEMPLATE(1)
#define GEN_CLASS_SYN_2 GEN_CLASS_SYN_1;GEN_CLASS_TEMPLATE(2)
#define GEN_CLASS_SYN_3 GEN_CLASS_SYN_2;GEN_CLASS_TEMPLATE(3)
#define GEN_CLASS_SYN(n) GEN_CLASS_SYN_##n


#define REG_SYN(ClassName, Method, ...) \
typedef void (ClassName::*__##ClassName##Method)(__VA_ARGS__); \
ClassName::_index_string_method[#Method] = &ClassName::call< __##ClassName##Method, &ClassName::Method, ##__VA_ARGS__ >;

#define DECLARE_GAME_OBJECT(ClassName, SuperClassName)  \
DECLARE_CLASS(ClassName) \
public: \
typedef void (ClassName::*Func)(ParamListRecv& params); \
static map<string, Func> _index_string_method; \
virtual void invoke_method(const string& name, ParamListRecv* params) { \
    if (_index_string_method.find(name) != _index_string_method.end()) \
        (this->*_index_string_method[name])(*params); \
    else \
        SuperClassName::invoke_method(name, params); \
}; \
GEN_CLASS_SYN(3);


#define DEFINE_GAME_OBJECT(T) \
typedef void (T::*T##Method)(ParamListRecv& params); \
map<string, T##Method> T::_index_string_method; \
DEFINE_CLASS(T)
//////////////////////////////////////////////////////////////////////////////////////




#endif
