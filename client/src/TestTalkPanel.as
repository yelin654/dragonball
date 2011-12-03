package
{
	import flash.display.Sprite;
	
	import org.musince.display.TalkPanel;
	
	[SWF(width='1280',height='720')]
	
	public class TestTalkPanel extends Sprite
	{
		public function TestTalkPanel()
		{
			super();
			var panel:TalkPanel = new TalkPanel();
			panel.setSize(1280, 200);
			addChild(panel);
		}
	}
}