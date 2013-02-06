package slices
{
	import flash.events.Event;
	
	import globals.$config;
	import globals.$log;
	import globals.$receiver;
	import globals.$syner;
	import globals.$tunnel;
	
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
//			$log.alert("connect to " +  $config.ServerAddress +  ":" + $config.ServerPort);
			$tunnel.connect($config.ServerAddress, $config.ServerPort);
		}
		
		private function onConnect(e:Event):void
		{
			$log.debug("connected");
			isDone = true;
		}
	}
}