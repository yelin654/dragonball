package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import slices.FadeInDisplayObject;
	import slices.FadeInOutDisplayObject;
	import slices.FadeOutDisplayObject;
	import slices.PlayGuideText;
	import globals.$athena;
	import globals.$guideText;
	import globals.$root;
	import org.musince.util.TextFieldUtil;

	[SWF(width='1280',height='720', backgroundColor='0x000000')]
	
	public class TestGuideText extends Sprite
	{
		public function TestGuideText()
		{
			$root = this;
			var tf:TextField = TextFieldUtil.getTextField();
			tf.autoSize = TextFieldAutoSize.NONE;
			tf.width = 1280;
			tf.alpha = 0;
			tf.y = 300;
			tf.text = "all this you can, leave behind";
			$guideText = tf;
//			var fadeInOut:FadeInOutDisplayObject = new FadeInOutDisplayObject(tf, 0.01, 1000);
//			fadeInOut.appendNext(fadeInOut);
			var playGuide:PlayGuideText = new PlayGuideText(["你不知道", "其实", "你就是个2货"], 0.02);
			addChild(tf);
			$athena.start(stage);
			$athena.addTimeSlice(playGuide);
		}
	}
}