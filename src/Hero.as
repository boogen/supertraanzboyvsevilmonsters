package  
{
	import assets.HeroAssets;
	import assets.SoundAssets;
	import enums.Guns;
	import flash.display.Bitmap;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import enums.Direction;
	import enums.CharacterState;
	import enums.Side;
	import assets.AssetFactory;
	import flash.media.Sound;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author boogie
	 */
	public class Hero extends Character
	{
		private const MAX_VERTICAL_VELOCITY:uint = 22;
		private const HORIZONTAL_VELOCITY:uint = 10;
		private var _last_state:uint;
		private var _collision:uint;

		
		private var _width:uint;
		private var _height:uint;
		
		
		private var _gun:Gun;
		
		public function Hero() 
		{
			_state = CharacterState.STANDING;
			
			_frames = new Dictionary();
			_frames[CharacterState.STANDING] = new Vector.<Vector.<Bitmap> >();
			_frames[CharacterState.RUNNING] = new Vector.<Vector.<Bitmap> >();
			_frames[CharacterState.JUMPING] = new Vector.<Vector.<Bitmap> >();
			
			_frames[CharacterState.STANDING][LEFT] = AssetFactory.getHetoStandingLeft();
			_frames[CharacterState.STANDING][RIGHT] = AssetFactory.getHetoStandingRight();
			_frames[CharacterState.RUNNING][LEFT] = AssetFactory.getHeroRunningLeft();
			_frames[CharacterState.RUNNING][RIGHT] = AssetFactory.getHeroRunningRight();
			_frames[CharacterState.JUMPING][LEFT] = AssetFactory.getHeroJumpingLeft();
			_frames[CharacterState.JUMPING][RIGHT] = AssetFactory.getHeroJumpingRight();
			
			_width = 28;
			_height = 42;
			
			_velocity = new Point(0, 1);
			
		}
		
		public function getBullets():uint
		{
			if (_gun)
			{
				return _gun.getBulletsCount();
			}
			
			return 0;
		}
		
		public function triggerDown():void 
		{
			if (_gun)
			{
				_gun.triggerDown();
			}
		}
		
		public function triggerUp():void 
		{
			if (_gun)
			{
				_gun.triggerUp();
			}
		}		
		
		public function changeGun(gun:Gun):void 
		{
			if (_gun && _gun.parent)
			{
				_gun.parent.removeChild(_gun);
			}
			_gun = gun;		
			if (_direction == LEFT)
			{
				_gun.setDirection(Direction.LEFT);
			}
			else 
			{
				_gun.setDirection(Direction.RIGHT);
			}
			addChild(_gun);			
		}
		
		public function get direction():uint
		{
			return _direction;
		}
		
		public function simpleAABB(monster:Monster):Boolean
		{
			return ((monster.x < x && x < monster.x + monster.width) || (monster.x < x + _width && x + _width < monster.x + monster.width)) && ((monster.y <= y && y <= monster.y + monster.height) || (monster.y <= y + _height && y + _height <= monster.y + monster.height));
		}
		
		override public function aabb(rect:Rectangle):uint 
		{			
			var right:Boolean = (rect.left < x + _width && x + _width < rect.right);
			var left:Boolean = (rect.left < x && x < rect.right);
			var bottom:Boolean = (y < rect.y && rect.y < y + _height);
			var top:Boolean = (rect.y < y && y < rect.y + rect.height);
			
			if ((left || right) && (top || bottom))
			{
				var dx:Number = x - _last_x;
				var dy:Number = y - _last_y;
				
				var p:Point = new Point();
				if (dx > 0)
				{
					p.x = Math.min(x + _width, rect.right) - dx;
				}
				else {
					p.x = Math.max(x, rect.left) - dx;
				}
				
				if (dy >= 0)
				{
					p.y = Math.min(y + _height, rect.y + rect.height) - dy;
				}
				else 
				{
					p.y = Math.max(y, rect.y) - dy;
				}
				
				
				
				var side:uint = Side.NONE;
				var min:Number = Number.MAX_VALUE;
				
				if (dy != 0)
				{
					var t1:Number = Math.abs((rect.y  - p.y) / dy);
					if (t1 < min)
					{
						side = Side.TOP;
						min = t1;
					}
					
					var t2:Number = Math.abs((rect.y + rect.height - p.y) / dy);
					if (t2 < min)
					{
						side = Side.BOTTOM;
						min = t2;
					}
				}
				
				if (dx != 0)
				{
					var t3:Number = Math.abs((rect.x - p.x) / dx);
					if (t3 < min)
					{
						side = Side.LEFT;
						min = t3;
					}
					
					var t4:Number = Math.abs((rect.x + rect.width - p.x) / dx);
					if (t4 < min)
					{
						side = Side.RIGHT;
						min = t4;
					}
						
				}
				
				return side;
			}
		
			return Side.NONE;
		}	
		
		
		

		
		override public function onTick():void 
		{
			super.onTick();
		
			if (_gun)
			{
				_gun.onTick();			
				
				if (_direction == LEFT)
				{
					x += _gun.recoil();
				}
				else
				{
					x -= _gun.recoil();
				}
			}
		}
		
		override public function onCollision(collision:Collision):void 
		{
			_collision = collision.side;
			switch (collision.side)
			{
				case Side.LEFT:
					setX(collision.rect.left - _width);					
				break;
				case Side.RIGHT:
					setX(collision.rect.right);
				break;
				case Side.TOP:
					setY(collision.rect.top - _height);
				break;
				case Side.BOTTOM:					
					setY(collision.rect.bottom);
					_velocity.y = 1;
				break;
			}
		}
		

				
		
		public function setState(direction:uint):void 
		{
			_last_state = _state;
			
			switch (_collision)
			{
				case Side.TOP:
					if (_state == CharacterState.JUMPING && _velocity.y >= 0) 
					{						
						_velocity.y = 1;			
						_state = CharacterState.STANDING;		
					}
				break;
				case Side.NONE:			
					_state = CharacterState.JUMPING;		
				break;
			}			
			
			
			switch (direction)
			{
				case Direction.NONE:
					_velocity.x = 0;
				break;
				case Direction.LEFT:
					_velocity.x = -HORIZONTAL_VELOCITY;								
				break;
				case Direction.RIGHT:
					_velocity.x = HORIZONTAL_VELOCITY;
				break;
				case Direction.UP:
					if (_state != CharacterState.JUMPING) 
					{
						_velocity.y = -MAX_VERTICAL_VELOCITY;						
						_state = CharacterState.JUMPING;
						var snd:Sound = new SoundAssets.JUMP();
						snd.play();
					}
				break;
				
			}			
			
			
			if (_state == CharacterState.JUMPING) 
			{
				_velocity.y += 1.5;
			}
			else if (_velocity.x != 0)
			{
				_state = CharacterState.RUNNING;
			}
			else
			{
				_state = CharacterState.STANDING;		
			}
			
			if (_gun)
			{
				_gun.setDirection(direction);
			}
			
		}
		
		public function configureBullet(bullet:Bullet):void 
		{
			_gun.configureBullet(bullet);
			bullet.x += x;
			bullet.y += y;
		}
		
		public function reset():void 
		{
			if (_gun && _gun.parent)
			{
				_gun.parent.removeChild(_gun);
			}			
			_gun = null;
			
		}
		
	}

}