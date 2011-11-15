package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.musince.actions.Progress;
	import org.musince.actions.UpdateProgress;
	import org.musince.logic.Athena;
	
	[SWF(width='1280',height='720', backgroundColor='0x000000')]
	
	public class ProgressTest extends Sprite
	{
		public var p:Progress;
		public var to:Number = 0;
		
		public function ProgressTest()
		{
			super();
			$root = this;
			$athena = new Athena();
			p = new Progress();
			$athena.addTimeSlice(p);
			var u:UpdateProgress = new UpdateProgress(p);
			$athena.addTimeSlice(u);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			$athena.start();
		}
		
		public function onClick(e:Event):void
		{
			to += 0.2;
			p.setNow(to);
		}
	}
}