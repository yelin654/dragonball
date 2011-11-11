package org.musince.actions
{
	import org.musince.core.TimeSlice;
	import org.musince.data.MetaStory;
	import org.musince.data.MetaWork;
	
	public class GenTestMetaWork extends TimeSlice
	{
		public function GenTestMetaWork()
		{
			super();
		}
		
		override public function onStart():void
		{
			var meta:MetaWork = new MetaWork();
			var story:MetaStory = new MetaStory();
			story.idx = 1;
			story.name = "cowboy bebop";
			meta.addStory(story);
			story = new MetaStory();
			story.idx = 2;
			story.name = "七龙珠";
			meta.addStory(story);
			output = meta;
			isEnd = true;
		}
	}
}