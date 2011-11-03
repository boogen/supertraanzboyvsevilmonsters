package assets
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author boogie
	 */
	public class AssetFactory 
	{
		private static const SCALE_X:Number = 1.5;
		private static const SCALE_Y:Number = 1.5;
		
		public static function getHetoStandingLeft():Vector.<Bitmap> 
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedLeft(scaled(new HeroAssets.STANDING())));
			
			return result;
		}
		
		public static function getHetoStandingRight():Vector.<Bitmap> 
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedRight(scaled(new HeroAssets.STANDING())));
			
			return result;
		}		
		
		public static function getHeroRunningLeft():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedLeft(scaled(new HeroAssets.STANDING())));
			result.push(turnedLeft(scaled(new HeroAssets.RUNNING_1())));
			result.push(turnedLeft(scaled(new HeroAssets.RUNNING_2())));
			
			return result;
		}
		
		public static function getHeroRunningRight():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedRight(scaled(new HeroAssets.STANDING())));
			result.push(turnedRight(scaled(new HeroAssets.RUNNING_1())));
			result.push(turnedRight(scaled(new HeroAssets.RUNNING_2())));
			
			return result;			
		}
		
		public static function getHeroJumpingLeft():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedLeft(scaled(new HeroAssets.JUMPING())));
			
			return result;			
		}
		
		public static function getHeroJumpingRight():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedRight(scaled(new HeroAssets.JUMPING())));
			
			return result;			
		}		
		
		private static function turnedLeft(bmp:Bitmap):Bitmap
		{			
			return bmp;
		}
		
		private static function turnedRight(bmp:Bitmap):Bitmap
		{			
		
			bmp.scaleX *= -1;
			bmp.x += bmp.width;
			return bmp;
		}		
		
		private static function scaled(bmp:Bitmap):Bitmap 
		{
			bmp.width *= SCALE_X;
			bmp.height *= SCALE_Y;		
			
			return bmp;
		}
		
		public static function getPlatform(nr:uint):Bitmap
		{
			switch (nr) 
			{
				case 1:
					return new LevelAssets.PLATFORM_1;
				break;
				case 2:
					return new LevelAssets.PLATFORM_2;
				break;
				case 3:
					return new LevelAssets.PLATFORM_3;
				break;
				case 4:
					return new LevelAssets.PLATFORM_4;
				break;
				case 5:
					return new LevelAssets.PLATFORM_5;
				break;
				case 6:
					return new LevelAssets.PLATFORM_6;
				break;		
				case 7:
					return new LevelAssets.PLATFORM_7;
				break;
				case 8:
					return new LevelAssets.PLATFORM_8;
				break;
				case 9:
					return new LevelAssets.PLATFORM_9;
				break;
				case 10:
					return new LevelAssets.PLATFORM_10;
				break;
				case 11:
					return new LevelAssets.PLATFORM_11;
				break;
				case 12:
					return new LevelAssets.PLATFORM_12;
				break;					
			}
			
			return null;
		}
		
		public static function getMonsterRunningRight():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(new MonsterAssets.MONSTER_1());
			result.push(new MonsterAssets.MONSTER_2());
			result.push(new MonsterAssets.MONSTER_3());
			result.push(new MonsterAssets.MONSTER_4());
			result.push(new MonsterAssets.MONSTER_5());
			result.push(new MonsterAssets.MONSTER_6());
			result.push(new MonsterAssets.MONSTER_7());
			result.push(new MonsterAssets.MONSTER_8());			
			result.push(new MonsterAssets.MONSTER_9());
			
			return result;
		}
		
		public static function getMonsterRunningLeft():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedRight(new MonsterAssets.MONSTER_1()));
			result.push(turnedRight(new MonsterAssets.MONSTER_2()));
			result.push(turnedRight(new MonsterAssets.MONSTER_3()));
			result.push(turnedRight(new MonsterAssets.MONSTER_4()));
			result.push(turnedRight(new MonsterAssets.MONSTER_5()));
			result.push(turnedRight(new MonsterAssets.MONSTER_6()));
			result.push(turnedRight(new MonsterAssets.MONSTER_7()));
			result.push(turnedRight(new MonsterAssets.MONSTER_8()));			
			result.push(turnedRight(new MonsterAssets.MONSTER_9()));
			
			return result;
		}		
				
		
		public static function getMonsterJumpingLeft():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedRight(new MonsterAssets.MONSTER_JUMPING()));
			
			return result;			
		}
		
		public static function getMonsterJumpingRight():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(new MonsterAssets.MONSTER_JUMPING());
			
			return result;			
		}			
		
		public static function getHandgunLeft():Bitmap
		{
			
			return new GunAssets.HANDGUN_LEFT();
						
		}			
		
		public static function getHandgunRight():Bitmap
		{
			return turnedRight(new GunAssets.HANDGUN_LEFT());
		}				
		
		public static function getBullet():Bitmap
		{
			return new GunAssets.BULLET_BITMAP;
		}	
		
		public static function getBox():Bitmap
		{
			return new LevelAssets.BOX;
		}				
		
		public static function getPotatogunLeft():Bitmap
		{
			
			return new GunAssets.POTATOGUN_LEFT();
						
		}			
		
		public static function getPotatogunRight():Bitmap
		{
			return turnedRight(new GunAssets.POTATOGUN_LEFT());
		}		
		
		public static function getFire():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			result.push(new LevelAssets.FIRE_1());
			result.push(new LevelAssets.FIRE_2());
			result.push(new LevelAssets.FIRE_3());
			result.push(new LevelAssets.FIRE_4());
		
			return result;
		}
		
		public static function getMachinegunLeft():Bitmap
		{
			
			return new GunAssets.MACHINEGUN_LEFT();
						
		}			
		
		public static function getMachinegunRight():Bitmap
		{
			return turnedRight(new GunAssets.MACHINEGUN_LEFT());
		}			
		
		public static function getTwoHandGuns():Bitmap
		{
			return turnedRight(new GunAssets.TWOHANDGUNS());
		}				
		
		
		public static function getBossRunningRight():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(new MonsterAssets.BOSS_1());
			result.push(new MonsterAssets.BOSS_2());
			result.push(new MonsterAssets.BOSS_3());
			result.push(new MonsterAssets.BOSS_4());
			result.push(new MonsterAssets.BOSS_5());
			result.push(new MonsterAssets.BOSS_6());
			result.push(new MonsterAssets.BOSS_7());
			
			return result;
		}
		
		public static function getBossRunningLeft():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedRight(new MonsterAssets.BOSS_1()));
			result.push(turnedRight(new MonsterAssets.BOSS_2()));
			result.push(turnedRight(new MonsterAssets.BOSS_3()));
			result.push(turnedRight(new MonsterAssets.BOSS_4()));
			result.push(turnedRight(new MonsterAssets.BOSS_5()));
			result.push(turnedRight(new MonsterAssets.BOSS_6()));
			result.push(turnedRight(new MonsterAssets.BOSS_7()));
			
			return result;
		}		
				
		
		public static function getBossJumpingLeft():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(turnedRight(new MonsterAssets.BOSS_JUMPING()));
			
			return result;			
		}	
		
		public static function getBossJumpingRight():Vector.<Bitmap>
		{
			var result:Vector.<Bitmap> = new Vector.<Bitmap>();
			
			result.push(new MonsterAssets.BOSS_JUMPING());
			
			return result;			
		}			
	}

}