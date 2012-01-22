package org.musince.actions
{
	import org.musince.core.Query;
	import org.musince.data.GameProgress;
	import org.musince.global.$client;
	import org.musince.logic.Client;
	
	public class GetGameProgress extends Query
	{
		public function GetGameProgress()
		{
			super($client);
		}
		
		override public function onStart():void
		{
			send("LoginService", "getGameProgress", []);			
		}
		
		override public function onSuccess(result:Array):void
		{
			isEnd = true;
			var progress:GameProgress = result[0];
		}
		
		override public function onFailed(reason:Array):void
		{
			
		}
	}
}