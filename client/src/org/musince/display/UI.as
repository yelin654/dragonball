package org.musince.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;
	
	import org.musince.actions.BlankTime;
	import org.musince.actions.Choosing;
	import org.musince.actions.FadeInTalk;
	import org.musince.actions.PlayChoice;
	import org.musince.actions.PlayTalk;
	import org.musince.actions.PlayTalkAvg;
	import org.musince.actions.Progress;
	import org.musince.actions.UpdateProgress;
	import org.musince.core.TimeSlice;
	import org.musince.global.$athena;
	import org.musince.global.$guideText;
	import org.musince.logic.GameObject;
	import org.musince.util.DisplayUtil;
	import org.musince.util.TextFieldUtil;
	
	public class UI extends GameObject
	{
		public static var WIDTH:int = 1280;
		public static var HEIGHT:int = 720;
		
		private var root:Sprite; 
		
		public var _talk:TalkPanel;
		public var _backLayer:Sprite = new Sprite();
		public var contentLayer:Sprite = new Sprite();
		public var clickIconLayer:Sprite = new Sprite();
		
//		private var _updateProgress:UpdateProgress;
//		private var _progressPanel:ProgressPanel = new ProgressPanel();
		
		public function UI(root:Sprite)
		{
			super();
			this.root = root;
			_talk = new TalkPanel();
			root.addChild(_backLayer);
			root.addChild(contentLayer);
			_talk.setSize(WIDTH, 200);
			_talk.y = 520;
			var tf:TextField = TextFieldUtil.getTextField();
			tf.autoSize = TextFieldAutoSize.NONE;
			tf.width = root.stage.stageWidth;
			tf.alpha = 0;
			tf.y = HEIGHT/2 - tf.height/2;
			$guideText = tf;
			
			root.addChild(clickIconLayer);
		}
		
		public function changeBackground(v:DisplayObject):void
		{
			_backLayer.addChild(v);
			ajustBndPosition();
		}
		
		public function ajustBndPosition():void
		{
			var bound:Rectangle = _backLayer.getBounds(_backLayer);
			_backLayer.x = (WIDTH - bound.width) / 2;
			_backLayer.y = (HEIGHT - _backLayer.height) / 2;			
		}
		
		public function changeBackgroundU(url:String):void
		{
			
		}
		
		public function playSimpleTalk(text:String):void
		{
			var talk:PlayTalk = new PlayTalkAvg(_talk.talkText);
			if (root.contains(_talk))
			{
				talk.input["text"] = text;
				$athena.addTimeSlice(talk);
			}
			else
			{
				var input:Dictionary = new Dictionary();
				input["text"] = text;
				fadeInTalk(input, talk);
			}
//			_talk.alpha = 0;
		}
		
		public function playMetaTalk(id:int):void
		{
			
		}
		
		public function clearBackGround():void
		{
			while (_backLayer.numChildren > 0)
			{
				_backLayer.removeChildAt(0);
			}
		}
		
		public function clear():void
		{
			clearBackGround();
			contentLayer.removeChildren();
			clickIconLayer.removeChildren();
		}
		
//		public function startProgress(_progress:Progress):void
//		{

//			_root.addChild(_progressPanel);
//			_updateProgress = new UpdateProgress(_progress, _progressPanel);
//			$athena.addTimeSlice(_progress);
//			$athena.addTimeSlice(_updateProgress);
//		}
		
//		public function closeProgress():void
//		{
//			_updateProgress.isEnd = true;
//			_updateProgress = null;
//		}
		
		public function playChoice(choices:Array):void
		{	
			var play:PlayChoice = new PlayChoice(_talk);
			var wait:Choosing = new Choosing(_talk);
			play.appendNext(wait);
			
			if (root.contains(_talk))
			{
				play.input["choices"] = choices;
				$athena.addTimeSlice(play);
			}
			else
			{
				var input:Dictionary = new Dictionary();
				input["choices"] = choices;
				fadeInTalk(input, play);
			}
//			_talk.alpha = 0;
		}
		
		public function fadeInTalk(input:Dictionary, next:TimeSlice):void
		{
			_talk.alpha = 0;
			root.addChild(_talk);
			var fade:FadeInTalk = new FadeInTalk(_talk);
			var blank:BlankTime = new BlankTime();
			blank.last = 500;
			fade.input = input;
			fade.appendNext(blank);
			blank.appendNext(next);
			$athena.addTimeSlice(fade);
		}
		
		public function playSound():void
		{
			
		}
	}
}