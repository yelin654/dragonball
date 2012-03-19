package org.musince.display
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	public class ClickIcon extends Sprite
	{
		public var top:Shape = new Shape();
		public var bottom:Shape = new Shape();
		public var SQRT3:Number = 1.732;
		public var w:int = 30;
		public var h:int = w*SQRT3/2;

		public function ClickIcon()
		{
			super();
			var graphics:Graphics = top.graphics;
			graphics.beginFill(0xFFFFFF);
			var points:Vector.<Number> = Vector.<Number>([0,0, int(w/2), h, w,0]);
			graphics.drawTriangles(points);
			graphics.endFill();
			addChild(top);
			
			graphics = bottom.graphics;
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, w, int(w/10));
			graphics.endFill();
			bottom.y = h;
			addChild(bottom);
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			this.tabEnabled = false;
			this.tabChildren = false;
			
//			bottom.cacheAsBitmap = true;
//			top.cacheAsBitmap = true;
		}
		
		public function resetPosition():void
		{
			top.x = top.y = 0;
			bottom.x = 0;
			bottom.y = h;
		}
	}
}