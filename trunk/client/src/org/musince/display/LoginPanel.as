package org.musince.display
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.musince.actions.DrawLine;
	import org.musince.actions.PlayTalkAvg;
	import org.musince.global.$athena;
	
	public class LoginPanel extends UC
	{
		public var u:TextField = new TextField();
		public var tip:TextField = new TextField();
		public var w:int;
		public var h:int;
		
		
		public function LoginPanel(w:int=1280, h:int=720)
		{
			super();
			this.w = w;
			this.h = h;
			
			u.type = TextFieldType.INPUT;
			u.maxChars = 20;
			u.width = 250;
			u.autoSize = TextFieldAutoSize.CENTER;
			var tf:TextFormat = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.color = 0xFFFFFF;
			tf.font = "KaiTi_GB2312";
			tf.size = 40;
			u.defaultTextFormat = tf;			
			u.x = (w-u.width)/2;
			u.y = (h-u.height)*2/3;
			u.text = "input name";
			addChild(u);
			
			tip.selectable = false;
			tip.width = w;
			tip.defaultTextFormat = tf;
			tip.y = h/3-50;
//			tip.text = "login";
			addChild(tip);
		}
		
		override public function fadeIn():void
		{
			var graphics:Graphics = this.graphics;
			graphics.lineStyle(2, 0xFFFFFF);
			var drawline:DrawLine = new DrawLine(graphics, 0.04, {t:2, c:0xFFFFFF});
			drawline.input = new Object();
			drawline.input.from = new Point(int(w/3), int(h/3));
			drawline.input.to = new Point(int(w-w/3), int(h/3));
			var playText:PlayTalkAvg = new PlayTalkAvg(tip, 100);
			playText.input = "login";
			drawline.appendNext(playText);
			$athena.addTimeSlice(drawline);
		}
	}
}