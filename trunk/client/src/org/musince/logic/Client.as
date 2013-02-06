package org.musince.logic
{
	import flash.utils.Dictionary;
	
	import org.musince.core.Query;
	import globals.$sender;

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
			$sender.rpc(method, params);  
//			$sender.roc([service], method, params);
		}
		
		public function querySuccess(idx:int, result:Array):void
		{
			_pendingQuerys[idx].onSuccess(result);
			delete _pendingQuerys[idx];
		}
		
		public function queryFailed(idx:int, result:Array):void
		{
			_pendingQuerys[idx].onFailed(result);
			delete _pendingQuerys[idx];
		}
	}
}