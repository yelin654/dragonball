package
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.musince.actions.PlayTalk;
	import org.musince.data.MetaTalk;
	import org.musince.global.$athena;
	import org.musince.logic.Athena;
	
	[SWF(width='800',height='600', backgroundColor='0x000000')]
	
	public class TestPlayTalk extends Sprite
	{
		public function TestPlayTalk()
		{
			super();
			$athena = new Athena();
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.x = 20;
			tf.y = 20;
			var tft:TextFormat = new TextFormat();
			tft.color = 0xFFFFFF;
			tft.size = 40;
			tf.defaultTextFormat = tft;
			var talk:PlayTalk = new PlayTalk(tf, new MetaTalk());
			$athena.start(stage);
			$athena.addTimeSlice(talk);
			addChild(tf);
		}
	}
}