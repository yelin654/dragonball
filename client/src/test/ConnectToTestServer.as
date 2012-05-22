package test
{
	import flash.events.Event;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$config;
	import org.musince.global.$log;
	import org.musince.global.$tunnel;
	
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
			isEnd = true;
		}
	}
}