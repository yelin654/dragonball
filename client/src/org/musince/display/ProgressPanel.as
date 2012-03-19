package org.musince.display
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import org.musince.global.$root;
	import org.musince.util.TextFieldUtil;
	
	public class ProgressPanel extends Sprite
	{
		private var _tf:TextField;
		
		public function ProgressPanel()
		{
			super();
			_tf = TextFieldUtil.getTextField();
			_tf.autoSize = TextFieldAutoSize.NONE;
			_tf.width = $root.stage.stageWidth;
			_tf.y = $root.stage.stageHeight / 2 + 10;
			addChild(_tf);
		}
		
		public function update(scale:Number):void
		{
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(1, 0xFFFFFF);
			g.moveTo(0, $root.stage.stageHeight/2);
			g.lineTo($root.stage.stageWidth * scale, $root.stage.stageHeight/2);
			_tf.text = int(scale * 100) + "%";
		}
	}
}