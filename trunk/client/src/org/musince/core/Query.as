package org.musince.core
{
	import globals.$log;
	
	import org.musince.logic.Client;
	
	import slices.TimeSlice;
	
	public class Query extends TimeSlice
	{
//		private static var _acc:int = 0; 
		
//		public var rtid:int = _acc++;
		
		public var client:Client;
		
		public function Query(client:Client)
		{
			super();
			this.client = client;
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
			client.sendQuery(this, service, method, params);
		}
		
		public function onSuccess(result:Array):void
		{
			
		}
		
		public function onFailed(result:Array):void
		{
			
		}
	}
}