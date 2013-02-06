package
{
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.IDataInput;
	import flash.utils.getDefinitionByName;
	
	import slices.BlankTime;
	import slices.ConnectToServer;
	import slices.LoadConfigFile;
	import slices.Login;
	import slices.SendLuaRPC;
	import globals.$athena;
	import globals.$client;
	import globals.$finder;
	import globals.$sender;
	import globals.$syner;
	import globals.$tunnel;
	import org.musince.logic.GameObject;
	import org.musince.logic.ParamList;
	import org.musince.net.IDataOutputNet;
	import org.musince.net.IDataReceiver;
	import org.musince.net.IDataSender;
	import org.musince.net.IRPCSender;
	import org.musince.net.OutputStream;
	import org.musince.net.Tunnel;
	import org.musince.query.EnterStory;
	import org.musince.query.LoginQuery;
	
	[SWF(width="1280", height="720", backgroundColor="0x000000")]			
	public class AutoClient extends Sprite implements IDataReceiver, IRPCSender
	{
		public static const COMMAND_RPC:int = 1;
		public static const COMMAND_ROC:int = 7;
		public static const COMMAND_GROUP_START:int = 2;
		public static const COMMAND_GROUP_END:int = 3;
		public static const COMMAND_GROUP_ROC:int = 4;
		public static const COMMAND_LUA_RPC:int = 8;
		public static const COMMAND_TEST:int = 9;
		public static const COMMAND_QUERY_SUCCESS:int = 11;
		
		private var _group_cache:Array;
		
		public function AutoClient()
		{
			super();
			var config:LoadConfigFile = new LoadConfigFile();
			
			var connect:ConnectToServer = new ConnectToServer();
			config.appendNext(connect);
			
			var login:LoginQuery = new LoginQuery();
			login.input["u"] = "autoclient";
			connect.appendNext(login);
			
			var enter:EnterStory = new EnterStory();
			login.appendNext(enter);
			
			$athena.start(stage);
			$athena.addTimeSlice(config);
			
			$tunnel.attachReceiver(this);
			$sender = this;
			
		}
		
		public function on_data(tunnel:Tunnel, data:IDataInput):void {
			var command:int = data.readShort();
			switch(command) {
				case COMMAND_RPC:
					invoke_global_method_recv(data);
					break;
				case COMMAND_QUERY_SUCCESS:
					on_query_success(data);
					break;
			}
		}
		
		public function on_query_success(stream:IDataInput):void
		{
			var qid:int = stream.readInt();
			params = new ParamList;
			params.unserialize(stream);
			$client.querySuccess(qid, params.params); 
		}
		
		public function rpc(method_name:String, params:Array=null):void {
			var stream:IDataOutputNet = get_command_stream(COMMAND_RPC);
			stream.writeUTF(method_name);
			(new ParamList(params)).serialize(stream);
			stream.flush();
		}
		
		public function lua_rpc(method_name:String, params:Array=null):void {
			var stream:IDataOutputNet = get_command_stream(COMMAND_LUA_RPC);
			stream.writeUTF(method_name);
			(new ParamList(params)).serialize(stream);
			stream.flush();
		}
		
		public function get_command_stream(id:int):IDataOutputNet {
			var stream:OutputStream = $tunnel.getOutputStream();
			stream.writeShort(id);
			return stream;
		}
		
		private var key:ParamList;
		private var object:GameObject;
		private var method_name:String;
		private var params:ParamList;
		
		private function invoke_global_method_recv(stream:IDataInput):void { 
			method_name = stream.readUTF();
			params = new ParamList;
			params.unserialize(stream);
			var f:Function = this[method_name] as Function;
			f.apply(null, params.params);
		}
		
		public var delay:int = 1000;
		
		public function play_choice(meta:Dictionary):void
		{
			var blank:BlankTime = new BlankTime(delay);
			var rpc:SendLuaRPC = new SendLuaRPC("on_choose", [1]);
			blank.appendNext(rpc);
			$athena.addTimeSlice(blank);
		}
		
		public function play_talk(talk:Dictionary):void
		{
			var blank:BlankTime = new BlankTime(delay);
			var rpc:SendLuaRPC = new SendLuaRPC("next_main_action", null);
			blank.appendNext(rpc);
			$athena.addTimeSlice(blank);
		}
		
		public function play_guide(guide:Dictionary):void
		{
			var blank:BlankTime = new BlankTime(delay);
			var rpc:SendLuaRPC = new SendLuaRPC("next_main_action", null);
			blank.appendNext(rpc);
			$athena.addTimeSlice(blank);
		}

		public function load_chapter(idx:int):void
		{
			var blank:BlankTime = new BlankTime(delay);
			var rpc:SendLuaRPC = new SendLuaRPC("on_chapter_load", null);
			blank.appendNext(rpc);
			$athena.addTimeSlice(blank);
		}

		public function play_sound(meta:Dictionary):void
		{
			
		}
		
		public function play_monolog(mono:Dictionary):void
		{
			var blank:BlankTime = new BlankTime(delay);
			var rpc:SendLuaRPC = new SendLuaRPC("next_main_action", null);
			blank.appendNext(rpc);
			$athena.addTimeSlice(blank);
		}

		public function change_background(rid:int):void
		{
			
		}
		
		public function play_bgm(rid:int):void
		{
			
		}
		
		public function clear_background():void
		{
			
		}
		
		public function tip_end(content:String):void
		{
			
		}

	}
}