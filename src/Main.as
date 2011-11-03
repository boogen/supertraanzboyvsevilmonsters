package 
{
	import assets.AssetFactory;
	import assets.DigitekTextField;
	import assets.HeroAssets;
	import assets.LevelAssets;
	import assets.SoundAssets;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import enums.Direction;
	import enums.Side;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author boogie
	 */
	public class Main extends Sprite 
	{
		
		private var _keys:Dictionary;
		private var _hero:Hero;
		private var _level:Level;
		private var _monsters:Vector.<Monster>;
		private var level_rectangles:Vector.<Rectangle>;
		
		private var _next_spawn_time:uint;
		
		private const STAGE_HEIGHT:uint = 638;
		
		
		private var _bullets:Vector.<Bullet>;
		
		private var _box_spawn_points:Vector.<Point>;
		
		private var _box:Box;
		private var _points:uint;
		private var _pointsTextField:TextField;
		private var _last_spawn_point:int;
		
		private var _labels:Vector.<FloatingTextField>;
		private var _menu:Menu;
		private var _gameover:Boolean;
		private var _bossSpawned:Boolean;
		private var _bossSpawnTime:uint;
		
		public function Main():void 
		{			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		
			_menu = new Menu();			
			_menu.addEventListener("StartGame", eventStartGame);
			addChild(_menu);
		}
		
		private function eventStartGame(e:Event):void 
		{
			if (_menu.parent)
			{
				_menu.parent.removeChild(_menu);
				startGame();
			}
		}
		
		public function resetGame():void
		{
			_keys[Direction.LEFT] = 0;
			_keys[Direction.RIGHT] = 0;
			_keys[Direction.UP] = 0;
			
			_pointsTextField.text = "0";
			_points = 0;
			
			_hero.x = 500;
			_hero.y = 300;
			_hero.alpha = 1;
			
			_gameover = false;
			
			_level.resetGame();
			_hero.reset();
			
			for (var i:uint; i < _monsters.length; ++i)
			{
				if (_monsters[i])
				{
					_monsters[i].finished = true;
					if (_monsters[i].parent)
					{
						_monsters[i].parent.removeChild(_monsters[i]);
					}
				}
			}
		}
		
		public function startGame():void 
		{
			_keys = new Dictionary();

			
			_level = new Level();
			addChild(_level);
			
			_pointsTextField = DigitekTextField.getTextField();
			_pointsTextField.x = 460;
			_pointsTextField.y = 20;
			addChild(_pointsTextField);			
			
			_hero = new Hero();
			addChild(_hero);
			
			_monsters = new Vector.<Monster>(20);
			
			_next_spawn_time = 0; 			
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, eventKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, eventKeyUp);
			addEventListener(Event.ENTER_FRAME, mainLoop);
			
			level_rectangles = _level.getRectangles();
			
			_bullets = new Vector.<Bullet>(100);
			
			_box_spawn_points = new Vector.<Point>();
			_box_spawn_points.push(new Point(320, 168));
			_box_spawn_points.push(new Point(600, 168));
			_box_spawn_points.push(new Point(836, 289));
			_box_spawn_points.push(new Point(100, 289));
			_box_spawn_points.push(new Point(460, 408));
			_box_spawn_points.push(new Point(99, 528));
			_box_spawn_points.push(new Point(821, 528));
			_box_spawn_points.push(new Point(319, 568));
			_box_spawn_points.push(new Point(603, 568));	
			
			_box = new Box();
			_last_spawn_point = -1;
			spawnBox();
			addChild(_box);
			
			_labels = new Vector.<FloatingTextField>();
			
			resetGame();
		}
		

		
		private function mainLoop(e:Event):void 
		{	
			_level.onTick();
			
			if (!_gameover)
			{			
							
			
				_hero.setState(getDirection());
				
				_hero.onTick();
				checkCollision(_hero, level_rectangles.length);		
			}
			
			for (var i:uint = 0; i < _monsters.length; ++i)
			{				
				if (_monsters[i])
				{
					if (!_monsters[i].isFinished())
					{
						_monsters[i].onTick();
						if (!_monsters[i].isDead())
						{
							checkCollision(_monsters[i], level_rectangles.length - 2);				
						}
					}
					else if (_monsters[i].parent)
					{
						_monsters[i].parent.removeChild(_monsters[i]);					
					}								
				}
			}
			
			if (_gameover)
			{
				return;
			}
			
			if (getTimer() >= _next_spawn_time)
			{				
				spawnMonster();
			}
			
			
			if (_points == 10 && _bossSpawnTime == 0)
			{
				_bossSpawnTime = getTimer() + 3000;
				var bossiscoming:FloatingTextField = new FloatingTextField(48);
				bossiscoming.text = "BOSS IS COMING";				
				bossiscoming.x = 320;
				bossiscoming.y = 150;
				addChildAt(bossiscoming, 1);
				_labels.push(bossiscoming);
			}
			
			if (!_bossSpawned && _bossSpawnTime && getTimer() > _bossSpawnTime)
			{
				spawnBoss();
			}

			shoot();				
			
			
			for (i = 0; i < _bullets.length; ++i)
			{
				if (_bullets[i] && !_bullets[i].isFinished())
				{
					_bullets[i].onTick();
					for (var j:uint = 0; j < _monsters.length; ++j)
					{
						if (_monsters[j] && !_monsters[j].isFinished())
						{
							if (_bullets[i].collision(_monsters[j]))
							{
								_monsters[j].takeDamage(_bullets[i].damage, _bullets[i].velocity);
							}
						}
					}
					
					for (j = 0; j < level_rectangles.length; ++j)
					{
						_bullets[i].aabb(level_rectangles[j]);
					}
					
						
					if (_bullets[i].isFinished() && _bullets[i].parent)
					{
						_bullets[i].parent.removeChild(_bullets[i]);						
					}
				}
			}
			
			
			if (_box.aabb(_hero))
			{
				var snd:Sound = new SoundAssets.POINT();
				snd.play();
				
				var gun:Gun = GunFactory.getGun(++_points);
				_hero.changeGun(gun);
				var floatingTextField:FloatingTextField = new FloatingTextField();
				floatingTextField.text = gun.getText();
				floatingTextField.x = _box.x + _box.width/2 - floatingTextField.width / 2;
				floatingTextField.y = _box.y - 30;
				addChildAt(floatingTextField, 1);
				_labels.push(floatingTextField);				
				
				spawnBox();				
				_pointsTextField.text = _points.toString();
				

			}
			
			for (var k:uint = 0; k < _labels.length; ++k)
			{
				_labels[k].onTick();				
			}
			
			if (_labels.length && _labels[0].isFinished())
			{
				var label:FloatingTextField = _labels.shift();
				if (label.parent)
				{
					label.parent.removeChild(label);
				}
			}
			
			for (var m:uint = 0; m < _monsters.length; ++m)
			{	
				var monster:Monster = _monsters[m];
				if (monster && !monster.isDead() && !monster.isFinished())
				{				
					if (_hero.simpleAABB(monster))
					{
						gameover();
						return;
						
					}
				}
			}
			
		}
		
		private function gameover():void 
		{
			_gameover = true;			
			_level.gameover();		
			
			while (_labels.length)
			{
				var label:FloatingTextField = _labels.shift();
				if (label.parent)
				{
					label.parent.removeChild(label);
				}
			}
			
		}
		
		private function spawnBox():void 
		{
			var i:uint;
			do 
			{
				i = Math.floor(Math.random() * _box_spawn_points.length);
			} while (i == _last_spawn_point);
			
			_box.x = _box_spawn_points[i].x;
			_box.y = _box_spawn_points[i].y;
			
			_last_spawn_point = i;
		}		
		
		private function spawnMonster():void 
		{
			_next_spawn_time = getTimer() + 300 + Math.floor(Math.random() * 3) * 1000;	
			var sign:int = (Math.random() - 0.5 > 0 ? 1 : -1);
			var index:int = -1;
			for (var i:uint = 0; i < _monsters.length; ++i)
			{				
				if (_monsters[i] == null || _monsters[i].isFinished())
				{
					index = i;
					break;
				}
			}
			
			if (index < 0)
			{
				return;
			}
			
			
			if (_monsters[index] == null)
			{
				_monsters[index] = new Monster();
			}
			var monster:Monster = _monsters[index];
			monster.reset(sign * 7);
			addChild(monster);						
		}
		
		private function spawnBoss():void 
		{
			var sign:int = (Math.random() - 0.5 > 0 ? 1 : -1);
			var boss:Boss = new Boss();
			boss.reset(sign * 3);
			_monsters.push(boss);
			addChild(boss);
			_bossSpawned = true;
		}
		
		private function shoot():void 
		{			
			var bulletsCount:uint = _hero.getBullets();
			
			for (var j:uint = 0; j < bulletsCount; ++j)
			{
				var snd:Sound = new SoundAssets.SHOT();
				snd.play();
				
				var index:int = -1;
				for (var i:uint; i < _bullets.length; ++i)
				{
					if (_bullets[i] == null)
					{
						index = i;
						break;
					}
				}
				
				var bullet:Bullet;
				if (index == -1)
				{
					bullet = new Bullet(_hero.direction);
					_bullets.push(bullet);
				}
				else if (_bullets[index] == null)
				{
					_bullets[index] = new Bullet(_hero.direction);
					bullet = _bullets[index];
				}

				
				bullet.reset(_hero.direction);
				_hero.configureBullet(bullet);
				
				addChild(bullet);
			}
		}
		
		private function checkCollision(character:Character, range:uint):void 
		{
			var col:Boolean = false;
			for (var i:uint; i < range; ++i)
			{
				var side:uint = character.aabb(level_rectangles[i]);
				if (side != Side.NONE)
				{					
					character.onCollision(new Collision(side, level_rectangles[i]));
					col = true;
				}				
			}
			
			if (!col)
			{
				character.onCollision(new Collision(Side.NONE, new Rectangle()));
			}
				
		}
		
		private function getDirection():uint
		{
			var max:uint = 0;
			var key:uint = Direction.NONE;
			for (var i:uint = 1; i <= 3; ++i)
			{
				if (_keys[i] > max)
				{
					max = _keys[i];
					key = i;
				}
			}
			
			return key;
		}
		
		private function eventKeyUp(e:KeyboardEvent):void 
		{
			switch(e.keyCode) 
			{
				case Keyboard.LEFT:				
					resetKey(Direction.LEFT);
				break;
				case Keyboard.RIGHT:
					resetKey(Direction.RIGHT);
				break;
				case Keyboard.UP:
					resetKey(Direction.UP);
				break;
				case Keyboard.SPACE:
					_hero.triggerUp();					
				break;
			}			
		}
		
		private function eventKeyDown(e:KeyboardEvent):void 
		{
			if (_gameover)
			{
				if (e.keyCode == Keyboard.SPACE)
				{
					resetGame();				
				}
			}
			else 
			{
				switch(e.keyCode) 
				{				
					case Keyboard.LEFT:
						pressKey(Direction.LEFT);					
					break;
					case Keyboard.RIGHT:
						pressKey(Direction.RIGHT);
					break;
					case Keyboard.UP:
						pressKey(Direction.UP);
					break;
					case Keyboard.SPACE:
						_hero.triggerDown();
					break;
				}
			}
		}
		
		private function resetKey(direction:uint):void 
		{
			for (var i:uint = 1; i <= 3; ++i)
			{
				if (_keys[i] > _keys[direction])
				{
					_keys[i] -= 1;
				}
			}
			_keys[direction] = 0;			
		}
		
		private function pressKey(direction:uint):void 
		{
			var max:uint = 0;
			for (var i:uint = 1; i <= 3; ++i)
			{
				if (_keys[i] > max)
				{
					max = _keys[i];
				}
			}
			
			_keys[direction] = max + 1;
		
		}
		
		
	}
	
}