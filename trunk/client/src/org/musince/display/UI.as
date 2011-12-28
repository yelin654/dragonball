package org.musince.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import org.musince.actions.BlankTime;
	import org.musince.actions.FadeInTalk;
	import org.musince.actions.PlayTalk;
	import org.musince.actions.PlayTalkAvg;
	import org.musince.actions.Progress;
	import org.musince.actions.UpdateProgress;
	import org.musince.global.$athena;
	import org.musince.logic.GameObject;
	import org.musince.util.DisplayUtil;
	
	public class UI extends GameObject
	{
		public static var WIDTH:int = 1280;
		public static var HEIGHT:int = 720;
		
		private var _root:Sprite; 
		
		private var _talk:TalkPanel;
		private var _backLayer:Sprite = new Sprite();
		private var _updateProgress:UpdateProgress;
		private var _progressLayer:Sprite = new Sprite();
		
		public function UI(root:Sprite)
		{
			super();
			_root = root;
			_talk = new TalkPanel();
			_root.addChild(_backLayer);
			_talk.setSize(WIDTH, 200);
			_talk.y = 520;
//			_root.addChild(_talk);
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
			if (_root.contains(_talk))
			{
				talk.input = text;
				$athena.addTimeSlice(talk);
			}
			else
			{
				_talk.alpha = 0;
				_root.addChild(_talk);
				var fade:FadeInTalk = new FadeInTalk(_talk);
				var blank:BlankTime = new BlankTime();
				blank.last = 500;
				fade.input = text;
				fade.appendNext(blank);
				blank.appendNext(talk);
				$athena.addTimeSlice(fade);
			}
			_talk.alpha = 0;
		}
		
		public function playMetaTalk(id:int):void
		{
			
		}
		
		public function startProgress(_progress:Progress):void
		{
			while (_root.numChildren > 0)
			{
				_root.removeChildAt(0);
			}
			_root.addChild(_progressLayer);
			_updateProgress = new UpdateProgress(_progress, _progressLayer);
//			$athena.addTimeSlice(_progress);
			$athena.addTimeSlice(_updateProgress);
		}
		
		public function closeProgress():void
		{
			_updateProgress.isEnd = true;
			_updateProgress = null;
		}
		
		public function playChoice(choices:Array):void
		{
			
		}
		
		public function playSound():void
		{
			
		}
	}
}