package slices
{
	import flash.display.DisplayObject;
	
	import slices.TimeSlice;
	import org.musince.util.MathPro;
	
	public class MoveTo extends TimeSlice
	{
		public var targetX:int;
		public var targetY:int;
		public var baggage:DisplayObject;
		public var speed:Number;
		
		public function MoveTo(d:DisplayObject, targetX:int, targetY:int, speed:Number)
		{
			super();
			this.baggage = d;
			this.targetX = targetX;
			this.targetY = targetY;
			this.speed = speed;
		}
		
		override public function onUpdate():void
		{
			var d:Number = MathPro.distance3(targetX ,targetY, baggage.x, baggage.y);
			if (d <= speed) {
				baggage.x = targetX;
				baggage.y = targetY;
				isDone = true;
				return;
			}
			var dx:Number = targetX - baggage.x;
			var dy:Number = targetY - baggage.y;
			var angle:Number = Math.atan2(dy, dx);
//			var s:Number = (_now-_then)*speed/1000;
			var s:Number = speed;
			var ax:Number = Math.cos(angle);
			var bx:Number = Math.sin(angle);
			var vx:Number = Math.cos(angle) * s;
			var vy:Number = Math.sin(angle) * s;
			baggage.x += vx;
			baggage.y += vy;
//			trace("move", vx, vy);
		}
		
		
	}
}