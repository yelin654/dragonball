package org.musince.editor
{
	import org.musince.core.TimeSlice;
	
	public class Query extends TimeSlice
	{
		private static var _acc:int = 0; 
		
		public var rtid:int = _acc++; 
		
		public function Query()
		{
			super();
		}
		
		override public function onStart():void
		{
			if (this["onQuery"] != null)
			{
				this["onQuery"]();
			}
		}
		
		protected function send(service:String, method:String, params:Array):void
		{
			$eclient.sendQuery(this, service, method, params);
		}
		
		public function receive(params:Array):void
		{
			if (this["onResult"] != null)
			{
				(this["onResult"] as Function).apply(this, params);
			}
			isEnd = true;
		}
	}
}