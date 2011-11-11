package org.musince.actions
{
	import flash.utils.ByteArray;
	
	import org.musince.data.MetaWork;
	import org.musince.editor.Query;
	
	public class SaveMetaWork extends Query
	{	
		public function SaveMetaWork()
		{
			super();
		}
		
		public function onQuery():void
		{
			var meta:MetaWork = input as MetaWork;
			var bytes:ByteArray = new ByteArray();
			meta.serialize(bytes);
			send("EditorService", "saveMetaWork", ["yelin", bytes]);
		}
		
		public function onResult(success:Boolean):void
		{
			$log.debug("save meta work success");
			isEnd = true;
		}
	}
}