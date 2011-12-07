package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.musince.display.TalkPanel;
	import org.musince.display.UI;
	import org.musince.global.$athena;
	
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
			$athena.start(stage);
		}
		
		public function onLoad(e:Event):void
		{
			ui.changeBackground(loader);
			var txt:String = "人之初，性本善。性相近，习相远。苟不教，性乃迁。教之道，贵以专。昔孟母，择邻处，子不学，断机杼。窦燕山，有义方，教五子，名俱扬。养不教，父之过。教不严，师之惰。子不学，非所宜。幼不学，老何为。";
			ui.playSimpleTalk(txt);
		}
	}
}