package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.musince.util.TextFieldUtil;
	
	public class TestIEText extends Sprite
	{
		public function TestIEText()
		{
			super();
			var tf:TextField = TextFieldUtil.getTextField();
//			tf = $guideText;
//			tf.autoSize = TextFieldAutoSize.NONE;
//			tf.text = texts[0];
//			var tft:TextFormat = new TextFormat(null, 50, 0xFF0000);
//			tf.setTextFormat(tft);
//			$ui.clickIconLayer.addChild(tf);
		}
	}
}