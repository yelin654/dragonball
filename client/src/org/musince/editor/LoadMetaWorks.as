package org.musince.editor
{
	import flash.utils.ByteArray;
	
	import org.musince.core.Query;
	import org.musince.data.MetaWork;
	import org.musince.global.$eclient;
	import org.musince.global.$log;
	
	public class LoadMetaWorks extends Query
	{
		public function LoadMetaWorks()
		{
			super($eclient);
		}
		
		public function onQuery():void
		{
			send("EditorService", "loadMetaWork", ["yelin"]);
		}
		
		override public function onSuccess(result:Array):void
		{
			var bytes:ByteArray = result[0];
			$log.debug("load metawork length:", bytes.length);
			isEnd = true;
		}
	}
}