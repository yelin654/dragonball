package org.musince.actions
{
	import flash.events.Event;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$config;
	import org.musince.global.$log;
	import org.musince.global.$receiver;
	import org.musince.global.$syner;
	import org.musince.global.$tunnel;
	
	public class ConnectToServer extends TimeSlice
	{
		public function ConnectToServer()
		{
			super();
		}
		
		override public function onStart():void 
		{		
			$tunnel.addEventListener(Event.CONNECT, onConnect);
			$log.debug("connect to", $config.ServerAddress, ":", $config.ServerPort);
			$tunnel.connect($config.ServerAddress, $config.ServerPort);
		}
		
		private function onConnect(e:Event):void
		{
			$log.debug("connected");
			$tunnel.attachReceiver($syner);
			$syner.bind($tunnel);
			isEnd = true;
		}
	}
}