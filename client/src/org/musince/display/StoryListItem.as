package org.musince.display
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import org.musince.data.DataStory;
	import org.musince.util.TextFieldUtil;

	public class StoryListItem extends UC
	{
		public var nameText:TextField;
		public var selectMask:Sprite = new Sprite();
		public var w:int;
		public var h:int;
		
		public function StoryListItem(w:int, h:int, data:DataStory)
		{
			super();
			this.w = w;
			this.h = h;
			addChild(selectMask);
			
			var tf:TextFormat = TextFieldUtil.getTextFormat();
			tf.align = TextFormatAlign.LEFT;
			nameText.defaultTextFormat = tf;
			nameText.text = data.name;
			nameText.selectable = false;			
			addChild(nameText);
			graphics.lineStyle(1, 0x7D7D7D);
			graphics.drawRect(0, 0, w, h);
		}
		
		public function select():void
		{
			selectMask.graphics.clear();
			selectMask.graphics.beginFill(0x7D7D7D);
			selectMask.graphics.drawRect(0, 0, w, h);
			selectMask.graphics.endFill();
		}
		
		public function unselect():void
		{
			selectMask.graphics.clear();
		}
	}
}