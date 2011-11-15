package org.musince.editor
{
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaWork;
	
	public class EditorLogin extends Query
	{
		public function EditorLogin()
		{
			super();
		}
		
		public function onQuery():void
		{
			send("EditorService", "login", ["yelin"]);
		}
		
		public function onSuccess():void
		{
			$log.debug("login success");
			isEnd = true;	
		}
		
		public function onFailed(reason:int):void
		{
			
		}
	}
}