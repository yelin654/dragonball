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
		
		public function receiveSuccess(params:Array):void
		{
			if (this["onSuccess"] != null)
			{
				(this["onSuccess"] as Function).apply(this, params);
			}
//			isEnd = true;
		}
		
		public function receiveFailed(reason:int):void
		{
			if (this["onFailed"] != null)
			{
				(this["onFailed"] as Function).call(this, reason);
			}
//			isEnd = true;
		}
	}
}