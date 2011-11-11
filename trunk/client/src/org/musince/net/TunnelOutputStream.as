package org.musince.net
{
	public class TunnelOutputStream extends OutputStream
	{
		private var _tunnel:Tunnel;
		
		public function TunnelOutputStream(tunnel:Tunnel)
		{
			super();
			_tunnel = tunnel;
		}
	
		override public function flush():void {
			_tunnel.writeInt(this.length);
			this.position = 0;
			_tunnel.writeBytes(this);
			_tunnel.flush();
		}
	}
}