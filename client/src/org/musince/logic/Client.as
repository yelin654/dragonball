package org.musince.logic
{
	import flash.utils.Dictionary;
	
	import org.musince.core.Query;
	import org.musince.global.$syner;

	public class Client extends GameObject
	{
		private var _pendingQuerys:Dictionary = new Dictionary(); 
		
		public function Client()
		{
			super();
		}
		
		public function sendQuery(query:Query, service:String, method:String, params:Array):void
		{
			params.unshift(query.rtid);
			_pendingQuerys[query.rtid] = query;
			$syner.roc([service], method, params);
		}
		
		public function querySuccess(idx:int, ...result):void
		{
			_pendingQuerys[idx].onSuccess(result);
			delete _pendingQuerys[idx];
		}
		
		public function queryFailed(idx:int, reason:int):void
		{
			_pendingQuerys[idx].onFailed(reason);
			delete _pendingQuerys[idx];
		}
	}
}