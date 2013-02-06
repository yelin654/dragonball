package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import slices.Choosing;
	import slices.PlayChoice;
	import org.musince.display.TalkPanel;
	import org.musince.display.UI;
	import globals.$athena;
	import globals.$root;
	import globals.$sender;
	import globals.$talkPanel;
	import globals.$ui;
	import org.musince.util.LuaUtil;
	
	[SWF(width="1280", height="720", backgroundColor="0xFFFFFF")]
	
	public class TestChoice extends Sprite
	{
		public function TestChoice()
		{
			super();
			$root = this;
			$athena.start(stage);
			
//			var timer:Timer = new Timer(1000, 1);
//			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
//			timer.start();
//			var talk:TalkPanel = new TalkPanel();
//			talk.setSize(1280, 300);
//			addChild(talk);
			$sender = new LocalSender;
			var meta:Dictionary = new Dictionary();
			meta.alters = LuaUtil.convertToDict(["AAAAAA", "BBBBBB", "CCCCCC", "DDDDDD"]);
			var play:PlayChoice = new PlayChoice($talkPanel);
			play.input = meta;
			$talkPanel.switchToChoice();
			addChild($talkPanel);
			$athena.addTimeSlice(play);
//			var wait:WaitingForChoose = new WaitingForChoose(talk);
//			play.appendNext(wait);
			
//			$athena.addTimeSlice(play);
		}
		
		public function onTimer(e:Event):void
		{
			var choices:Array = ["AAAAAA", "BBBBBB", "CCCCCC", "DDDDDD"];
			$ui.playChoice(choices);
		}
	}
}