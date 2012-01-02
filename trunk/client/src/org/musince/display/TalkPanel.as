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
	
	import org.musince.util.DisplayUtil;
	
	public class TalkPanel extends UC
	{
		private var _t:int = 255/3;
		private var _bg:Bitmap = new Bitmap();
		private var _contentLayer:Sprite = new Sprite();
		public var talkText:TextField = new TextField();
		private var _select:Shape;
		private var H:int = 20;
		
		private var _selectIndex:int = 0;
		
		public function TalkPanel()
		{
			super();
			_select = new Shape();
			_select.graphics.beginFill(0xFF0000, 0.5);
			_select.graphics.drawRect(0, 0, 1280, 20);
			_select.graphics.endFill();
			addChild(_bg);
			addChild(_contentLayer);
			addChild(talkText);
			format(talkText);
		}
		
		private function format(text:TextField):void
		{
			text.selectable = false;
			var tf:TextFormat = new TextFormat();
			tf.color = 0xFFFFFF;
			tf.font = "KaiTi_GB2312";
			tf.size = 24;
			tf.leading = 6;
			text.defaultTextFormat = tf;
			text.wordWrap = true;
			text.filters = [new GlowFilter(0x33FF00, 1, 2, 2, 3)];
		}
		
		private function createText():TextField
		{
			var text:TextField = new TextField();
			format(text);
			text.x = 20;
			text.y = 20;
			text.width = 1240;
			text.height = 160;
			return text;
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
		
		public var choices:Vector.<TextField>;
		
		public function createChoice(text:Array):Vector.<TextField>
		{
			choices = new Vector.<TextField>(text.length);
			var tf:TextField;
			DisplayUtil.removeChildren(_contentLayer);
			for (var i:int = 0; i < text.length; i++)
			{
				tf = new TextField();
				format(tf);
				tf.text = text[i];
				tf.cacheAsBitmap = true;
				tf.y = i * H;
				_contentLayer.addChild(tf);
				choices[i] = tf;
			}
			return choices;
		}
		
		public function select(index:int):void
		{
			addChildAt(_select, 0);
			_select.y = index * H;
			_selectIndex = index;
		}
		
		public function chooseUp():void
		{
			select(Math.max(_selectIndex-1, 0));
		}
		
		public function chooseDown():void
		{
			select(Math.min(_selectIndex+1, choices.length));
		}
		
		public function selecting():int
		{
			return _selectIndex;
		}
		
	}
}