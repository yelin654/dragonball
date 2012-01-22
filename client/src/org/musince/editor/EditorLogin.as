package org.musince.editor
{
	import org.musince.core.Query;
	import org.musince.global.$eclient;
	import org.musince.global.$log;
	
	public class EditorLogin extends Query
	{
		public function EditorLogin()
		{
			super($eclient);
		}
		
		public function onQuery():void
		{
			send("EditorService", "login", ["yelin"]);
		}
		
		override public function onSuccess(result:Array):void
		{
			$log.debug("login success");
			isEnd = true;	
		}
		
		override public function onFailed(reason:Array):void
		{
			
		}
	}
}