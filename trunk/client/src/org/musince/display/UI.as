package org.musince.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Dictionary;
	
	import slices.BlankTime;
	import slices.Choosing;
	import slices.FadeDisplayObject;
	import slices.FadeInDisplayObject;
	import slices.FadeInTalk;
	import slices.FadeOutDisplayObject;
	import slices.PlayChoice;
	import slices.PlayTalk;
	import slices.PlayTalkAvg;
	import slices.Progress;
	import slices.UpdateProgress;
	import slices.TimeSlice;
	import globals.$athena;
	import globals.$background;
	import globals.$guideText;
	import org.musince.logic.GameObject;
	import utils.DisplayUtil;
	import org.musince.util.TextFieldUtil;
	
	public class UI extends GameObject
	{
		public static var WIDTH:int = 1280;
		public static var HEIGHT:int = 720;
		
		private var root:Sprite; 
		
		public var _talk:TalkPanel;
		public var backgroundLayer:Sprite = new Sprite();
		public var guideLayer:Sprite = new Sprite();
		public var monoLayer:Sprite = new Sprite();
		public var clickIconLayer:Sprite = new Sprite();
		public var talkLayer:Sprite = new Sprite();
		public var loadingLayer:Sprite = new Sprite();
		
//		private var _updateProgress:UpdateProgress;
//		private var _progressPanel:ProgressPanel = new ProgressPanel();
		
		public function UI(root:Sprite)
		{
			super();
			this.root = root;
//			_talk = new TalkPanel();
//			_talk.setSize(WIDTH, 200);
//			_talk.y = 520;
			root.addChild(backgroundLayer);
			root.addChild(monoLayer);
			root.addChild(guideLayer);
			root.addChild(talkLayer);
			root.addChild(clickIconLayer);
			root.addChild(loadingLayer);
		}
		
		public function changeBackground(v:DisplayObject):void
		{
			if (backgroundLayer.numChildren != 0)
			{
				var old:DisplayObject = backgroundLayer.removeChildAt(0);
				var fadeOut:FadeOutDisplayObject = new FadeOutDisplayObject(old, 0.05);
				fadeOut.endHook = onFadeOutOldBg;
				$athena.addTimeSlice(fadeOut);
			}
			$background = v;
			backgroundLayer.addChild(v);
			v.alpha = 0;
			var fadeIn:FadeInDisplayObject = new FadeInDisplayObject(v, 0.05);
			$athena.addTimeSlice(fadeIn);
			ajustBndPosition();
		}
		
		public function onFadeOutOldBg(ts:TimeSlice):void
		{
			var fade:FadeOutDisplayObject = ts as FadeOutDisplayObject;
			if (backgroundLayer.contains(fade.target))
			{
				backgroundLayer.removeChild(fade.target);
			}
		}
		
		public function ajustBndPosition():void
		{
			var bound:Rectangle = backgroundLayer.getBounds(backgroundLayer);
			backgroundLayer.x = (WIDTH - bound.width) / 2;
			backgroundLayer.y = (HEIGHT - backgroundLayer.height) / 2;			
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
			while (backgroundLayer.numChildren > 0)
			{
				backgroundLayer.removeChildAt(0);
			}
		}
		
		public function clear():void
		{
			clearBackGround();
			guideLayer.removeChildren();
			clickIconLayer.removeChildren();
			monoLayer.removeChildren();
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