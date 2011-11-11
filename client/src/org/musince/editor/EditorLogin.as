package org.musince.editor
{
	import org.musince.actions.GetMetaWorks;
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
		
		public function onResult(success:Boolean):void
		{
			if (success)
			{
				isEnd = true;	
			}
		}
	}
}