package org.musince.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.musince.actions.FadeInTalk;
	import org.musince.actions.PlayTalk;
	import org.musince.actions.PlayTalkAvg;
	import org.musince.data.MetaTalkText;
	import org.musince.global.$athena;
	import org.musince.logic.GameObject;
	
	public class UI extends GameObject
	{
		public static var WIDTH:int = 1280;
		public static var HEIGHT:int = 720;
		
		private var _root:Sprite; 
		
		private var _talk:TalkPanel;
		private var _backLayer:Sprite = new Sprite();
		
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
			var talk:PlayTalk = new PlayTalkAvg(_talk.text);
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
				fade.input = text;
				fade.appendNext(talk);
				$athena.addTimeSlice(fade);
			}
			_talk.alpha = 0;
		}
		
		public function playMetaTalk(id:int):void
		{
			
		}
	}
}