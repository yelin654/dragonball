package org.musince.editor
{
	import flash.utils.ByteArray;
	
	import org.musince.data.MetaWork;
	
	public class LoadMetaWorks extends Query
	{
		public function LoadMetaWorks()
		{
			super();
		}
		
		public function onQuery():void
		{
			send("EditorService", "loadWorkMeta", ["yelin"]);
		}
		
		protected function onResult(bytes:ByteArray):void
		{
			
		}
	}
}