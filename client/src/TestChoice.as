package
{
	import flash.display.Sprite;
	
	import org.musince.actions.PlayChoice;
	import org.musince.actions.WaitingForChoose;
	import org.musince.display.TalkPanel;
	import org.musince.global.$athena;
	import org.musince.global.$root;
	
	[SWF(width='1280',height='720')]
	
	public class TestChoice extends Sprite
	{
		public function TestChoice()
		{
			super();
			$root = this;
			var talk:TalkPanel = new TalkPanel();
			talk.setSize(1280, 300);
			addChild(talk);
			var play:PlayChoice = new PlayChoice(talk);
			play.input = ["AAAAAA", "BBBBBB", "CCCCCC", "DDDDDD"];
			var wait:WaitingForChoose = new WaitingForChoose(talk);
			play.appendNext(wait);
			$athena.start(stage);
			$athena.addTimeSlice(play);
		}
	}
}