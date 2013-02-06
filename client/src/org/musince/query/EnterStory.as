package org.musince.query
{
	import org.musince.core.Query;
	import slices.TimeSlice;
	import org.musince.display.StoryList;
	import globals.$athena;
	import globals.$client;
	import globals.$log;
	import globals.$loginName;
	
	public class EnterStory extends Query
	{
		public var ui:StoryList;
	
		public function EnterStory()
		{
			super($client);
		}
		
		override public function onStart():void
		{
			send("GameServer", "enter_story", ["yelin", 1]);			
//			var getList:GetStoryList = new GetStoryList();
//			getList.input["u"] = $loginName;
//			ui = new StoryList();
//			var select:SelectStory = new SelectStory(ui);
//			getList.appendNext(select);
//			$athena.addTimeSlice(getList);
		}
		
		override public function onSuccess(result:Array):void
		{
			$log.debug("get success");
			output["chapter"] = 0;
			isDone = true;
		}
	}
}