package  
{
	import assets.AssetFactory;
	import enums.CharacterState;
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author boogie
	 */
	public class Boss extends Monster
	{
		
		public function Boss() 
		{
			
		}
		
		override protected function loadFrames():void 
		{
			_frames = new Dictionary();
			_frames[CharacterState.RUNNING] = new Vector.<Vector.<Bitmap> >();			
			
			_frames[CharacterState.RUNNING][0] = AssetFactory.getBossRunningLeft();
			_frames[CharacterState.RUNNING][1] = AssetFactory.getBossRunningRight();
			
			_frames[CharacterState.JUMPING] = new Vector.<Vector.<Bitmap> >();	
			_frames[CharacterState.JUMPING][0] = AssetFactory.getBossJumpingLeft();
			_frames[CharacterState.JUMPING][1] = AssetFactory.getBossJumpingRight();
		}		
		
		override public function reset(speed:int):void
		{
			super.reset(speed);
			_health = 100;
		}

	}

}