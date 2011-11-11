package org.musince.logic
{
	import flash.events.Event;
	import flash.utils.ByteArray;

	public class GUI extends GameObject
	{
		public const EVENT_CLICK_MAP:int = 1; 
		
		public function GUI()
		{
			owner = "yelin";
		}
		
		public function set owner(name:String):void {
			setKey(new ParamList([name]));			
		}
		
		public function dispatchUIEvent(e:GameEvent):void {

		}
		
		private function _dispatchUIEvent(e:GameEvent):void {
			
		}
		
//		override public function get ClassName():String {
//			return "GUI";
//		}
	}
}