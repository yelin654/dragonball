package org.musince.actions
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$athena;
	import org.musince.global.$sender;
	import org.musince.global.$stage;
	import org.musince.global.$ui;
	import org.musince.util.TextFieldUtil;
	
	public class PlayMonolog extends TimeSlice
	{
		public var container:Sprite;
		public var texts:Array;
		public var tfs:Array;
		public var border:uint;
		
		public function PlayMonolog(container:Sprite, texts:Array, border:uint=0x000000)
		{
			super();
			this.texts = texts;
			this.container = container;
			this.border = border;
		}
		
		override public function onStart():void
		{
			tfs = new Array(texts.length);
			var tf:TextField;
			var play:PlayTalkAvg;
			var blank:BlankTime = new BlankTime(0);
			var first:BlankTime = blank;
			var tft:TextFormat;
			container.y = $stage.stageHeight/2 - texts.length*50/2;
			for (var i:int = 0; i < texts.length; i++)
			{
//				tf = TextFieldUtil.getBorderTextField(40, border);
				tf = TextFieldUtil.getTextField(40);
				tf.text = texts[i];
				tf.x = $stage.stageWidth/2 - tf.textWidth/2;
				tf.text = "";
				play = new PlayTalkAvg(tf);
				blank.appendNext(play);
				blank = new BlankTime(1000);
				play.appendNext(blank);
				play.input["text"] = texts[i];
				tf.y = i * 50;
				container.addChild(tf);
			}
			blank.endHook = onOver;
			$athena.addTimeSlice(first);
		}
		
		public function onOver(ts:TimeSlice):void
		{
//			var rpc:SendRPC = new SendRPC("next_main_action", null);
			var click:WaitingForClick = new WaitingForClick();
			click.endHook = onClick;
//			click.appendNext(rpc);
			$athena.addTimeSlice(click);
			isEnd = true;
		}
		
		public function onClick(ts:TimeSlice):void
		{
			$sender.lua_rpc("next_main_action");
			$ui.monoLayer.removeChildren();
		}
	}
}