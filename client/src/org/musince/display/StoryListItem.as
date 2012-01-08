package org.musince.display
{
	import flash.display.Sprite;
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
		
//		public var selecting
		public var options:Vector.<TextField>;
		
		
		public function StoryListItem(w:int, h:int, data:DataStory)
		{
			super();
			this.w = w;
			this.h = h;
			addChild(selectMask);
			
			var tf:TextFormat = TextFieldUtil.getTextFormat();
			tf.align = TextFormatAlign.LEFT;
			nameText = new TextField();
			nameText.defaultTextFormat = tf;
			nameText.selectable = false;			
//			nameText.text = data.name;
			nameText.text = "abcefg";
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
		
		public function enter():void
		{
			removeChild(nameText);
			
			if (startText == null)
			{
				startText = TextFieldUtil.getTextField();
				startText.text = "start";
				
				cancelText = TextFieldUtil.getTextField();
				cancelText.text = "cancel";
				cancelText.x = w * 2 / 3 ;

				continueText = TextFieldUtil.getTextField();
				continueText.text = "continue";
				continueText.x = w / 3 ;
			}
			
			addChild(startText);
			addChild(continueText);
			addChild(cancelText);
		}
		
		public function selectUp():void
		{
			
		}
		
		public function selectDown():void
		{
			
		}
	}
}