package org.musince.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class BitmapUtil
	{
		public static function convertToBitmap(source:DisplayObject):Bitmap
		{
			var bound:Rectangle = source.getBounds(source);
			trimRect(bound);
			var data:BitmapData = new BitmapData(bound.width, bound.height, 
				true, 0x00000000);
			data.draw(source, new Matrix(1, 0, 0, 1, -bound.x, -bound.y));
			var bitmap:Bitmap = new Bitmap(data);
			bitmap.x = bound.x;
			bitmap.y = bound.y;
			return bitmap;
		}
		
		private static function trimRect(rect:Rectangle):Rectangle
		{
			rect.x = int(rect.x);
			rect.y = int(rect.y);
			rect.width = Math.ceil(rect.width);
			rect.height = Math.ceil(rect.height);
			return rect;
		}
		
		public static function fitTo(bitmap:Bitmap, w:int, h:int):void {
			bitmap.smoothing = true;
			bitmap.width = w;
			bitmap.height = h;
		}
	}
}