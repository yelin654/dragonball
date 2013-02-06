package org.musince.rpc
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import globals.$chapterResource;
	import globals.$ui;
	import utils.DisplayUtil;

	public function change_background(rid:int):void
	{
		var bmp:Bitmap = $chapterResource.image[rid];
		DisplayUtil.toGray(bmp);
		$ui.changeBackground(bmp);
	}
}