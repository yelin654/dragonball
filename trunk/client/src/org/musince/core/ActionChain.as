package org.musince.core
{
	public class ActionChain implements ITimeSlice
	{
		private var _start:ITimeSlice; 
		
		public function ActionChain()
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
		}
		
		public function isEnd():Boolean
		{
			return false;
		}
	}
}