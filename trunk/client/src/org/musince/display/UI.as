package org.musince.display
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import org.musince.data.MetaTalkText;
	import org.musince.logic.GameObject;
	
	public class UI extends GameObject
	{
		private var _root:Sprite; 
		
		public function UI(root:Sprite)
		{
			super();
			_root = root;
		}
		
		public function changeBackground(v:DisplayObject):void
		{
			
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