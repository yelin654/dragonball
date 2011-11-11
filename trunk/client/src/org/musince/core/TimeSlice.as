package org.musince.core
{
	import flash.utils.Dictionary;
	
	import org.musince.logic.GameObject;

	public class TimeSlice extends GameObject implements ITimeSlice
	{
		private var _nexts:Dictionary = new Dictionary();
		
		public var isEnd:Boolean;
		
		public var updateEnable:Boolean = true;
		
		public var keyDownEnable:Dictionary = new Dictionary();
		public var keyUpEnable:Dictionary = new Dictionary();		
		
		public var mouseClickEnable:Boolean = true;
		public var mouseUpEnable:Boolean = true;
		public var mouseDownEnable:Boolean = true;
		
		public var input:Object;
		public var output:Object;
		
		public function TimeSlice()
		{
		}
		
		public function onStart():void
		{
		}
		
		public function onEnd():void
		{
		}
		
		public function onUpdate():void
		{
			updateEnable = false;
		}
		
		public function appendNext(ts:ITimeSlice):void
		{
			_nexts[ts] = ts; 
		}
		
		public function removeNext(ts:ITimeSlice):void
		{
			delete _nexts[ts];
		}
		
		public function getNexts():Dictionary
		{
			return _nexts;
		}
		
		public function enableKeyDown(code:int, callback:Function):void
		{
			keyDownEnable[code] = callback;
		}
		
		public function enableKeyUp(code:int, callback:Function):void
		{
			keyDownEnable[code] = callback;
		}
		
//		public function onKeyDown(code:int):void
//		{
//			
//		}
//		
//		public function onKeyUp(code:int):void
//		{
//			
//		}
		
		public function onMouseDown(code:int):void
		{
			
		}
		
		public function onMouseUp(code:int):void
		{
			
		}
		
		
	}
}