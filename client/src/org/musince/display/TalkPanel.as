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
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import org.musince.global.$stage;
	import org.musince.global.$width;
	import org.musince.util.DisplayUtil;
	import org.musince.util.TextFieldUtil;
	
	public class TalkPanel extends UC
	{
		private var _t:int = 255/3;
		private var _bg:Bitmap = new Bitmap();
		private var contentLayer:Sprite = new Sprite();
		private var talkLayer:Sprite = new Sprite();
		private var choiceLayer:Sprite = new Sprite();
		private var _fromName:TextField;
		private var _fromBottom:Shape = new Shape();
		private var _fromWidth:int = 150;
		private var _thoughName:TextField;
		private var _thoughBottom:Shape = new Shape();
		private var _thoughWidth:int = 160;
		public var talkText:TextField;
		private var _select:Bitmap = new Bitmap();
		private var H:int = 40;
		private var _tsize:int = 34;
		
		private var _selectIndex:int = 0;
		
		public function TalkPanel()
		{
			super();
			setSize($width, 200);
			drawSelect();

			addChild(contentLayer);
			
			talkText = createText();
			talkLayer.addChild(talkText);
			format(talkText);
			
			var g:Graphics = _fromBottom.graphics;
			g.lineStyle(2, 0xFFFFFF);
			g.lineTo(_fromWidth, 0);
			_fromBottom.x = 20;
			_fromBottom.y = _tsize+4;
			_fromName = TextFieldUtil.getTextField(_tsize);
			_fromName.autoSize = TextFieldAutoSize.NONE;
			_fromName.width = _fromWidth;
			_fromName.x = 20;
			_fromName.y = 2;
			talkLayer.addChild(_fromName);
			
			g = _thoughBottom.graphics;
			g.lineStyle(2, 0xFFFFFF);
			g.lineTo(_thoughWidth, 0);
			_thoughBottom.x = 1100;
			_thoughBottom.y = _tsize+4;
			_thoughName = TextFieldUtil.getTextField(_tsize);
			_thoughName.autoSize = TextFieldAutoSize.NONE;
			_thoughName.width = _thoughWidth;
			_thoughName.x = 1100;
			_thoughName.y = 2;
			talkLayer.addChild(_thoughName);
			
			choiceLayer.y = 20;
		}
		
		public function drawSelect():void
		{
			var shape:Shape = new Shape();
			var graphics:Graphics = shape.graphics;
			var matrix:Matrix = new Matrix();
			var w:int = 800;
			matrix.createGradientBox(w, H);
			graphics.clear();
//			var color:uint = 0xFF6600;
			var color:uint = 0xDF2B61;
//			var color:uint = 0xE75C86
			graphics.beginGradientFill(GradientType.LINEAR, 
				[color, color, color, color],
				[0, 0.5, 0.5, 0], 
				[0, _t, 255 - _t, 255], matrix);
			graphics.drawRect(0, 0, w, H);
			graphics.endFill();
			var data:BitmapData = new BitmapData(w, H, true, 0x00000000);
			data.draw(shape);
			_select.bitmapData = data;
			_select.x = $width/2 - w/2;
		}
		
		public function switchToTalk():void
		{
			contentLayer.removeChildren();
			contentLayer.addChild(talkLayer);
		}
		
		public function switchToChoice():void
		{
			contentLayer.removeChildren();
			contentLayer.addChild(choiceLayer);
		}
		
		private function format(text:TextField):void
		{
			text.selectable = false;
			var tf:TextFormat = new TextFormat();
			tf.color = 0xFFFFFF;
			tf.font = "KaiTi_GB2312";
			tf.size = 34;
			tf.leading = 5;
			text.defaultTextFormat = tf;
			text.wordWrap = true;
		}
		
		private function createText():TextField
		{
			var text:TextField = new TextField();
			format(text);
			text.x = 20;
			text.y = 43;
			text.width = 1240;
			text.height = 160;
			return text;
		}
		
		private function drawBackground(w:int, h:int):void
		{
			var shape:Shape = new Shape();
			var graphics:Graphics = shape.graphics;
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
			addChildAt(_bg, 0);
		}
		
		private function drawNameBackground():void
		{
			var shape:Shape = new Shape();
		}
		
		public function setSize(w:int, h:int):void
		{
			drawBackground(w, h);
		}
		
		public var choices:Vector.<TextField>;
		
		public function createChoice(text:Array):Vector.<TextField>
		{
			choices = new Vector.<TextField>(text.length);
			var tf:TextField;
			choiceLayer.removeChildren();
			for (var i:int = 0; i < text.length; i++)
			{
				tf = TextFieldUtil.getTextField(_tsize);
				tf.autoSize = TextFieldAutoSize.NONE;
				tf.width = $width;
				tf.text = text[i];
				tf.cacheAsBitmap = true;
				tf.y = i * H;
				choiceLayer.addChild(tf);
				choices[i] = tf;
			}
			return choices;
		}
		
		public function select(index:int):void
		{
			choiceLayer.addChildAt(_select, 0);
			_select.y = index * H;
			_selectIndex = index;
		}
		
		public function chooseUp():void
		{
			select(Math.max(_selectIndex-1, 0));
		}
		
		public function chooseDown():void
		{
			select(Math.min(_selectIndex+1, choices.length-1));
		}
		
		public function selecting():int
		{
			return _selectIndex;
		}
		
		public function setFromName(v:String):void
		{
			if (v == "" || v == null)
			{
				if (talkLayer.contains(_fromBottom)) {
					talkLayer.removeChild(_fromBottom);
					talkLayer.removeChild(_fromName);
				}
				return;
			}
			_fromName.text = v;
			if (!talkLayer.contains(_fromBottom))
			{
				talkLayer.addChild(_fromBottom);
				talkLayer.addChild(_thoughName);
			}
		}
		
		public function setThoughName(v:String):void
		{
			if (v == "" || v == null)
			{
				if (contains(_thoughBottom)) {
					talkLayer.removeChild(_thoughBottom);
					talkLayer.removeChild(_thoughName);
				}
				return;
			}
			_thoughName.text = v;
			if (!talkLayer.contains(_thoughBottom))
			{
				talkLayer.addChild(_thoughBottom);
				talkLayer.addChild(_thoughName);
			}
		}
		
		public function clearTalk():void
		{
			talkText.text = "";
			_thoughName.text = "";
		}
		
		public function clearChoice():void
		{
			choiceLayer.removeChildren();
		}
	}
}