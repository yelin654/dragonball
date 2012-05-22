package test
{
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	import flash.utils.Timer;
	import flash.utils.flash_proxy;
	
	import org.musince.core.TimeSlice;
	import org.musince.global.$log;
	import org.musince.global.$root;
	import org.musince.global.$syner;
	import org.musince.global.$tunnel;
	import org.musince.load.BinaryLoader;
	import org.musince.net.IDataOutputNet;
	import org.musince.net.IDataReceiver;
	import org.musince.net.IDataSender;
	import org.musince.net.OutputStream;
	import org.musince.net.ServerSyner;
	import org.musince.net.Tunnel;
	import org.musince.util.TextFieldUtil;
	
	public class TestNet extends TimeSlice implements IDataReceiver, IDataSender
	{
		public var sendInterval:int = 100;
		
		private var _cd:int = sendInterval;
		
		public var tip:TextField = TextFieldUtil.getTextField();
		
		public var delay:Timer = new Timer(1000, 1);
		
		public var length:int = 1;
		
		public function TestNet()
		{
			super();
			delay.addEventListener(TimerEvent.TIMER_COMPLETE, sendData);
		}
		
		override public function onStart():void
		{
			$tunnel.attachReceiver(this);
			sendData();
			tip.autoSize = TextFieldAutoSize.NONE;
			tip.width = 1280;
			tip.y = 300;
			$root.addChild(tip);
		}
		
//		override public function onUpdate():void
//		{
//			_cd -= (_now-_then);
//			if (_cd<= 0)
//			{
//				_cd = sendInterval;
//				sendData();
//			}
//		}
		
		private function sendData(e:Object=null):void
		{
			var stream:IDataOutputNet = getOutputStream();			
//			var random:int = Math.random() * 1000 + 1;
			length = (length+1) % 1000;
			for (var i:int = 0; i < length; i++)
			{
				stream.writeByte(i);
			}
			tip.text = "send data " + length + "B";
//			$log.debug("send data bytes:" + length);
			stream.flush();
		}
		
		public function on_data(tunnel:Tunnel, stream:IDataInput):void 
		{
			var bytes:ByteArray = new ByteArray();
			stream.readBytes(bytes);
			tip.text = "recv data " + bytes.length + "B";
			if (bytes.length != length)
			{
				$log.error("send recv not same length");
			}
//			$log.debug("recv data bytes:" + bytes.length);
			delay.reset();
			delay.delay = Math.random() * 1000 + 500; 
			delay.start();
		}
		
		public function getOutputStream():OutputStream {
			return $tunnel.getOutputStream();
		}
	}
}