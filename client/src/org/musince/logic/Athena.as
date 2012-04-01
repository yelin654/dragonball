package org.musince.logic
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$log;

	public class Athena extends GameObject
	{
		private var _timer:Sprite = new Sprite();
		
		private var _actions:Dictionary = new Dictionary();
		private var _add:Dictionary = new Dictionary();
		private var _delete:Dictionary = new Dictionary();
		private var _now:int;
		
		public function Athena()
		{
			super();

		}
		
		public function start(stage:Stage):void
		{
			_timer.addEventListener(Event.ENTER_FRAME, onTimer);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			stage.frameRate = 60;
			_now = getTimer();
		}
		
		private function onTimer(e:Event):void
		{
			var action:TimeSlice;
			_now = getTimer();
			
			for each (action in _delete)
			{
				delete _actions[action];
			}
			_delete = new Dictionary();
			
			for each (action in _add)
			{
				_actions[action] = action;
			}
			_add = new Dictionary();
			
			for each (action in _actions)
			{
				if (action.updateEnable)
				{
					action.update(_now);
				}
				if (action.isEnd)
				{
					if (action.traceT)
						$log.debug("[END_ACTION]", action.toString()+action.rtid);
					action.end();
					_delete[action] = action;
					for each (var next:TimeSlice in action.getNexts())
					{
						_add[next] = next;
						for (var key:Object in action.output)
						{
							next.input[key] = action.output[key];
						}
						if (next.traceT)
							$log.debug("[START_ACTION]", next.toString()+action.rtid);
						next.start(_now);
					}
				}
			}
			
			for each (action in _delete)
			{
				delete _actions[action];
			}
			_delete = new Dictionary();
			
			for each (action in _add)
			{
				_actions[action] = action;
			}
			_add = new Dictionary();
		}
		
		public function addTimeSlice(action:TimeSlice):void
		{
			_add[action] = action;
			if (action.traceT)
				$log.debug("[START_ACTION]", action.toString()+action.rtid);
			action.start(_now);
		}
		
		public function removeTimeSlice(action:TimeSlice):void
		{
			delete _actions[action];
			delete _add[action];
			if (action.traceT)
				$log.debug("[DELETE_ACTION]", action.toString()+action.rtid);
		}
		
//		public function removeD(action:TimeSlice):void
//		{
			
//		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			var fun:Function;
			for each (var slice:TimeSlice in _actions)
			{
				fun = slice.globalKeyDownEnable[e.keyCode];
				if (fun != null) 
				{
					fun(e);
				}
			}
		}
		
		private function onMouseWheel(e:MouseEvent):void
		{
			for each (var slice:TimeSlice in _actions)
			{
				if (slice.globalMouseWheel != null) 
				{
					slice.globalMouseWheel(e);
				}
			}
		}
		
		private function onMouseDown(e:MouseEvent):void
		{
			for each (var slice:TimeSlice in _actions)
			{
				if (slice.globalMouseDown != null) 
				{
					slice.globalMouseDown(e);
				}
			}
		}
		
		private function onMouseUp(e:MouseEvent):void
		{
			for each (var slice:TimeSlice in _actions)
			{
				if (slice.globalMouseUp != null) 
				{
					slice.globalMouseUp(e);
				}
			}
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			for each (var slice:TimeSlice in _actions)
			{
				if (slice.globalMouseClick != null) 
				{
					slice.globalMouseClick(e);
				}
			}
		}
		
		public function getActiveSlice():Dictionary
		{
			return _actions;
		}
	}
}