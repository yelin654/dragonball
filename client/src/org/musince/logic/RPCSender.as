package org.musince.logic
{
	import flash.utils.ByteArray;
	
	import org.musince.net.Tunnel;

	public class RPCSender
	{
		private var _tunnel:Tunnel; 
		
		public function RPCSender()
		{
		}
		
		public function sendEvent(type:int, params:ParamList):void {
			var bytes:ByteArray = new ByteArray();
			bytes.writeShort(type);
			params.serialize(bytes);
			_tunnel.sendRPC(bytes);
		} 
		
		

	}
}