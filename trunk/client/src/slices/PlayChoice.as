package slices
{
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import slices.TimeSlice;
	import org.musince.display.TalkPanel;
	import globals.$athena;
	import globals.$sender;
	import globals.$talkPanel;
	import org.musince.util.LuaUtil;
	
	public class PlayChoice extends TimeSlice
	{
		private var _panel:TalkPanel; 
		
		private var _speed:Number = 0.1;
		
		public var result:int;
		
		public function PlayChoice(panel:TalkPanel)
		{
			super();
			_panel = panel;
		}
		
		override public function onStart():void
		{			
			result = input.result;
			var texts:Array = LuaUtil.convertToArray(input.alters);
			_panel.createChoice(texts);
			_panel.select(0);
			
			$talkPanel.alpha = 0;
			var fade:FadeInDisplayObject = new FadeInDisplayObject($talkPanel, 0.1);
			fade.endHook = addEvent;
			$athena.addTimeSlice(fade);
		}
		
		public function addEvent(arg:Object):void
		{
			var tfs:Vector.<TextField> = _panel.choices;
			var tf:TextField;
			for (var i:int = 0; i < tfs.length; i++)
			{
				tf = tfs[i];
				tf.name = i.toString();
				tf.addEventListener(MouseEvent.MOUSE_OVER, onOverItem);
				tf.addEventListener(MouseEvent.MOUSE_OUT, onOutItem);
				tf.addEventListener(MouseEvent.CLICK, onClickItem);
			}
		}
		
		public function removeEvent():void
		{
			var tfs:Vector.<TextField> = _panel.choices;
			var tf:TextField;
			for (var i:int = 0; i < tfs.length; i++)
			{
				tf = tfs[i];
				tf.removeEventListener(MouseEvent.MOUSE_OVER, onOverItem);
				tf.removeEventListener(MouseEvent.MOUSE_OUT, onOutItem);
				tf.removeEventListener(MouseEvent.CLICK, onClickItem);
			}
		}
		
		private function onOverItem(e:MouseEvent):void
		{
			var tf:TextField = e.currentTarget as TextField;
			_panel.select(int(tf.name));
		}
		
		private function onOutItem(e:MouseEvent):void
		{
			var tf:TextField = e.currentTarget as TextField;
		}
		
		private function onClickItem(e:MouseEvent):void
		{
			var tf:TextField = e.currentTarget as TextField;
			var choose:int = int(tf.name) + 1;
			trace("click", choose);
			$sender.lua_rpc("on_choose", [int(tf.name)+1]);
//			if (choose == result || result == 0)
//			{
			$talkPanel.clearChoice();
			removeEvent();
			isDone = true;
//			}
		}
	}
}