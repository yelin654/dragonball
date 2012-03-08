package org.musince.query
{
	import org.musince.core.Query;
	import org.musince.global.$client;
	
	public class GetStoryList extends Query
	{
		public function GetStoryList()
		{
			super($client);
		}
		
		override public function onStart():void
		{
			send("LuaService", "getStoryList", input["u"]);			
		}
		
		override public function onSuccess(result:Array):void
		{
			isEnd = true;
			output["list"] = result[0];
		}
		
		override public function onFailed(reason:Array):void
		{
			
		}
	}
}