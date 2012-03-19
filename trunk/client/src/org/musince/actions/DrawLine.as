package org.musince.actions
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import org.musince.core.TimeSlice;
	
	public class DrawLine extends TimeSlice
	{
		public var graphics:Graphics;
		public var speed:Number;
		public var style:Object;
		
		private var _from:Point;
		private var _to:Point;
		private var _f:Number = 0;
		
		
		public function DrawLine(graphics:Graphics, speed:Number, style:Object)
		{
			super();
			this.graphics = graphics;
			this.speed = speed;
			this.style = style;
		}
		
		override public function onStart():void
		{
			_from = input["from"];
			_to = input["to"];
		}
		
		override public function onUpdate():void
		{
			graphics.clear();
			graphics.lineStyle(style.t, style.c, 0xFFFFFF);
			graphics.moveTo(_from.x, _from.y);
			_f = Math.min(_f + speed, 1);
			var target:Point = Point.interpolate(_to, _from, _f);			
			graphics.lineTo(target.x, target.y);
			if (_f >= 1)
			{
				isEnd = true;
			}
		}
	}
}