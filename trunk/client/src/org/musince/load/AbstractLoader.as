package org.musince.load
{
	import flash.errors.IOError;
	import flash.errors.IllegalOperationError;
	import flash.events.IOErrorEvent;

	public class AbstractLoader implements ILoader
	{
		protected var pc:Function;
		protected var cc:Function;
		protected var ec:Function;
		protected var error:IOErrorEvent;
		protected var item:LoadItem;
		
		public function AbstractLoader()
		{
		}
		
		public function load(item:LoadItem, completeCallback:Function, progressCallback:Function=null, errorCallback:Function=null):void
		{
			pc = progressCallback;
			cc = completeCallback;
			ec = errorCallback;
			item.loader = this;
			this.item = item;
			_load(item);
		}
		
		protected function _load(item:LoadItem):void
		{
			
		}
		
		public function stop():void
		{
		}
		
		public function getContent():Object
		{
			return null;
		}
		
		public function getBytesLoaded():int
		{
			return 0;
		}
		
		public function getBytesTotal():int
		{
			return 0;
		}
		
		public function getError():IOErrorEvent
		{
			return error;
		}
		
		public function getItem():LoadItem
		{
			return item;
		}
	}
}