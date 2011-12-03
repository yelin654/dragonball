package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.musince.display.TalkPanel;
	import org.musince.display.UI;
	
	[SWF(width='1280',height='720', backgroundColor='0x000000')]
	
	public class TestUI extends Sprite
	{
		public var panel:TalkPanel;
		public var loader:Loader = new Loader();
		public var ui:UI;
		
		public function TestUI()
		{
			super();
			ui = new UI(this);
			loader.load(new URLRequest("../res/1441121_1321877662.jpg"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
			
		}
		
		public function onLoad(e:Event):void
		{
			ui.changeBackground(loader);
		}
	}
}