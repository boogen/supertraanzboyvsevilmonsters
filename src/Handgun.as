package  
{
	import assets.AssetFactory;
	import enums.CharacterState;
	import enums.Direction;
	import flash.geom.Point;
	/**
	 * ...
	 * @author boogie
	 */
	public class Handgun extends Gun
	{

		private var _triggerDown:Boolean;
		private var _bulletsCount:uint;
		
		public function Handgun() 
		{
			setFrames();
			_leftPosition = new Point(-15, 20);
			_rightPosition = new Point(25, 20);
			
			_damage = 1;
		}
		
		override protected function setFrames():void
		{
			_frames[Direction.LEFT] = AssetFactory.getHandgunLeft();
			_frames[Direction.RIGHT] = AssetFactory.getHandgunRight();
		}
		
		override public function onTick():void 
		{
			super.onTick();
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
			return "handgun";
		}
			
	}

}