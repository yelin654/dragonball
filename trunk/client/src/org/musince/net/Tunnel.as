package org.musince.net
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import org.musince.global.$log;
	
	public class Tunnel extends Socket implements IDataOutputNet
	{
		public static const DATA_LENGTH_BYTES:int = 4;
		private var _expectLength:int = DATA_LENGTH_BYTES;
		private var _rpcLength:int;
		private var _buf:Stream;
		private var _receiver:IDataReceiver;
		private var _readingDataLength:Boolean = true;
		
		public function Tunnel()
		{
			super();
//			this._receiver = rpcReceiver;
			this.endian = Endian.LITTLE_ENDIAN;
//			addEventListener(Event.CONNECT, onConnect);
			addEventListener(ProgressEvent.SOCKET_DATA, onData2);
			addEventListener(Event.CLOSE, onServerClose);
			addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		public function attachReceiver(receiver:IDataReceiver):void
		{
			_receiver = receiver;
		}
		
		public function send(bytes:ByteArray):void {
			bytes.position = 0;
			this.writeInt(bytes.length);
			this.writeBytes(bytes);
		}
		
//		private function onConnect(e:Event):void {
//			_receiver.on_connect(this);
//		}
		
		private function onData3(e:Event):void {
			while (_expectLength <= this.bytesAvailable) {
				if (_readingDataLength) {
					if (_buf != null) {
						this.readBytes(_buf, _buf.length, _expectLength);
						_expectLength = _buf.readInt();
						_buf = null;
					} else {
						_expectLength = this.readInt();
					}
					_readingDataLength = false;
				} else {
					if (_buf == null) 
						_buf = new Stream;
					this.readBytes(_buf, _buf.length, _expectLength);
					_receiver.on_data(this, _buf);
					_buf = null;
					_expectLength = 4;
					_readingDataLength = true;
				}
			}
			
			if (this.bytesAvailable > 0) {
				if (_buf == null) {
					_buf = new Stream;
				}
				_expectLength -= this.bytesAvailable;
				this.readBytes(_buf, _buf.length, this.bytesAvailable);
			}
		}
		
		private function onData(e:Event):void {
			while (_expectLength <= this.bytesAvailable) {
				if (_readingDataLength) {
					if (_buf != null) {
						this.readBytes(_buf, _buf.length, _expectLength);
						_expectLength = _buf.readInt();
						_buf = null;
					} else {
						_expectLength = this.readInt();
					}
					_readingDataLength = false;
				} else {
					if (_buf != null) {
						this.readBytes(_buf, _buf.length, _expectLength);
						_receiver.on_data(this, _buf);
						_buf = null;					
					} else {
						_receiver.on_data(this, this);
					}
					_expectLength = 4;
					_readingDataLength = true;
				}
			}
			
			if (this.bytesAvailable > 0) {
				if (_buf == null) {
					_buf = new Stream;
				}
				_expectLength -= this.bytesAvailable;
				this.readBytes(_buf, _buf.length, this.bytesAvailable);
			}
		}
		
		private function onData2(e:Event):void {
			while (_expectLength <= this.bytesAvailable) {
				if (_readingDataLength) {
					_expectLength = this.readInt();
					_readingDataLength = false;
				} else {
					_receiver.on_data(this, this);
					_expectLength = 4;
					_readingDataLength = true;
				}
			}
		}

		
		private function onServerClose(e:Event):void {
			$log.error(e);
			this.close();
		}
		
		private function onIOError(e:Event):void {
			$log.error(e);
			this.close();
		}
		
		private function onSecurityError(e:Event):void {
			$log.error(e);
			this.close();
		}
		
		private function onDataTest(e:Event):void {
			trace("receive " + this.bytesAvailable + " bytes");
			var i:int = this.readInt();
			trace("int " + i);
			var s:String = this.readUTF();
			trace("string " + s);
		}
		
		public function getOutputStream():OutputStream {
			return new TunnelOutputStream(this);
		}

	}
}