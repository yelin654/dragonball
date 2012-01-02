package org.musince.net
{
	import flash.utils.IDataInput;
	import flash.utils.getDefinitionByName;
	
	import org.musince.global.$finder;
	import org.musince.logic.GameObject;
	import org.musince.logic.ParamList;

	public class ServerSyner implements IDataReceiver
	{
		private var _tunnel:Tunnel;
		
		public static const COMMAND_ROC:int = 1;
		public static const COMMAND_GROUP_START:int = 2;
		public static const COMMAND_GROUP_END:int = 3;
		public static const COMMAND_GROUP_ROC:int = 4;
		public static const COMMAND_RPC:int = 5;
		
		private var _group_cache:Array;
		
		public function ServerSyner()
		{
		}
		
		public function bind(tunnel:Tunnel):void
		{
			_tunnel = tunnel;
		}
		
		public function on_data(tunnel:Tunnel, data:IDataInput):void {
			var command:int = data.readShort();
			switch(command) {
				case COMMAND_ROC:
					invoke_object_method_recv(data);
					break;
				case COMMAND_GROUP_START:
					cache_invoke(data);
					break;
				case COMMAND_GROUP_END:
					finish_group(data);
					break;
				case COMMAND_GROUP_ROC:
					cache_invoke(data);
					break;
				case COMMAND_RPC:
					invoke_global_method_recv(data);
					break;
			}
		}
		
		public function roc(key:Array, method_name:String, params:Array):void {
			var stream:OutputStream = get_command_stream(COMMAND_ROC);
			(new ParamList(key)).serialize(stream);
			stream.writeUTF(method_name);
			(new ParamList(params)).serialize(stream);
			stream.flush();
		}
		
		private function get_command_stream(id:int, size:int=0):OutputStream {
			var stream:OutputStream = _tunnel.getOutputStream();
			stream.writeShort(id);
			return stream;
		}
		
		private var key:ParamList;
		private var object:GameObject;
		private var method_name:String;
		private var params:ParamList;
		
		private function read_method(stream:IDataInput):void { 
			key = new ParamList;
			key.unserialize(stream);
			object = $finder.find(key.toArray());
			method_name = stream.readUTF();
			params = new ParamList;
			params.unserialize(stream);
		}
		
		private function invoke_object_method_recv(stream:IDataInput):void { 
			read_method(stream);
			object.invokeMethod(method_name, params.toArray());
		}
		
		private function invoke_global_method_recv(stream:IDataInput):void { 
			method_name = stream.readUTF();
			params = new ParamList;
			params.unserialize(stream);
			var f:Function = getDefinitionByName(method_name) as Function;
			f.apply(null, params.toArray());
		}
		
		private function cache_invoke(stream:IDataInput):void {
			read_method(stream);
			_group_cache.push([object, method_name, params.toArray()]);
		}
		
		private function finish_group(stream:IDataInput):void {
			cache_invoke(stream);
			for each (var invoke:Array in _group_cache)	{
				invoke[0].invokeMethod(invoke[1], invoke[2]);
			}
			_group_cache = null;
		}
		
		private function grouping():Boolean
		{
			return _group_cache != null;
		}
		
//		public function on_connect(tunnel:Tunnel):void {
//			this._tunnel = tunnel;
//			$client.on_connect(this);
//		}
			
//		public function on_disconnect(tunnel:Tunnel):void {
//			$client.on_disconnect(this);
//		}
	}
}