package org.musince.util
{
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import globals.$config;

	public class TextFieldUtil
	{
		public function TextFieldUtil()
		{
		}
		
		public static function layCenter(w:int, tf:TextField, text:String):void
		{
			tf.text = text;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.x = w/2 - tf.textWidth/2;
			tf.text = "";
		}
		
		/**
		 * 调整字符个数以适应最大宽，超过的用"..."表示 
		 * @param tf
		 * 
		 */
		public static function ajustCharacterCount(tf:TextField):void
		{
			var s:String = tf.text;
			while (tf.width < tf.textWidth)
			{
				s = s.substr(0, s.length-1);
				tf.text = s + "...";
			}
		}
		
		//"KaiTi_GB2312"
		public static function getTextFormat(size:int=40, color:uint=0xFFFFFF, font:String="STKaiti"):TextFormat
		{
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.color = color;
			tf.font = font;
			tf.size = size;
			return tf;
		}
		
		public static function getMonoText():TextField {
			var tf:TextField = new TextField();
			tf.embedFonts = $config.embedFont;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			var tft:TextFormat = getTextFormat();
			tft.font = "STKaiti";
			tf.defaultTextFormat = tft;			
			return tf;
		}
		
		public static function getUIText(size:int=36, color:uint=0xFFFFFF):TextField {
			var tf:TextField = new TextField();
			tf.embedFonts = $config.embedFont;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			tf.antiAliasType = AntiAliasType.ADVANCED;
			var tft:TextFormat = getTextFormat(size, color,"Microsoft YaHei");
			tf.defaultTextFormat = tft;			
			return tf;
		}
		
		public static function getTextField(size:int=40, color:uint=0xFFFFFF, embed:Boolean=true):TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = getTextFormat(size, color);
			tf.embedFonts = embed;
			tf.autoSize = TextFieldAutoSize.LEFT;
			tf.selectable = false;
			return tf;
		}
		
		public static function getBorderTextField(size:int=40, border:uint=0x000000):TextField
		{
			var tf:TextField = getTextField(size);
			tf.filters = [new GlowFilter(border, 1, 2, 2, 10)];  
			return tf; 	
		}
	}
}