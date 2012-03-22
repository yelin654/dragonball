package org.musince.rpc
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import org.musince.global.$chapterResource;
	import org.musince.global.$ui;
	import org.musince.util.DisplayUtil;

	public function change_background(pic:Dictionary):void
	{
		var bmp:Bitmap = $chapterResource.image[pic.rid];
		DisplayUtil.toGray(bmp);
		$ui.changeBackground(bmp);
	}
}