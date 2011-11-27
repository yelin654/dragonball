package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	public class TestCrossDomainImage extends Sprite
	{
		public var url:String = "http://www.ninokuni.jp/images/ss/about_ss01.jpg";
		
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
		}
		
		private function onComplete(e:Event):void
		{
			var s:Sprite = new Sprite();			
			s.addChild(loader);
			var bd:BitmapData = new BitmapData(400, 400, true, 0x00000000);
			bd.draw(s);
			addChild(new Bitmap(bd));
			trace("b com");
		}
		
		private function onComplete2(e:Event):void
		{
			var bytes:ByteArray = bloader.data as ByteArray;
			loader.loadBytes(bytes);
		}
	}
}