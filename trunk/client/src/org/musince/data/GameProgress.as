package org.musince.data
{
	import flash.utils.IDataInput;
	
	import org.musince.display.StoryListItem;
	import org.musince.logic.GameObject;

	public class GameProgress extends GameObject
	{
		public var storys:Array; 
		
		public function GameProgress()
		{
		}
		
		override public function unserialize(buf:IDataInput):void
		{
			var num:int = buf.readShort();
			storys = new Array(num);
			var story:StoryProgress;
			for (var i:int = 0; i  < num; i++)
			{
				story = new StoryProgress();
				story.unserialize(buf);
				storys[i] = story;
			}
		}
	}
}