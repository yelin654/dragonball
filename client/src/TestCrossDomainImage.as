package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	
	import org.musince.global.$log;
	import org.musince.system.RLog;
	
	public class TestCrossDomainImage extends Sprite
	{
		public var url:String = "https://ec7uqq.bay.livefilestore.com/y1pQO_x0zjRFAOvbQeCa-xtJllMFyEJsN0hJG7kGx0uhAaCjL-NbXMmU0VHwRZxLAzWf9Yi5l6xJwe-pJyXUUBo6reVJXxLbxQk/1441121_1321877662.jpg";
		
		public var loader:Loader = new Loader();
		public var bloader:URLLoader = new URLLoader();
		
		public function TestCrossDomainImage()
		{
			super();
//			loader.load(new URLRequest(url));
			addChild(loader);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			bloader.addEventListener(Event.COMPLETE, onComplete2);
			bloader.dataFormat = URLLoaderDataFormat.BINARY;
			bloader.load(new URLRequest(url));
			$log = new RLog;
//			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
//			$log.debug("test1");
//			$log.debug("test2");
		}
		
		private function onComplete(e:Event):void
		{
//			var s:Sprite = new Sprite();			
//			s.addChild(loader);
//			var bd:BitmapData = new BitmapData(400, 400, true, 0x00000000);
//			bd.draw(s);
//			addChild(new Bitmap(bd));
			$log.debug("data decoded");
		}
		
		private function onComplete2(e:Event):void
		{
			$log.debug("data loaded");
			var bytes:ByteArray = bloader.data as ByteArray;
			loader.loadBytes(bytes);			
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.L)
			{
				System.setClipboard($log.flush());
			}
		}
	}
}