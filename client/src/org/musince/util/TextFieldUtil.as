package org.musince.util
{
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TextFieldUtil
	{
		public function TextFieldUtil()
		{
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
		
		public static function getTextFormat(size:int=40):TextFormat
		{
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.color = 0xFFFFFF;
			tf.font = "KaiTi_GB2312";
			tf.size = size;
			return tf;
		}
		
		public static function getTextField(size:int=40):TextField
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = getTextFormat(size);
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