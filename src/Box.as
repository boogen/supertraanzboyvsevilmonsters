package  
{
	import assets.AssetFactory;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author boogie
	 */
	public class Box extends Sprite
	{
		private var _frame:Bitmap;
		
		public function Box() 
		{
			_frame = AssetFactory.getBox();
			addChild(_frame);
		}
		
		public function aabb(hero:Hero):Boolean
		{
			return (((hero.x < x + width && x + width < hero.x + hero.width) || (hero.x < x && x < hero.x + width)) && ((y < hero.y && hero.y < y + height) || (hero.y < y && y < hero.y + hero.height)));
		}
	}

}