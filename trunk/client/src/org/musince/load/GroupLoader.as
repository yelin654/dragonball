package org.musince.load
{	
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import org.musince.global.$loadManager;
	import org.musince.global.$log;

	public class GroupLoader
	{
		private var priority:int;
		
		public var items:Dictionary = new Dictionary();
		
		public var count:int = 0;
		
		private var total:int;
		
		private var onProgress:Function;
		
		private var onComplete:Function;
		
		private var onError:Function;
		
		public var errorInfo:String;
		
		public function GroupLoader(priority:int=0)
		{
			this.priority = priority;
		}
		
		public function add(url:String, type:int=0, param:Object=null, context:LoaderContext=null):void{
			if(items[url] != null) return;
			items[url] = new LoadItem(url, onOneComplete, onOneProgress, onOneError, type, priority, context, param);
			count++;
		}
		
		public function onOneComplete(item:LoadItem):void{
			count--;
			if(count == 0){
				$log.debug("[GROUP_Load_COMPLETE]");
				onComplete(this);		
			}
		}
		
		public function onOneProgress(item:LoadItem):void{
			var t:Number = 0;
			for each(var item:LoadItem in items){
				if (item.loader.getBytesTotal() == 0){
					continue;
				}
				t += Number(item.loader.getBytesLoaded())/item.loader.getBytesTotal();
			}
			if (onProgress != null) {
				onProgress(t/total);
			}
		}
		
		public function onOneError(item:LoadItem):void{
			count--;
			errorInfo = item.error;
			if (onError != null) {
				onError(this);
			}
			if(count == 0){
				$log.debug("[GROUP_LOAD_COMPLETE]");
				onComplete(this);		
			}
		}
		
		public function start(onComplete:Function, onProgress:Function = null, onError:Function = null):void{
			if(count == 0){
				$log.error("[GROUP_LOAD] no item");
				return;
			}
			this.onComplete = onComplete;
			this.onProgress = onProgress;
			this.onError = onError;
			total = count;
			for each(var item:LoadItem in items){
				$loadManager.addLoadItem(item);
			}
		}
	}
}