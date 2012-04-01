package test
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import org.musince.util.TextFieldUtil;

	[SWF(width="1280", height="720", backgroundColor="0x000000")]
	
	public class TestTextFieldOverOut extends Sprite
	{
		public function TestTextFieldOverOut()
		{
			super();
			var tf:TextField = TextFieldUtil.getTextField(40);
			tf.x = 200;
			tf.y = 200;
			tf.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			tf.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			addChild(tf);
			tf.text = "ABCDEFG";
		}
		
		public function onOver(e:MouseEvent):void
		{
			trace("over");
		}
		
		public function onOut(e:MouseEvent):void
		{
			trace("out");
		}
	}
}