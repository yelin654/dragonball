package org.musince.display
{
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	public class TalkPanel extends UC
	{
		private var _t:int = 255/3;
		
		public function TalkPanel()
		{
			super();
		}
		
		private function drawBackGround(w:int, h:int):void
		{
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(w, h);
			graphics.clear();
			graphics.beginGradientFill(GradientType.LINEAR, 
				[0x000000, 0x000000, 0x000000, 0x000000],
				[0, 0.5, 0.5, 0], 
				[0, _t, 255 - _t, 255], matrix);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
		
		public function setSize(w:int, h:int):void
		{
			drawBackGround(w, h);
		}
	}
}