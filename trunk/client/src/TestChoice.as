package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.musince.actions.PlayChoice;
	import org.musince.actions.WaitingForChoose;
	import org.musince.display.TalkPanel;
	import org.musince.display.UI;
	import org.musince.global.$athena;
	import org.musince.global.$root;
	import org.musince.global.$ui;
	
	[SWF(width='1280',height='720')]
	
	public class TestChoice extends Sprite
	{
		public function TestChoice()
		{
			super();
			$root = this;
			$athena.start(stage);
			$ui = new UI(this);
			var timer:Timer = new Timer(1000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimer);
			timer.start();
//			var talk:TalkPanel = new TalkPanel();
//			talk.setSize(1280, 300);
//			addChild(talk);
//			var play:PlayChoice = new PlayChoice(talk);
//			play.input = ["AAAAAA", "BBBBBB", "CCCCCC", "DDDDDD"];
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