package org.musince.editor
{
	import flash.utils.ByteArray;
	
	import org.musince.core.Query;
	import org.musince.data.MetaWork;
	import globals.$eclient;
	import globals.$log;
	
	public class SaveMetaWork extends Query
	{	
		public function SaveMetaWork()
		{
			super($eclient);
		}
		
		public function onQuery():void
		{
			var meta:MetaWork = input as MetaWork;
			var bytes:ByteArray = new ByteArray();
			meta.serialize(bytes);
			$log.debug("save metawork, length:", bytes.length); 
			send("EditorService", "saveMetaWork", ["yelin", bytes]);
		}
		
		override public function onSuccess(result:Array):void
		{
			$log.debug("save meta work success");
			isDone = true;
		}
	}
}