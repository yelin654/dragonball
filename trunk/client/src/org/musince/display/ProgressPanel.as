package org.musince.display
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import globals.$height;
	import globals.$root;
	import globals.$width;
	import org.musince.util.TextFieldUtil;
	
	public class ProgressPanel extends Sprite
	{
		private var _tf:TextField;
		
		public function ProgressPanel()
		{
			super();
			_tf = TextFieldUtil.getTextField();
			_tf.autoSize = TextFieldAutoSize.NONE;
			_tf.width = $width;
			_tf.y = $height / 2 + 10;
			addChild(_tf);
		}
		
		public function update(scale:Number):void
		{
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(1, 0xFFFFFF);
			g.moveTo(0, $height/2);
			g.lineTo($width * scale, $height/2);
			_tf.text = int(scale * 100) + "%";
		}
	}
}