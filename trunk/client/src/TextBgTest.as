package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class TextBgTest extends Sprite
	{
		public var loader:Loader = new Loader();
		public var url:String = "../res/";
		public var textBnd:Sprite = new Sprite();
		
		public function TextBgTest()
		{
			super();
			loader.load(new URLRequest(url));
			addChild(loader);
			addChild(textBnd);
		}
		
		private function onComplete(e:Event):void
		{
			
		}
		
		
	}
}