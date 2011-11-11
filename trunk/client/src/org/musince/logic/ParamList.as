package org.musince.logic
{
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;

	public class ParamList implements ISerializable
	{
		private var _params:Vector.<Param>;
		
		public function ParamList(params:Array=null)
		{
			super();
			if (null != params) {
				_params = new Vector.<Param>(params.length);
				for (var i:int = 0; i < params.length; i++) {
					_params[i] = new Param(params[i]);
				}
			}
		}
		
		public function serialize(buf:IDataOutput):void {
			if (_params == null) {
				buf.writeByte(0);
				return;
			}
			buf.writeByte(_params.length);
			for each (var param:Param in _params) {
				param.serialize(buf);
			} 
		}
		
		public function unserialize(buf:IDataInput):void {
			var paramNum:int = buf.readByte();
			if (0 == paramNum)
				return;
			_params = new Vector.<Param>(paramNum);
			for (var i:int = 0; i < paramNum; i++) {
				_params[i] = new Param();
				_params[i].unserialize(buf);
			}
		}
		
		public function toArray():Array {
			if (_params == null)
				return null;
			var array:Array = new Array(_params.length);
			for (var i:int = 0; i < _params.length; i++) {
				array[i] = _params[i].content;
			}
			return array;
		}
		
//		public function get ClassName():String {
//			return "ParamList";
//		}
	}
}