class InputStream;
class Player;
class TunnelInputStream;

void dispatch_rpc(InputStream* stream);

void dispatch_lua_rpc(InputStream* stream, Player* player);

void handle_test(TunnelInputStream* in);
