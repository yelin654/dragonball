package org.musince.display
{
	public class StoryList extends UC
	{
		public var w:int;
		public var h:int;
		
		public var cw:int;
		public var ch:int;
		public var marglin:
		
		public function StoryList(w:int=1280, h:int=720)
		{
			super();
		}
		
		public function update(datas:Array):void
		{
			var x:int;
			var y:int;
			var item:StoryListItem;
			for (var i = 0; i < datas.length; i++)
			{
				x = i % 2 * cw;
				y = int(i / 2) * ch;
				item = new StoryListItem(cw, ch, datas[i]);
			}
		}
		
		
	}
}