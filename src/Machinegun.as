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
	public class Machinegun extends Gun
	{

		private var _triggerDown:Boolean;
		private var _bulletsCount:uint;
		private var _counter:uint;
		
		public function Machinegun() 
		{
			setFrames();
			_leftPosition = new Point(-30, 20);
			_rightPosition = new Point(25, 20);
			
			_damage = 1;
		}
		
		override protected function setFrames():void
		{
			_frames[Direction.LEFT] = AssetFactory.getMachinegunLeft();
			_frames[Direction.RIGHT] = AssetFactory.getMachinegunRight();
		}
		
		override public function onTick():void 
		{
			if (_triggerDown && _counter++ % 3 == 0)
			{
				_bulletsCount++;
			}
			super.onTick();
		}
		
		override public function triggerDown():void 
		{
		
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
			return "machinegun";
		}
			
		override public function recoil():int
		{
			if (_triggerDown)
			{
				return 3;
			}
			else 
			{
				return 0;
			}
		}
		
		override public function set opaqueBackground(value:Object):void 
		{
			super.opaqueBackground = value;
		}
	}

}