package
{
	import flash.display.Sprite;
	
	import org.musince.actions.FadeInTalk;
	import org.musince.actions.PlayTalk;
	import org.musince.actions.PlayTalkAvg;
	import org.musince.display.TalkPanel;
	import org.musince.global.$athena;
	import org.musince.global.$root;
	
	[SWF(width='1280',height='720')]
	
	public class TestTalkPanel extends Sprite
	{
		public function TestTalkPanel()
		{
			super();
			$root = this;
			var panel:TalkPanel = new TalkPanel();
			panel.setSize(1280, 200);
			addChild(panel);
			$athena.start(stage);
//			var fadein:FadeInTalk = new FadeInTalk(panel);
//			$athena.addTimeSlice(fadein);
			var txt:String = "人之初，性本善。性相近，习相远。苟不教，性乃迁。教之道，贵以专。昔孟母，择邻处，子不学，断机杼。窦燕山，有义方，教五子，名俱扬。养不教，父之过。教不严，师之惰。子不学，非所宜。幼不学，老何为。";
			var talk:PlayTalk = new PlayTalkAvg(panel.text);
			talk.input = txt;
			$athena.addTimeSlice(talk);
		}
	}
}