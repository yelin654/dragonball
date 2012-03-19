package org.musince.core
{
	import flash.display.InteractiveObject;
	import flash.display3D.IndexBuffer3D;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import org.musince.logic.GameObject;

	public class TimeSlice extends GameObject
	{
		private var _nexts:Dictionary = new Dictionary();
		
		public var isEnd:Boolean;
		
		public var updateEnable:Boolean = true;
		
		public var globalKeyDownEnable:Dictionary = new Dictionary();
		public var globalkeyUpEnable:Dictionary = new Dictionary();		
		
		public var globalMouseClick:Function;
		public var globalMouseUp:Function;
		public var globalMouseDown:Function;
		public var globalMouseWheel:Function;
		
		public var input:Dictionary = new Dictionary();
		public var output:Dictionary = new Dictionary();
		
		public var interval:int = 1;
		private var _cd:int; 
		private var _nextUpdateTime:int;
		protected var _now:int;
		protected var _then:int;
		
		public var traceT:Boolean = true;
		
		public var _endHook:Array = new Array();
		
		public function TimeSlice()
		{
		}
		
		public function start(now:int):void
		{
			_then = _now = now;
			_cd = interval; 
			isEnd = false;
			onStart();
		}
		
		public function end():void
		{
			onEnd();
			for each (var f:Function in _endHook)
			{
				f.call(this, this);
			}
//			if (endHook != null)
//			{
//				endHook(this);
//			}
		}
		
		public function onStart():void
		{
		}
		
		public function onEnd():void
		{
		}		
		
		public function update(now:int):void
		{
			if (_cd < interval) 
			{
				_cd++;
				return;
			}
			_cd = 1;
			if (_nextUpdateTime <= now)
			{
				_now = now;
				onUpdate();
				_then = now;
				_nextUpdateTime = now + interval;
			}
		}
		
		public function onUpdate():void
		{
			updateEnable = false;
		}
		
		public function appendNext(ts:TimeSlice):void
		{
			_nexts[ts] = ts; 
		}
		
		public function removeNext(ts:TimeSlice):void
		{
			delete _nexts[ts];
		}
		
		public function getNexts():Dictionary
		{
			return _nexts;
		}
		
		public function enableGlobalKeyDown(code:int, callback:Function):void
		{
			globalKeyDownEnable[code] = callback;
		}
		
		public function enableKeyUp(code:int, callback:Function):void
		{
			globalkeyUpEnable[code] = callback;
		}
		
		private var _keyDownCallback:Dictionary = new Dictionary();
		
		public function enableKeyDown(code:int, target:InteractiveObject, callback:Function):void
		{
			target.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			_keyDownCallback[target] = [code, callback];
		}
		
		private function _onKeyDown(e:KeyboardEvent):void
		{
			var arr:Array = _keyDownCallback[e.currentTarget];
			if (arr != null && e.keyCode == arr[0])
			{
				arr[1]();
			}
		}
		
		private function _onKeyUp(code:int):void
		{
			
		}
		
		public function set endHook(f:Function):void
		{
			_endHook.push(f);
		}

	}
}