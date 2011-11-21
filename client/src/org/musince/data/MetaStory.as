package org.musince.data
{
	import flash.utils.Dictionary;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.musince.logic.GameObject;
	
	public class MetaStory extends GameObject
	{
		public var idx:int;
		public var name:String;
		public var talks:Dictionary = new Dictionary();
		
		public function MetaStory()
		{
			super();
		}
		
		override public function serialize(buf:IDataOutput):void
		{
			buf.writeInt(idx);
			buf.writeUTF(name);
		}
		
		override public function unserialize(buf:IDataInput):void
		{
			idx = buf.readInt();
			name = buf.readUTF();
		}
	}
}