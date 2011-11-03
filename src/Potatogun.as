package  
{
	import assets.AssetFactory;
	import enums.Direction;
	import flash.geom.Point;
	/**
	 * ...
	 * @author boogie
	 */
	public class Potatogun extends Gun
	{
		
		private var _triggerDown:Boolean;
		private var _bulletsCount:uint;		
		
		public function Potatogun() 
		{
			setFrames();
			_leftPosition = new Point(-15, 27);
			_rightPosition = new Point(-5, 27);
			
			_damage = 3;			
		}
		
		override protected function setFrames():void
		{
			_frames[Direction.LEFT] = AssetFactory.getPotatogunLeft();
			_frames[Direction.RIGHT] = AssetFactory.getPotatogunRight();
		}
		
		override public function triggerDown():void 
		{
			if (!_triggerDown)
			{
				_bulletsCount++;
			}
			_triggerDown = true;			
		}
		
		override public function triggerUp():void 
		{
			
			_triggerDown = false;
		}			
		
		override public function getBulletsCount():uint
		{
			var result:uint = _bulletsCount;
			_bulletsCount = 0;
			return result;
		}	
		
		override public function getText():String
		{
			return "potato gun";
		}
					
		
	}

}