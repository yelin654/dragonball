package org.musince.actions
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.musince.core.ITimeSlice;
	import org.musince.core.TimeSlice;
	import org.musince.global.$config;
	import org.musince.global.$log;
	import org.musince.global.$root;
	
	public class LoadConfigFile extends TimeSlice
	{
		private var _loader:URLLoader;
		
		public function LoadConfigFile()
		{
		}
		
		override public function onStart():void
		{
			_loader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, onConfigFileLoaded);
			_loader.load(new URLRequest("config.xml"));
		}
		
		private function onConfigFileLoaded(e:Event):void
		{
			var xml:XML = new XML(e.target.data);
			isEnd = true;
			$config.ServerAddress = xml.server_address;
			$config.ServerPort = xml.server_port;
			$config.ResourceRoot = xml.resource_root;
			if ($config.ServerAddress == "" || $config.ServerAddress == null)
			{
				var url:String = $root.loaderInfo.url;
				var start:int = url.lastIndexOf("\/\/") + 2;
				var end:int = url.indexOf("\/", start);
				var address:String = url.substring(start, end);
//				$log.alert("start:"+start+" end:"+end+" address:"+address)
			}
		}
		
		override public function onUpdate():void
		{
			
		}
	}
}