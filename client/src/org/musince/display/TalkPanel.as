package org.musince.display
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class TalkPanel extends UC
	{
		private var _t:int = 255/3;
		private var _bg:Bitmap = new Bitmap();
		public var text:TextField = new TextField();
		
		public function TalkPanel()
		{
			super();
			addChild(_bg);
			addChild(text);
			initTextFormat();
		}
		
		private function initTextFormat():void
		{
			text.selectable = false;
			var tf:TextFormat = new TextFormat();
			tf.color = 0xFFFFFF;
			tf.font = "KaiTi_GB2312";
			tf.size = 24;
			tf.leading = 6;
			text.defaultTextFormat = tf;
			text.wordWrap = true;
			text.x = 20;
			text.y = 20;
			text.width = 1240;
			text.height = 160;
//			text.filters = [new GlowFilter(0x33FF00, 1, 2, 2, 3)];
		}
		
		private function drawBackGround(w:int, h:int):void
		{
			var shape:Shape = new Shape();
			var grapchics:Graphics = shape.graphics;
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(w, h);
			graphics.clear();
			graphics.beginGradientFill(GradientType.LINEAR, 
				[0x000000, 0x000000, 0x000000, 0x000000],
				[0, 0.5, 0.5, 0], 
				[0, _t, 255 - _t, 255], matrix);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
			var data:BitmapData = new BitmapData(w, h, true, 0x00000000);
			data.draw(shape);
			_bg.bitmapData = data;
			addChild(_bg);
		}
		
		public function setSize(w:int, h:int):void
		{
			drawBackGround(w, h);
		}
		
		public function createChoice(num:int):void
		{
			
		}
	}
}