package org.musince.data
{
	import com.adobe.utils.DictionaryUtil;
	
	import flash.utils.Dictionary;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.musince.logic.GameObject;
	import org.musince.util.DictionaryUtilPlus;
	
	public class MetaResource extends GameObject
	{
		public var img_url:Dictionary = new Dictionary();
		
		public var sound_url:Dictionary = new Dictionary();
		
		public function MetaResource()
		{
			super();
		}
		
		override public function serialize(buf:IDataOutput):void
		{
			buf.writeInt(DictionaryUtilPlus.size(img_url));
			for (var id:Object in img_url)
			{
				buf.writeInt(int(id));
				buf.writeUTF(img_url[id]);
			}
			
			buf.writeInt(DictionaryUtilPlus.size(sound_url));
			for (id in sound_url)
			{
				buf.writeInt(int(id));
				buf.writeUTF(sound_url[id]);
			}
		}
		
		override public function unserialize(buf:IDataInput):void
		{
			var size:int = buf.readInt();
			var i:int;
			var id:int; var url:String;
			for (i = 0; i < size; i++)
			{
				id = buf.readInt();
				url = buf.readUTF();
				img_url[id] = url;
			}
			
			for (i = 0 ; i < size; i++)
			{
				id = buf.readInt();
				url = buf.readUTF();
				sound_url[id] = url;
			}
		}
	}
}