package org.musince.actions
{
	import flash.events.Event;
	
	import org.musince.core.TimeSlice;
	
	public class ConnectToServer extends TimeSlice
	{
		private var _address:String; 
		private var _port:int; 
		
		public function ConnectToServer(address:String, port:int)
		{
			super();
			_address = address;
			_port = port;
		}
		
		override public function onStart():void 
		{			
			$tunnel.addEventListener(Event.CONNECT, onConnect);
			$log.debug("connect to", _address, ":", _port);
			$tunnel.connect(_address, _port);
		}
		
		private function onConnect(e:Event):void
		{
			$log.debug("connected");
			$tunnel.setReceiver($syner);
			$syner.bind($tunnel);
			isEnd = true;
		}
	}
}