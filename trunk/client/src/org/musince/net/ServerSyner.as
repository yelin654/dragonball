package org.musince.net
{
	import flash.utils.IDataInput;
	
	import org.musince.logic.GameObject;
	import org.musince.logic.ParamList;

	public class ServerSyner implements IDataReceiver, ISynchronizer
	{
		private var _tunnel:Tunnel;
		
		public static const COMMAND_INVOKE_METHOD:int = 1;
		
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
				case COMMAND_INVOKE_METHOD:
					invoke_method_recv(data);
					break;
			}
		}
		
		public function rpc(key:Array, method_name:String, params:Array):void {
			var stream:OutputStream = get_command_stream(COMMAND_INVOKE_METHOD);
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
		
		
		public function invoke_method_recv(stream:IDataInput):void { 
			var key:ParamList = new ParamList;
			key.unserialize(stream);
			var object:GameObject = $finder.find(key.toArray());
			var method_name:String = stream.readUTF();
			var params:ParamList = new ParamList;
			params.unserialize(stream);
			object.invokeMethod(method_name, params.toArray());
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