package org.musince.logic
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import org.musince.core.TimeSlice;

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
			_now = getTimer();
		}
		
		private function onTimer(e:Event):void
		{
			for each (action in _add)
			{
				_actions[action] = action;
			}
			
			for each (action in _delete)
			{
				delete _actions[action];
			}

			_delete = new Dictionary();
			_add = new Dictionary();
			var action:TimeSlice;
			_now = getTimer();
			for each (action in _actions)
			{
				if (action.updateEnable)
				{
					action.update(_now);
				}
				if (action.isEnd)
				{
					action.onEnd();
					_delete[action] = action;
					for each (var next:TimeSlice in action.getNexts())
					{
						_add[next] = next;
						next.input = action.output;
						next.start(_now);
					}
				}
			}
			
			for each (action in _add)
			{
				_actions[action] = action;
			}
			
			for each (action in _delete)
			{
				delete _actions[action];
			}
		}
		
		public function addTimeSlice(action:TimeSlice):void
		{
			_add[action] = action;
			action.start(_now);
		}
		
		public function removeAction(action:TimeSlice):void
		{
			action.onEnd();
			_delete[action] = action;
		}
		
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			var arr:Array;
			for each (var slice:TimeSlice in _actions)
			{
				arr = slice.keyDownEnable[e.keyCode];
				if (arr != null && arr[0] == e.target)
				{
					arr[1](e);
				}
			}
		}
	}
}