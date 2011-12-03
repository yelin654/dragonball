package org.musince.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import org.musince.data.MetaTalkText;
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
			_root.addChild(_talk);
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
			
		}
		
		public function playMetaTalk(id:int):void
		{
			
		}
	}
}