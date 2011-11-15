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
			send("EditorService", "loadMetaWork", ["yelin"]);
		}
		
		public function onSuccess(bytes:ByteArray):void
		{
			$log.debug("load metawork length:", bytes.length);
			isEnd = true;
		}
	}
}