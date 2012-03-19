package org.musince.net
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	public class Stream extends ByteArray implements IDataOutputNet
	{
		public function Stream()
		{
			super();
			endian = Endian.LITTLE_ENDIAN;
		}
		
		public function flush():void {
			
		}
	}
}