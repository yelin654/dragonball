package org.musince.actions
{
	import org.musince.editor.Query;
	import org.musince.data.MetaWork;
	
	public class GetMetaWorks extends Query
	{
		public function GetMetaWorks()
		{
			super();
		}
		
		public function onQuery():void
		{
			send("EditorService", "getWorkMeta", ["yelin"]);
		}
		
		protected function onResult():void
		{
			
		}
	}
}