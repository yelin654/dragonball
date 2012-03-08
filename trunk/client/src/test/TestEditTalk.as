package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	import org.musince.actions.PlayTalk;
	import org.musince.actions.PlayTalkVar;
	import org.musince.editor.InputTalk;
	import org.musince.global.$athena;
	import org.musince.logic.Athena;
	
	[SWF(width='800',height='600', backgroundColor='0x000000')]
	
	public class TestEditTalk extends Sprite
	{
		public function TestEditTalk()
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
			
			var edit:InputTalk = new InputTalk(tfin, tf);
			var play:PlayTalk = new PlayTalkVar(tf);
			edit.appendNext(play);
			play.appendNext(edit);

			$athena.start(stage);
			$athena.addTimeSlice(edit);
			
			addChild(tf);
			addChild(tfin);
			
		}
	}
}