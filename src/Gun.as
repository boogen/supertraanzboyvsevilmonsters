package  
{
	import enums.Direction;
	import enums.Guns;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author boogie
	 */
	public class Gun extends Sprite
	{
		private var _frame:Bitmap;
		protected var _frames:Dictionary;
		protected var _direction:int;		
		protected var _damage:int;
		protected var _leftPosition:Point;
		protected var _rightPosition:Point;		
		
		public function Gun() 
		{
			_frames = new Dictionary();
			setFrames();
			_direction = Direction.LEFT;
		}
		
		protected function setFrames():void
		{
			
		}
		
		public function setDirection(direction:int):void 
		{
			switch(direction)
			{
				case Direction.LEFT:
					x = _leftPosition.x;
					y = _leftPosition.y;
					_direction = direction;
				break;
				case Direction.RIGHT:
				x = _rightPosition.x;
				y = _rightPosition.y;
					_direction = direction;
				break;				
			}			
		}
		
		public function triggerDown():void 
		{
			
		}
		
		public function triggerUp():void 
		{
			
		}		
		
		public function onTick():void 
		{
			if (_frame && _frame.parent)
			{
				_frame.parent.removeChild(_frame);
			}
			
			_frame = _frames[_direction];
			addChild(_frame);
		}
		
		public function getBulletsCount():uint
		{
			return 0;
		}
		
		public function configureBullet(bullet:Bullet):void
		{
			switch (_direction)
			{
				case Direction.LEFT:
					bullet.x = _leftPosition.x;
					bullet.y = _leftPosition.y - bullet.height / 2;
				break; 
				case Direction.RIGHT:
					bullet.x = _rightPosition.x + width - 20;
					bullet.y = _rightPosition.y - bullet.height / 2;
				break;
			}
			
			bullet.damage = _damage;			
		}
		
		public function getText():String
		{
			return "";
		}
		
		public function recoil():int
		{
			return 0;
		}
		
	}

}