package org.musince.core
{
	public interface ITimeSlice
	{
		function onStart():void;
		function onEnd():void;
		function onUpdate(now:int):void;
		function appendNext(next:ITimeSlice):void;
		function removeNext(next:ITimeSlice):void;
	}
}