package org.musince.actions
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	
	import org.musince.core.TimeSlice;
	import org.musince.display.TalkPanel;
	import org.musince.global.$root;
	
	public class WaitingForChoose extends TimeSlice
	{
		public var talk:TalkPanel; 
		
		public function WaitingForChoose(talk:TalkPanel)
		{
			super();
			this.talk = talk;
		}
		
		override public function onStart():void
		{
			enableGlobalKeyDown(Keyboard.UP, onUp);
			enableGlobalKeyDown(Keyboard.DOWN, onDown);
			
			enableMouseWheel = onMouseWheel;
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
	}
}