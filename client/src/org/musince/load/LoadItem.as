package org.musince.load
{
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	

	public class LoadItem
	{
		public var url:String;
		public var onComplete:Function;
		public var onProgress:Function;
		public var onError:Function;
		
		public var type:int;
		public var priority:int;		
		public var bytesLoaded:int;
		public var bytesTotal:int;
		public var content:Object;
		public var param:Object;
		public var error:String;
		public var context:LoaderContext;
		public var loader:ILoader;
		
		public function LoadItem(url:String, onComplete:Function, onProgress:Function, onError:Function, type:int=0, priority:int=0, context:LoaderContext=null, param:Object=null){
			this.url = url;
			this.onComplete = onComplete;
			this.onProgress = onProgress;
			this.onError = onError;
			this.type = type;
			this.priority = priority;
			this.context = context;
			this.param = param;
		}
	}
}