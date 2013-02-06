package test
{
	import flash.events.Event;
	
	import globals.$config;
	import globals.$log;
	import globals.$tunnel;
	
	import slices.TimeSlice;
	
	public class ConnectToTestServer extends TimeSlice
	{
		public function ConnectToTestServer()
		{
			super();
		}
		
		override public function onStart():void 
		{		
			$tunnel.addEventListener(Event.CONNECT, onConnect);
			$config.ServerPort = 12223;
			$config.ServerAddress = "www.musince.org";
			$log.debug("connect to", $config.ServerAddress, ":", $config.ServerPort);
//			$log.alert("connect to " +  $config.ServerAddress +  ":" +  $config.ServerPort);
			$tunnel.connect($config.ServerAddress, $config.ServerPort);
		}
		
		private function onConnect(e:Event):void
		{
			$log.debug("connected");
			isDone = true;
		}
	}
}