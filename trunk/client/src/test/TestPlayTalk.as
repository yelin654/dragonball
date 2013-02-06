package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import slices.PlayTalk;
	import org.musince.data.MetaTalkText;
	import globals.$athena;
	import slices.Athena;
	
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
			var talk:PlayTalk = new PlayTalk(tf);
			$athena.start(stage);
			$athena.addTimeSlice(talk);
			addChild(tf);
		}
	}
}