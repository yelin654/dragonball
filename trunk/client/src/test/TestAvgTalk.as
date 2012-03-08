package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import org.musince.actions.PlayTalk;
	import org.musince.actions.PlayTalkAvg;
	import org.musince.global.$athena;
	
	[SWF(width='800',height='600', backgroundColor='0x000000')]
	
	public class TestAvgTalk extends Sprite
	{
		public function TestAvgTalk()
		{
			super();
			var tf:TextField = new TextField();
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.x = 20;
			tf.y = 20;
			var tft:TextFormat = new TextFormat();
			tft.color = 0xFFFFFF;
			tft.size = 40;
			tf.defaultTextFormat = tft;
			//			tf.text = "TTT"; 
			
			var tfin:TextField = new TextField();
			//			tfin.multiline = true;
			tfin.type = TextFieldType.INPUT;
			tfin.autoSize = TextFieldAutoSize.LEFT;
			tfin.x = 20;
			tfin.y = 120;
			tfin.defaultTextFormat = tft;
			tfin.border = true;
			tfin.borderColor = 0xFFFFFF;
			tfin.text = "";
			//			tfin.wordWrap = true;
			//			tfin.width = 400;
			
			var play:PlayTalk = new PlayTalkAvg(tf);
			play.input["text"] = "abcdefg";
			
			$athena.start(stage);
			$athena.addTimeSlice(play);
			
			addChild(tf);
			addChild(tfin);
		}
	}
}