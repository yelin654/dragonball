package org.musince.logic
{
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import org.musince.net.ISynchronizer;
	import org.musince.net.Stream;
	import logs.Log;
	import globals.$log;

	public class GameObject extends EventDispatcher implements ISerializable
	{
		public var passAsReference:Boolean;
		
		private var _key:Stream;
		
		protected var _invokeFrom:ISynchronizer;
		
		public function GameObject() {
			
		}
		
		public function getKey():Stream {
			return _key;
		}
		
		public function setKey(v:ParamList):void {
			_key = new Stream;
			v.serialize(_key);
		}
		
		public function invokeMethodFrom(syner:ISynchronizer, name:String, params:Array):void {
			_invokeFrom = syner;
			invokeMethod(name, params);
		}
		
		public function invokeMethod(name:String, params:Array):void {
			var func:Function = this[name] as Function;
			if (null != func)
				func.apply(this, params);
			else
				$log.error("no method", getQualifiedClassName(this), "::", name);
		}
		
		public function serialize(buf:IDataOutput):void {
//			throw "override"
		}
		
		public function unserialize(buf:IDataInput):void {
//			throw "override"
		}
		
		public static function getClassName(v:Object):String
		{
			var fullname:String = getQualifiedClassName(v);
			return fullname.substr(fullname.lastIndexOf("::")+1);
		}
		
		public static function getInstance(name:String):GameObject
		{
			var fullClassName:String = "org.musince.logic."+name;
			var cls:Class = getDefinitionByName(fullClassName) as Class;
			return new cls;
		}
	}
	

}