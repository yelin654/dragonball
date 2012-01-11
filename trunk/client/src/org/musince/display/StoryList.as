package org.musince.display
{
	import org.musince.data.DataStory;

	public class StoryList extends UC
	{
		public var w:int;
		public var h:int;
		
		public var cw:int;
		public var ch:int;
		
		public var colnum:int = 2;
		public var items:Vector.<Vector.<StoryListItem>>;
		public var focusCol:int;
		public var focusRow:int;
		
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
			var t:int = datas.length % colnum;
			for (i = 0; i < t; i++)
			{
				items[i] = new Vector.<StoryListItem>(rownum);
			}
			for (i = t; i < colnum; i++)
			{
				items[i] = new Vector.<StoryListItem>(rownum-1);
			}
			var x:int;
			var y:int;
			var data:DataStory = new DataStory();
			data.name = "";
			var itemPre:StoryListItem = new StoryListItem(0, 0, data);
			var item:StoryListItem = null;
			for (i = 0; i < datas.length; i++)
			{
				x = i % colnum;
				y = int(i / colnum);
				item = new StoryListItem(cw, ch, datas[i]);
				item.pre = itemPre;
				itemPre.next = item;
				item.row = x;
				item.col = y;
				item.x = x * cw;
				item.y = y * ch;
				addChild(item);
				items[x][y] = item;
				itemPre = item;
			}
			items[0][0].pre = null;
			focus(0, 0);
		}
		
		public function focus(row:int, col:int):void
		{
			items[focusCol][focusRow].unmark();
			items[row][col].mark();
			focusCol = row;
			focusRow = col;
		}
		
		public function focusNext():void
		{
			var item:StoryListItem = items[focusCol][focusRow];
			if (item.next != null)
			{
				item = item.next;
				focus(item.row, item.col);
			}
		}
		
		public function focusPre():void
		{
			var item:StoryListItem = items[focusCol][focusRow];
			if (item.pre != null)
			{
				item = item.pre;
				focus(item.row, item.col);
			}
		}
		
		public function focusUp():void
		{
			focus(focusCol, Math.max(0, focusRow-1));
		}
		
		public function focusDown():void
		{
			var nextCol:int = focusRow - 1;
			if (items[focusCol].length <= nextCol) return;
			focus(focusCol, nextCol);
		}
		
		public function focusLeft():void
		{
			focus(Math.max(0, focusCol-1), focusRow);
		}
		
		public function focusRight():void
		{
			var nextRow:int = focusCol + 1;
			if (nextRow >= colnum) return;
			if (items[nextRow].length <= focusRow) return;
			focus(nextRow, focusRow);
		}
		
		public function enter():void
		{
			items[focusCol][focusRow].enter();
		}
		
		public function get selectingItem():StoryListItem
		{
			return items[focusCol][focusRow];
		}

	}
}