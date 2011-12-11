package org.musince.load
{
	import flash.events.IOErrorEvent;

	public interface ILoader
	{
		function load(item:LoadItem, completeCallback:Function, progressCallBack:Function=null, errorCallback:Function=null):void;
		function stop():void;
		function getContent():Object;
		function getBytesLoaded():int;
		function getBytesTotal():int;
		function getError():IOErrorEvent;
		function getItem():LoadItem;
//		function getProgress():Array;
	}
}