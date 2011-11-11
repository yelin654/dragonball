package org.musince.logic
{
	import flash.utils.ByteArray;
	
	import org.musince.net.Tunnel;

	public class ObjectMirror
	{
		public var tunnel:Tunnel;  
		
		public function ObjectMirror(tunnel:Tunnel)
		{
			this.tunnel = tunnel;
		}
		
		public function synMethod(method:ByteArray):void {
			tunnel.writeInt(method.length + 2);
			tunnel.writeShort(2);
			tunnel.writeBytes(method);
			tunnel.flush();
		}
	}
}