#include <stdio.h>
#include <time.h>
#include <sys/stat.h>
#include <sys/fcntl.h>
#include <syslog.h>
#include <signal.h>
#include <typeinfo>

#include "Param.h"
#include "stlite.h"
#include "Net.h"
#include "ClientTunnelFactory.h"
#include "ClientSyner.h"
#include "GameServer.h"
#include "Log.h"
#include "script.h"
#include "EditorService.h"
#include "LoginService.h"
#include "luaapi.h"
#include "LuaService.h"
#include "ParamListSend.h"
#include "ParamListRecv.h"
#include "rpc.h"

Net* net;

void (f) (int a, int b) {

}

void test_net() {
    net = new Net(new ClientTunnelFactory);
    net->init("192.168.1.122", 12222, 20, 20, 50);
    while(true) {
        net->dispatch();
    }
}

void test_2() {
    // Character *c = (Character*)Class::NEW_INSTANCE("Character");
    // Fighter *f =  (Fighter*)Class::NEW_INSTANCE("Fighter");
    // printf("f class name %s \n", f->get_class()->name);
    // printf("c class name %s \n", c->get_class()->name);
    // ParamList params;
    // Skill* skill = new Skill();
    // skill->guid = 9999;
    // c->call_method(0, ParamList(5, skill, "fuck you"));
    //    c.move_to(ParamList(5, skill, "fuck you"));
    //    f->call_method(0, params);
}

void test_param() {
    // Param ps_int1(5);
    // Param ps_int2(-5);
    // Param ps_c_str("中");
    // int int_array[5] = {2, 3, 4, 5, 6};
    // Array<int> t_int_array(int_array, 5);
    // Param ps_int_array(&t_int_array);
    // const char* c_str_array[3] = {"hello", "the", "world"};
    // Array<const char*> t_string_array(c_str_array, 3);
    // Param ps_c_str_array(&t_string_array);

    // Stream stream(10);

    // ps_int1.serialize(&stream);
    // ps_int2.serialize(&stream);
    // ps_c_str.serialize(&stream);
    // ps_int_array.serialize(&stream);
    // ps_c_str_array.serialize(&stream);

    // //    stream.reset_position();

    // Param pu_int1;
    // Param pu_int2;
    // Param pu_c_str;
    // Param pu_int_array;
    // Param pu_c_str_array;

    // pu_int1.unserialize(&stream);
    // pu_int2.unserialize(&stream);
    // pu_c_str.unserialize(&stream);
    // pu_int_array.unserialize(&stream);
    // pu_c_str_array.unserialize(&stream);

    // printf("int1:%d\n", pu_int1.to_int());
    // printf("int2:%d\n", pu_int2.to_int());
    // printf("c_str:%s\n", pu_c_str.to_string());

    // int* array_int;  int len;
    // Array<int> u_int_array = pu_int_array.to_int_array();
    // array_int = u_int_array.data;
    // len = u_int_array.length;
    // printf("int array:{");
    // for (int i = 0; i < len; i++) {
    //     printf("%d, ", array_int[i]);
    // }
    // printf("}\n");

    // char** array_c_str;
    // const Array<char*>& u_string_array = pu_c_str_array.to_string_array();
    // array_c_str = u_string_array.data;
    // len = t_string_array.length;
    // printf("c_str array:{");
    // for (int i = 0; i < len; ++i) {
    //     printf("%s, ", array_c_str[i]);
    // }
    // printf("}\n");
}

void test_stream() {

}

void test_story() {

}

void test_lua()
{

}

void signal_handle(int id) {
    debug("catch signal int");
}

void signal_set() {
    struct sigaction act,old_act;
    act.sa_handler = signal_handle;
    sigemptyset(&act.sa_mask);
    act.sa_flags = 0;
    //handle the SEGV,INT,TERM,QUIT
    if (sigaction(SIGHUP,&act,&old_act) <0)
    {
        printf("FATAL error for sigaction in function signal_set \n");
        exit(-1);
    }
    sigaction(SIGINT,&act,NULL);
}

LuaQuery* lua_query;

void init_services() {
    lua_query = new LuaQuery;

}

void roll() {
    net = new Net(new ClientTunnelFactory);
    net->init("192.168.1.122", 12222, 20, 20, 50);
    while(true) {
        net->dispatch();
    }
}

void gen_test(int x, int y) {
    debug("x:%d, y:%d", x, y);
}



void register_funcs() {
    REG_RPC(gen_test, int, int);
    REG_RPC(login, int, const char*);
    REG_RPC(enter_story, int, const char*, int);
    //REG_SYN(EditorService, login, const char*);
    //REG_SYN(EditorService, saveMetaWork, const char*, const ByteArray*);
    //REG_SYN(EditorService, loadMetaWork, const char*);
    //REG_SYN(LoginService, login, const char*);
    //REG_SYN(GameServer, enter_story, char*, int);
}

void print_classes() {
    //    FOR_MAP(string, Class*, Class::CLASS_INDEX) {
    //        printf("%s , %s \n", it->first.c_str(), it->second->name);
    //    }
}

void test_event() {
    // EventListener el;
    // EventDispatcher ed;
    // REGISTER_EVENT_LISTENER(&ed, 1, &el, EventListener, method_b);

    // UIEventListener ul;
    // REGISTER_EVENT_LISTENER(&ed, 1, &ul, UIEventListener, method_a);

    // Event e;
    // e.type = 1;
    // ed.dispatch_event(e);

    //    test_param();
}

void load_lua_files() {
    load_lua_file("script/story.lua");
}

ParamListSend* g_pls;

void init_global() {
    g_pls = new ParamListSend;
}

int main() {
    init_global();

    init_lua();

    register_lua();

    signal_set();

    register_funcs();

    load_lua_files();

    roll();

    return 0;
}

