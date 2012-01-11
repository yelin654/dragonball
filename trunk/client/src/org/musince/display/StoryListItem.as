package org.musince.display
{
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.musince.data.DataStory;
	import org.musince.util.TextFieldUtil;

	public class StoryListItem extends UC
	{
		public var nameText:TextField;
		public var selectMask:Sprite = new Sprite();
		public var startText:TextField;
		public var continueText:TextField;
		public var cancelText:TextField;
		public var w:int;
		public var h:int;
		
		public var selecting:int;
		public var options:Vector.<TextField>;
		public var data:DataStory;
		public var next:StoryListItem;
		public var pre:StoryListItem;
		
		public var col:int;
		public var row:int;
		
		public static var selectFilters:Array = [new GlowFilter(0x7D7D7D)]; 
		
		public function StoryListItem(w:int, h:int, data:DataStory)
		{
			super();
			this.w = w;
			this.h = h;
			this.data = data;
			addChild(selectMask);
			
			nameText = TextFieldUtil.getTextField();
			nameText.text = data.name;
			addChild(nameText);
			graphics.lineStyle(1, 0x7D7D7D);
			graphics.drawRect(0, 0, w, h);
		}
		
		public function mark():void
		{
			selectMask.graphics.clear();
			selectMask.graphics.beginFill(0x7D7D7D);
			selectMask.graphics.drawRect(0, 0, w, h);
			selectMask.graphics.endFill();
		}
		
		public function unmark():void
		{
			selectMask.graphics.clear();
		}
		
		public function enter():void
		{
			removeChild(nameText);
			unmark();
			
			if (startText == null)
			{
				options = new Vector.<TextField>();
				startText = TextFieldUtil.getTextField();
				startText.text = "start";
				options.push(startText);
				
				cancelText = TextFieldUtil.getTextField();
				cancelText.text = "cancel";
				cancelText.x = w / 3;
				options.push(cancelText);

				if (data.hasProgress)
				{
					continueText = TextFieldUtil.getTextField();
					continueText.text = "continue";
					continueText.x = w * 2 / 3;
					options.push(continueText);
				}
			}
			
			for each (var tf:TextField in options)
			{
				addChild(tf);
			}
		}
		
		public function select(i:int):void
		{
			options[selecting].filters = null;
			options[i].filters = selectFilters;
			selecting = i;
		}
		
		public function selectUp():void
		{
			select(Math.max(selecting-1, 0));
		}
		
		public function selectDown():void
		{
			select(Math.min(selecting+1, options.length-1));
		}
	}
}