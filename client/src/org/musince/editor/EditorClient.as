package org.musince.editor
{
	import flash.utils.Dictionary;
	
	import org.musince.logic.GameObject;
	
	public class EditorClient extends GameObject
	{
		private var _pendingQuerys:Dictionary = new Dictionary(); 
		
		public function EditorClient()
		{
			super();
		}
		
		public function sendQuery(query:Query, service:String, method:String, params:Array):void
		{
			params.unshift(query.rtid);
			_pendingQuerys[query.rtid] = query;
			$syner.rpc([service], method, params);
		}
		
		public function queryResult(idx:int, ...result):void
		{
			_pendingQuerys[idx].receive(result);
			delete _pendingQuerys[idx];
		}
		
		
	}
}