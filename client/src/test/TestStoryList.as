package test
{
	import flash.display.Sprite;
	
	import flashx.textLayout.edit.SelectionState;
	
	import slices.SelectStory;
	import org.musince.data.StoryProgress;
	import org.musince.display.StoryList;
	import globals.$athena;
	import globals.$root;
	
	[SWF(width='1280',height='720', backgroundColor='0x000000')]
	
	public class TestStoryList extends Sprite
	{
		public function TestStoryList()
		{
			super();
			var list:StoryList = new StoryList();
			var num:int = 10;
			var data:Array = new Array(num);
			for (var i:int = 0 ; i < num; i++)
			{
				data[i] = new StoryProgress();
				data[i].name = "name" + i;
			}
			list.update(data);
			addChild(list);
			$root = this;
			$athena.start(stage);
			
			var select:SelectStory = new SelectStory(list);
			select.input["list"] = data;
			$athena.addTimeSlice(select);
			
		}
		
		
	}
}