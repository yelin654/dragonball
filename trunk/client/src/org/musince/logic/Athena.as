package org.musince.logic
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	import org.musince.core.TimeSlice;

	public class Athena extends GameObject
	{
		private var _timer:Sprite = new Sprite();
		
		private var _actions:Dictionary = new Dictionary();
		private var _add:Dictionary = new Dictionary();
		private var _delete:Dictionary = new Dictionary();
		
		public function Athena()
		{
			super();
			
		}
		
		public function start():void
		{
			_timer.addEventListener(Event.ENTER_FRAME, onTimer);
			$root.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
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
			for each (action in _actions)
			{
				if (action.updateEnable)
				{
					action.onUpdate();
				}
				if (action.isEnd)
				{
					action.onEnd();
					_delete[action] = action;
					for each (var next:TimeSlice in action.getNexts())
					{
						_add[next] = next;
						next.input = action.output;
						next.onStart();
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
			action.onStart();
		}
		
		public function removeAction(action:TimeSlice):void
		{
			action.onEnd();
			_delete[action] = action;
		}
		
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			var callback:Function;
			for each (var slice:TimeSlice in _actions)
			{
				callback = slice.keyDownEnable[e.keyCode];
				if (callback != null)
				{
					callback();
				}
			}
		}
	}
}