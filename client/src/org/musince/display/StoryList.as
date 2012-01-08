package org.musince.display
{
	public class StoryList extends UC
	{
		public var w:int;
		public var h:int;
		
		public var cw:int;
		public var ch:int;
		
		public var items:Vector.<StoryListItem>;
		public var _selecting:int;
//		public var marglin
		
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
			var x:int;
			var y:int;
			var item:StoryListItem;
			items = new Vector.<StoryListItem>(datas.length);
			for (var i:int = 0; i < datas.length; i++)
			{
				x = i % 2 * cw;
				y = int(i / 2) * ch;
				item = new StoryListItem(cw, ch, datas[i]);
				item.x = x;
				item.y = y;
				addChild(item);
				items[i] = item;
			}
			select(0);
		}
		
		public function select(i:int):void
		{
			items[_selecting].unselect();
			items[i].select();
			_selecting = i;
		}
		
		public function selectUp():void
		{
			select(Math.max(_selecting-1, 0));
		}
		
		public function selectDown():void
		{
			select(Math.min(_selecting+1, items.length-1));
		}
		
		public function enter():void
		{
			items[_selecting].enter();
		}

	}
}