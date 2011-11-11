package org.musince.data
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	
	import org.musince.logic.GameObject;
	

	public class MetaWork extends GameObject
	{
		private var storys:Array = new Array; 
		
		public function MetaWork()
		{
			
		}
		
		public function addStory(s:MetaStory):void
		{
			storys.push(s);
		}
		
		override public function serialize(buf:IDataOutput):void
		{
			buf.writeInt(storys.length);
			for (var i:int = 0; i < storys.length; i++)
			{
				storys[i].serialize(buf);
			}
		}
		
		override public function unserialize(buf:IDataInput):void
		{
			var size:int = buf.readInt();
			var story:MetaStory;
			for (var i:int = 0; i < size; i++)
			{
				story = new MetaStory();
				story.unserialize(buf);
				addStory(story);
			}
		}
	}
}