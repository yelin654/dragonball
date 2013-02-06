package slices
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	
	import globals.$root;
	
	import org.musince.display.TalkPanel;
	
	public class Choosing extends TimeSlice
	{
		public var talk:TalkPanel; 
		
		public function Choosing(talk:TalkPanel)
		{
			super();
			this.talk = talk;
		}
		
		override public function onStart():void
		{
			enableGlobalKeyDown(Keyboard.UP, onUp);
			enableGlobalKeyDown(Keyboard.DOWN, onDown);
			enableGlobalKeyDown(Keyboard.ENTER, onSure);

			globalMouseWheel = onMouseWheel;
			globalMouseUp = onSure;
		}
		
		private function onUp(e:Object):void
		{
			talk.chooseUp();
		}
		
		private function onDown(e:Object):void
		{
			talk.chooseDown();
		}
		
		private function onMouseWheel(e:MouseEvent):void
		{
			if (e.delta > 0)
			{
				onUp(null);
			}
			else
			{
				onDown(null);
			}
		}
		
		private function onSure(e:Event):void
		{
			output = new Dictionary();
			output["choice"] = talk.selecting();
			isDone = true;
		}
		
		override public function onEnd():void
		{
			trace("select " + output);
		}
	}
}