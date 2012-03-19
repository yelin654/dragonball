package org.musince.core
{
	import flash.events.MouseEvent;
	
	import org.musince.global.$sender;

	public class UIAction extends TimeSlice
	{
		public var tid:int;
		
		public var isMain:Boolean;
		
		public function UIAction()
		{
			super();
		}
		
		public function waitForClick():void
		{
				globalMouseClick = onClickNext; 
		}
		
		public function onClickNext(e:MouseEvent):void
		{
			
		}
		
		override public function onEnd():void
		{
			$sender.lua_rpc("on_action_end");
		}
		
		
	}
}