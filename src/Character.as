package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author boogie
	 */
	public class Character extends Sprite
	{
		protected const LEFT:uint = 0;
		protected const RIGHT:uint = 1;		
		protected var ANIMATION_SPEED:uint = 2;
		
		
		protected var _frames:Dictionary;
		protected var _frameCounter:uint;		
		protected var _currentFrame:Bitmap;		
		protected var _velocity:Point;
		protected var _last_x:uint;
		protected var _last_y:uint;		
		protected var _direction:uint = LEFT;		
		protected var _state:uint;		
		
		
		private var _frameLayer:Sprite;
		
		public function Character() 
		{
			_frameLayer = new Sprite();			
			addChild(_frameLayer);
		}
		
		protected function setX(value:uint):void 
		{
			_last_x = x;
			x = value;
		}
		
		protected function setY(value:uint):void 
		{
			_last_y = y;
			y = value;
		}		
		
		public function onTick():void 
		{
			_frameCounter++;
			if (_frameCounter % ANIMATION_SPEED == 0) 
			{
				if (_currentFrame && _currentFrame.parent) {
					_currentFrame.parent.removeChild(_currentFrame);
				}

				_currentFrame = _frames[_state][_direction][_frameCounter / ANIMATION_SPEED % _frames[_state][_direction].length];
				_frameLayer.addChild(_currentFrame);
			}			
			
			_last_x = x;
			_last_y = y;			
			
			x += _velocity.x;
			y += _velocity.y;
			
			if (_velocity.x < 0)
			{
				_direction = LEFT;				
			}
			else if (_velocity.x > 0)
			{
				_direction = RIGHT;
			}
		}
		
		public function onCollision(collision:Collision):void 
		{
			
		}
		
		public function aabb(rect:Rectangle):uint 
		{
			return 0;
		}
		

	
	}

}