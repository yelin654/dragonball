package org.musince.logic
{
	import flash.utils.Dictionary;

	public class Fightable extends GameObject
	{
		public static const METHOD_MOVE_TO:int = 0; 
		
		public function Fightable()
		{
			super();
//			trace("figher function count: " + MethodLocal.length);
		}
		
		public function moveTo(x:int, y:int):void {
			trace("fighter move to x:" + x + " y:" + y);
		}
		
//		override public function get ClassName():String {
//			return "Fightable";
//		}
		
//		override public function get CLASS():Class {
//			return Fightable;
//		}
	}
}