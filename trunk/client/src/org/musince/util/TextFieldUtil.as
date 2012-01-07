package org.musince.util
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	public class TextFieldUtil
	{
		public function TextFieldUtil()
		{
		}
		
		public static function getTextFormat():TextFormat
		{
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.color = 0xFFFFFF;
			tf.font = "KaiTi_GB2312";
			tf.size = 40;
			return tf;
		}
	}
}