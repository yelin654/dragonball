package org.musince.load
{
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	
	import org.musince.global.$log;

	public class LoadManager
	{
		public static const TYPE_DISPLAY_OBJECT:int = 0;
		public static const TYPE_BINARY:int = 1;
		public static const TYPE_TEXT:int = 2;
		public static const TYPE_SOUND:int = 3;
		
		public static const DEFAULT_CONNECTION:int = 2;

		public static const LOADER_CLASSES:Array = [DisplayObjectLoader, BinaryLoader, BinaryLoader, SoundLoader];
		
		public var extEnable:Boolean = false; 
		
		private var priQueues:Array = new Array();
		
		private var maxConnections:int = 5;
		
		private var connNum:int;
		
		private var priQueueNum:int = 5;
		
		private var loadingItems:Dictionary = new Dictionary();
		
		private var queueURLs:Dictionary = new Dictionary();
		
		private var pendingItems:Dictionary = new Dictionary();
		
		private var loadCount:int = 0;
		
		public function LoadManager(maxConnections:int = 2)
		{
			this.maxConnections = maxConnections;
			priQueues = new Array(priQueueNum);
			var i:int;
			for(i=0; i<priQueues.length; i++){
				priQueues[i] = new Array();
			}
		}
		
		public function setConnections(count:int):void{
			maxConnections = count;
		}
		
		public function add(url:String,
							onComplete:Function=null, 
							onProgress:Function=null, 
							onError:Function=null, 
							type:int=TYPE_DISPLAY_OBJECT, 
							priority:int=1, 
							context:LoaderContext=null,
							param:Object=null):void{
			if (url==null || url=="") 
			{
				$log.error("load null item");
				return;
			}
			
			addLoadItem(new LoadItem(url, 
				                     onComplete, 
									 onProgress, 
									 onError, 
									 type, 
									 priority,
									 context,
									 param));
		}
		
		public function addLoadItem(item:LoadItem):void{
			$log.debug("[ADD_LOAD_ITEM] "+item.url);
			
			if (queueURLs[item.url] == null) {
				queueURLs[item.url] = item.url;
				priQueues[item.priority].push(item);
				loadAnItem();
			} else {
				if (pendingItems[item.url] == null) {
					pendingItems[item.url] = new Dictionary();
				}
				pendingItems[item.url][item] = item;	
			}
		} 
		
		public function start():void{
			while(loadAnItem() != -1){
								
			}
		}
		
		public function cancel(url:String):void{
			var loader:ILoader = loadingItems[url]
			if (loader != null) {
				loader.stop();
				loadingItems[url] = null;
				delete loadingItems[url];
			}
			
			if (pendingItems[url] != null) {
				for each(var item:LoadItem in pendingItems[url]) {
					priQueues[item.priority].push(item);
					break;
				}	
			} else {
				queueURLs[url] = null;
				delete queueURLs[url];
			}
			loadAnItem();			
		}
		
		public function loadAnItem():int{
			if(connNum >= this.maxConnections) return -1; 
			var item:LoadItem;
			for(var i:int=priQueues.length-1; i>-1; i--){
				if(priQueues[i].length != 0){
					item = priQueues[i].shift();
					break;
				}
			}
			if(item == null){
				return -1;
			}
			var loader:ILoader;
			loader = new LOADER_CLASSES[item.type];
			loadingItems[item.url] = item;
			connNum++;
			loader.load(item, onComplete, onProgress, onError);
			$log.debug("[START_LOAD] "+item.url);
			return 0;
		}
		
		public function onProgress(loader:ILoader):void{
			var item:LoadItem = loader.getItem();
			if(item.onProgress != null){
//				item.bytesLoaded = loader.getBytesLoaded();
//				item.bytesTotal = loader.getBytesTotal();
				item.onProgress(item);	
			}			
		}
		
		public function onError(loader:ILoader):void{
			var e:IOErrorEvent = loader.getError();
			$log.error("[LOAD_FILE_ERROR] "+ e.text);
			var item:LoadItem = loader.getItem();
			if(item.onError!= null){
				item.error = e.text;
				item.onError(item);		
			}
			
			loadingItems[item.url] = null;
			delete loadingItems[item.url];
			connNum--;
			
			queueURLs[item.url] = null;
			delete queueURLs[item.url];
			
			loadAnItem();
		}
		
		public function onComplete(loader:ILoader):void{
			var item:LoadItem = loader.getItem();
			$log.debug("[LOAD_FILE] "+ item.url);
			if(item.onComplete != null){
				item.content = loader.getContent();
				item.onComplete(item);	
			}
			loadingItems[item.url] = null;
			delete loadingItems[item.url];
			connNum--;
			
			if(pendingItems[item.url] != null){
				var itemDic:Dictionary = pendingItems[item.url];
				for (var key:Object in itemDic){
					priQueues[priQueueNum-1].push(itemDic[key]);
					itemDic[key] = null;
					delete itemDic[key];
				}
				pendingItems[item.url] = null;
				delete pendingItems[item.url];
			}else{
				queueURLs[item.url] = null;
				delete queueURLs[item.url];	
			}
			loadCount++;
			loadAnItem();
		}
		
		public function onTimer(e:TimerEvent):void{
			loadAnItem();
		}
		
		public function stopAllAndClear():void {
			stopAll();
			clearQueue();
		}
		
		public function clearQueue():void {
			pendingItems = new Dictionary();
			queueURLs = new Dictionary();
			for (var i:int = 0; i<priQueues.length; i++) {
				priQueues[i] = new Array();
			}
		}
		
		public function stopAll():void {
			for each (var loader:ILoader in loadingItems) {
				loader.stop();
			}			
		}
		
	}
}