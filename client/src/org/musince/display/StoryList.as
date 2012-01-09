package org.musince.display
{
	public class StoryList extends UC
	{
		public var w:int;
		public var h:int;
		
		public var cw:int;
		public var ch:int;
		
		public var colnum:int = 2;
		public var items:Vector.<Vector.<StoryListItem>>;
		public var selecting:int;
		
		public function StoryList(w:int=1280, h:int=720)
		{
			super();
			this.w = w;
			this.h = h;
			this.cw = w / 2;
			this.ch = h / 10;
		}
		
		public function update(datas:Array):void
		{
			items = new Vector.<Vector.<StoryListItem>>(colnum);
			var i:int = 0;
			var rownum:int = Math.ceil(datas.length/colnum);
			for (i = 0; i < colnum; i++)
			{
				items[i] = new Vector.<StoryListItem>();
			}
			var x:int;
			var y:int;
			var item:StoryListItem;
			for (i = 0; i < datas.length; i++)
			{
				x = i % colnum;
				y = int(i / colnum);
				item = new StoryListItem(cw, ch, datas[i]);
				item.x = x * cw;
				item.y = y * ch;
				addChild(item);
				items[x][y] = item;
			}
			focus(0);
		}
		
		public function focus(i:int):void
		{
//			items[selecting].unmark();
//			items[i].mark();
//			selecting = i;
		}
		
		public function focusUp():void
		{
			var next:int = selecting - 2;
			if (next < 0) return;
			selecting = next;
			focus(Math.max(selecting-1, 0));
		}
		
		public function focusDown():void
		{
			focus(Math.min(selecting+1, items.length-1));
		}
		
		public function focusLeft():void
		{
			focus(Math.max(selecting-1, 0));
		}
		
		public function focusRight():void
		{
			focus(Math.min(selecting+1, items.length-1));
		}
		
		public function enter():void
		{
//			items[selecting].enter();
		}
		
		public function get selectingItem():StoryListItem
		{
			return items[selecting][0];
		}

	}
}