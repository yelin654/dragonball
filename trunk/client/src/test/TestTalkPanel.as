package test
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	
	import slices.FadeInTalk;
	import slices.PlayTalk;
	import slices.PlayTalkAvg;
	import org.musince.display.TalkPanel;
	import globals.$athena;
	import globals.$root;
	import globals.$stage;
	
	[SWF(width='1280',height='720')]
	
	public class TestTalkPanel extends Sprite
	{
		public var timer:Timer = new Timer(1000, 1);
		
		public function TestTalkPanel()
		{
			super();
			$stage = stage;
			$stage.color = 0x000000;
			$root = this;
			$athena.start(stage);
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
			timer.start();
		}
		
		public function onTimer(e:Object):void
		{
			var panel:TalkPanel = new TalkPanel();
			panel.switchToTalk();
//			panel.setSize(1280, 200);
			addChild(panel);
//			panel.alpha = 0;
//			var fadein:FadeInTalk = new FadeInTalk(panel);
			var txt:String = "人之初，性本善。性相近，习相远。苟不教，性乃迁。教之道，贵以专。昔孟母，择邻处，子不学，断机杼。窦燕山，有义方，教五子，名俱扬。养不教，父之过。教不严，师之惰。子不学，非所宜。幼不学，老何为。";
//			var txt:String = "人之初，性本善。"
			var talk:PlayTalk = new PlayTalkAvg(panel.talkText);
			talk.input["text"] = txt;
//			fadein.appendNext(talk);
			$athena.addTimeSlice(talk);
			panel.talkText.filters = [new GlowFilter(0xE75C86, 1, 2, 2, 4)];
			
			panel.setFromName("叶霖");
			panel.setThoughName("QQ");
//			$athena.addTimeSlice(talk);
		}
	}
}