package  
{
	import enums.Guns;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author boogie
	 */
	public class GunFactory 
	{
		private static var _guns:Dictionary;
		
		{
			_guns = new Dictionary();
		}
		
		public static function getGun(points:uint):Gun 
		{
			var bestGun:uint = Guns.TWOHANDGUNS;
			if (points > 2)
			{
				bestGun = Guns.POTATOGUN;
			}
			if (points > 3)
			{
				bestGun = Guns.MACHINEGUN;
			}
			
			if (!_guns[bestGun] && bestGun > Guns.TWOHANDGUNS)
			{
				_guns[bestGun] = true;
				return gun(bestGun);
			}
			else 
			{
				var randomGun:uint = Math.ceil(Math.random() * bestGun);
				return gun(randomGun);
			}
		}
		
		
		private static function gun(nr:int):Gun 
		{			
			switch (nr)
			{
				case Guns.HANDGUN:
					return new Handgun();
				break;	
				case Guns.TWOHANDGUNS:					
					return new TwoHandguns();
				break;					
				case Guns.POTATOGUN:					
					return new Potatogun();
				break;
				case Guns.MACHINEGUN:					
					return new Machinegun();
				break;				
			}
			
			return new Handgun();
		}
	}

}