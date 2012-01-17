package org.musince.data
{
	import flash.utils.IDataInput;
	
	import org.musince.logic.GameObject;

	public class StoryProgress extends GameObject
	{
		public var name:String;
		public var hasProgress:Boolean;
		public var story_idx:int;
		public var space_idx:int;
		public var chapter_idx:int;
		public var action_idx:int;
		public var offset:int;
		
		public function StoryProgress()
		{
		}
		
		override public function unserialize(buf:IDataInput):void
		{
			name = buf.readUTF();
			hasProgress = buf.readByte() > 0;
		}
	}
}