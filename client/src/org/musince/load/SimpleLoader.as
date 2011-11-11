package org.musince.load
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class SimpleLoader
	{
		private var _loader:Loader = new Loader();
		private var _callback:Function;
		
		public function SimpleLoader()
		{
			super();
		}
		
		public function load(url:String, callback:Function):void
		{
			_callback = callback;
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);			
			_loader.load(new URLRequest(url), new LoaderContext(false, new ApplicationDomain()));
		}
		
		private function onLoaded(e:Event):void
		{
			_callback(_loader.content);
			_callback = null;
		}
		
	}
}