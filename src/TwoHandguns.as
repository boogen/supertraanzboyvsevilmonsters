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
	public class TwoHandguns extends Gun
	{

		private var _triggerDown:Boolean;
		private var _bulletsCount:uint;
		private var _counter:uint;
		
		public function TwoHandguns() 
		{
			setFrames();
			_leftPosition = new Point(-15, 20);
			_rightPosition = new Point(-15, 20);
			
			_damage = 1;
		}
		
		override protected function setFrames():void
		{
			_frames[Direction.LEFT] = AssetFactory.getTwoHandGuns();
			_frames[Direction.RIGHT] = AssetFactory.getTwoHandGuns();
		}
		
		override public function onTick():void 
		{
			super.onTick();
		}
		
		override public function triggerDown():void 
		{
			if (!_triggerDown)
			{
				_bulletsCount += 2;
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
		
		override public function configureBullet(bullet:Bullet):void 
		{
			switch (_counter)
			{
				case 1:
					bullet.x = _leftPosition.x;
					bullet.y = _leftPosition.y - bullet.height / 2;
				break; 
				case 0:
					bullet.x = _rightPosition.x + width - 20;
					bullet.y = _rightPosition.y - bullet.height / 2;
				break;
			}
			
			bullet.damage = _damage;
			
			_counter = (_counter + 1) % 2;
			bullet.reset(_counter);
		}
		
		override public function getText():String
		{
			return "two handguns";
		}
			
	}

}