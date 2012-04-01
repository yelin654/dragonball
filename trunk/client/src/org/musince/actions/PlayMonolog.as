package org.musince.actions
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$athena;
	import org.musince.global.$height;
	import org.musince.global.$sender;
	import org.musince.global.$stage;
	import org.musince.global.$ui;
	import org.musince.global.$width;
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
		
		private var _plays:Array = new Array();
		private var _blanks:Array = new Array();
		
		override public function onStart():void
		{
			tfs = new Array(texts.length);
			var tf:TextField;
			var play:PlayTalkAvg;
			var blank:BlankTime = new BlankTime(0);
			var first:BlankTime = blank;
			container.y = $height/2 - texts.length*50/2;
			for (var i:int = 0; i < texts.length; i++)
			{
				tf = TextFieldUtil.getTextField(40);
				tf.text = texts[i];
				tf.x = $width/2 - tf.textWidth/2;
				tf.text = "";
				tfs[i] = tf;
				play = new PlayTalkAvg(tf);
				blank.appendNext(play);
				blank = new BlankTime(1000);
				play.appendNext(blank);
				play.input["text"] = texts[i];
				tf.y = i * 50;
				container.addChild(tf);
				
				_plays.push(play);
				_blanks.push(blank);
			}
			blank.endHook = onOver;
			$athena.addTimeSlice(first);
			
			globalMouseClick = onMouseClick;
		}
		
		public function onMouseClick(e:MouseEvent):void
		{
			for each (var play:PlayTalkAvg in _plays)
			{
				$athena.removeTimeSlice(play);
			}
			for each (var blank:BlankTime in _blanks)
			{
				$athena.removeTimeSlice(blank);
			}
			var tf:TextField;
			container.y = $height/2 - texts.length*50/2;
			for (var i:int = 0; i < texts.length; i++)
			{
				tfs[i].text = texts[i];
			}
			onOver(null);
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