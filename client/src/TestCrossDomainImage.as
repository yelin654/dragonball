package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class TestCrossDomainImage extends Sprite
	{
		public var url:String = "http://www.ninokuni.jp/images/ss/about_ss01.jpg";
		
		public var loader:Loader = new Loader();
		
		public function TestCrossDomainImage()
		{
			super();
			loader.load(new URLRequest(url));
//			addChild(loader);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(e:Event):void
		{
			var s:Sprite = new Sprite();			
			s.addChild(loader);
			var bd:BitmapData = new BitmapData(400, 400, true, 0x00000000);
			bd.draw(s);
			addChild(new Bitmap(bd));
		}
	}
}