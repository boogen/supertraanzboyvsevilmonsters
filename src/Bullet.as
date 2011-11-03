package  
{
	import assets.AssetFactory;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author boogie
	 */
	public class Bullet extends Sprite
	{
		private var _velocity:Point;
		private const VERTICAL_SPEED:uint = 0;
		private const HORIZONTAL_SPEED:uint = 25;
		private var _finished:Boolean;
		private var _damage:int;
		
		private var _lastX:uint;
		
		public function Bullet(direction:int) 
		{
			addChild(AssetFactory.getBullet());
			
			if (direction == 0)
			{
				_velocity = new Point(-HORIZONTAL_SPEED, VERTICAL_SPEED);
			}
			else 
			{
				_velocity = new Point(HORIZONTAL_SPEED, VERTICAL_SPEED);
			}
						
		}
		
		public function set damage(value:int):void 
		{
			_damage = value
		}
		
		public function get damage():int
		{
			return _damage;
		}
		
		public function reset(direction:int):void 
		{
			if (direction == 0)
			{
				_velocity.x = -HORIZONTAL_SPEED;
			}
			else
			{
				_velocity.x = HORIZONTAL_SPEED;
			}
			_finished = false;
		}
		
		public function onTick():void 
		{
			_lastX = x;
			x += _velocity.x;
			y += _velocity.y;
			
		}
		
		public function collision(monster:Monster):Boolean
		{
			var left:Number;
			var right:Number;
			if (_lastX < x)
			{
				left = _lastX;
				right = x + width;
			}
			else 
			{
				left = x;
				right = _lastX + width;
			}
			var c:Boolean = (((monster.x <= left && left <= monster.x + monster.width) || (monster.x <= right && right <= monster.x + width)) && ((y < monster.y && monster.y < y + height) || (monster.y < y && y < monster.y + monster.height)));
			if (c)
			{
				_finished = true;
			}
			return c;
		}
		
		public function aabb(rect:Rectangle):Boolean 
		{
			var c:Boolean = ((rect.left < x + width && x + width < rect.right) || (rect.left < x && x < rect.right)) && ((y < rect.y && rect.y < y + height) || (rect.y < y && y < rect.y + rect.height));
			if (c)
			{
				_finished = true;
			}
			
			return c;
		}
		
		public function get velocity():Number
		{
			return _velocity.x;
		}
		
		public function isFinished():Boolean
		{
			return _finished;
		}
	}

}