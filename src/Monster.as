package  
{
	import assets.AssetFactory;
	import enums.CharacterState;
	import enums.Direction;
	import enums.Side;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author boogie
	 */
	public class Monster extends Character
	{
		private var _collision:uint;
		private var _last_state:uint;
		private var _speed:int;
		private var _isFinished:Boolean;
		protected var _health:int;
		private var _dead:Boolean;
		private var _deathTime:uint;
		private var _deathSprite:Sprite;
		private var _deathX:int;
		private var _deathY:int;
		private var _side:int;
		
		private const sin_pi4:Number = Math.sin(Math.PI / 4);
		private const cos_pi4:Number = Math.cos(Math.PI / 4);
		
		public function Monster() 
		{
			

			loadFrames();
			_velocity = new Point(0, 1);			
		}
		
		protected function loadFrames():void 
		{
			_frames = new Dictionary();
			_frames[CharacterState.RUNNING] = new Vector.<Vector.<Bitmap> >();			
			
			_frames[CharacterState.RUNNING][0] = AssetFactory.getMonsterRunningLeft();
			_frames[CharacterState.RUNNING][1] = AssetFactory.getMonsterRunningRight();
			
			_frames[CharacterState.JUMPING] = new Vector.<Vector.<Bitmap> >();	
			_frames[CharacterState.JUMPING][0] = AssetFactory.getMonsterJumpingLeft();
			_frames[CharacterState.JUMPING][1] = AssetFactory.getMonsterJumpingRight();
		}
		
		public function reset(speed:int):void 
		{
			_speed = speed;
			x = 450;
			y = -20;
			_state = CharacterState.RUNNING;
			_velocity.x = 0;
			_velocity.y = 1;
			_isFinished = false;
			_health = 3;
			_dead = false;
			_deathTime = 0;
			if (_deathSprite && _deathSprite.parent)
			{
				_deathSprite.parent.removeChild(_deathSprite);
			}
			
		}
		
		override public function onTick():void 
		{	
			if (!_isFinished && !_dead)
			{
				super.onTick();	
				
				if (y > 638)
				{
					_isFinished = true;
				}
				if (_health <= 0)
				{
					_dead = true;
					_deathTime = getTimer();
					_deathX = x;
					_deathY = y;
					
					var frame:Bitmap = new Bitmap(_currentFrame.bitmapData.clone());
					frame.x -= frame.width / 2;
					frame.y -= frame.height / 2;
					_deathSprite = new Sprite();
					_deathSprite.addChild(frame);
					_deathSprite.x += frame.width / 2 - 10;
					_deathSprite.y += frame.height / 2 - 10;
					if (_currentFrame.parent)
					{
						_currentFrame.parent.removeChild(_currentFrame);
					}
					addChild(_deathSprite);
					
				}
			}
			else if (_dead)
			{
				var t:uint = getTimer() - _deathTime;
				if (t > 1000)
				{
					_isFinished = true;
				}
				else
				{
					_deathSprite.rotation = t;	
					var p:Number = t / 1000 * Math.PI * 0.75
					var dx:Number = (120 * Math.cos(p) - 120);
					var dy:Number =  - 60 * Math.sin(p)
					x = _deathX + _side * 1.5 * (dx * cos_pi4 + dy * sin_pi4);
					y = _deathY + 1.5 * (- dx * sin_pi4 + dy * cos_pi4);					
				}
			}
			
				
			
		}	
		
		public function isFinished():Boolean
		{
			return _isFinished;
		}
		
		public function set finished(value:Boolean):void 
		{
			_isFinished = value;
		}
		
		public function isDead():Boolean
		{
			return _dead;
		}
		
		public function takeDamage(value:int, side:int):void 
		{
			_health -= value;
			if (side > 0)
			{
				_side = -1;
			}
			else 
			{
				_side = 1;	
			}
			
			if (_currentFrame && _currentFrame.parent)
			{
				var frame:Bitmap = new Bitmap(_currentFrame.bitmapData.clone());
				frame.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 255, 0, 0, 0);
				_currentFrame.parent.removeChild(_currentFrame);
				_currentFrame = frame;
				addChild(_currentFrame);
			}
			
		}
		
		override public function onCollision(collision:Collision):void 
		{
			_collision = collision.side;
			switch (collision.side)
			{
				case Side.LEFT:
				case Side.RIGHT:							
					_velocity.x = -_velocity.x;
				break;
				case Side.TOP:
					setY(collision.rect.top - height);
					if (_velocity.x == 0)
					{
						_velocity.x = _speed;
					}
					_velocity.y = 1;
					_state = CharacterState.RUNNING;
				break;
				case Side.NONE:
					_velocity.y += 1;
					_state = CharacterState.JUMPING;
				break;
			}
		}	
		
		override public function aabb(rect:Rectangle):uint 
		{			
			var right:Boolean = (rect.left < x + width && x + width < rect.right);
			var left:Boolean = (rect.left < x && x < rect.right);
			var bottom:Boolean = (y < rect.y && rect.y < y + height);
			var top:Boolean = (rect.y < y && y < rect.y + rect.height);
			
			if ((left || right) && (top || bottom))
			{
				var dx:Number = x - _last_x;
				var dy:Number = y - _last_y;
				
				var p:Point = new Point();
				if (dx > 0)
				{
					p.x = Math.min(x + width, rect.right) - dx;
				}
				else {
					p.x = Math.max(x, rect.left) - dx;
				}
				
				if (dy >= 0)
				{
					p.y = Math.min(y + height, rect.y + rect.height) - dy;
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
		

	}

}