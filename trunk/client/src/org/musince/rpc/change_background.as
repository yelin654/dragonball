package org.musince.rpc
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import org.musince.global.$chapterResource;
	import org.musince.global.$ui;
	import org.musince.util.DisplayUtil;

	public function change_background(rid:int):void
	{
		var bmp:Bitmap = $chapterResource.image[rid];
		DisplayUtil.toGray(bmp);
		$ui.changeBackground(bmp);
	}
}