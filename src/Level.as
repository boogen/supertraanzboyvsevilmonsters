package  
{
	import adobe.utils.CustomActions;
	import assets.LevelAssets;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import assets.AssetFactory;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author boogie
	 */
	public class Level extends Sprite
	{
		private var _rectangles:Vector.<Rectangle>;
		private var _platforms:Vector.<Bitmap>;
		private var _fireFrames:Vector.<Bitmap>;
		private var _fireFrameCounter:uint;
		private var _counter:uint;
		private var _gameover:Bitmap;
		
		public function Level() 
		{
			addChild(new LevelAssets.BACKGROUND);
		
			_platforms = new Vector.<Bitmap>();
				
			_platforms[0] = null;
			
			_platforms[1] = AssetFactory.getPlatform(1);
			_platforms[1].x = 240;
			_platforms[1].y = 440;
			addChild(_platforms[1]);
			
			_platforms[2] = AssetFactory.getPlatform(2);
			_platforms[2].x = 0;
			_platforms[2].y = 600;
			addChild(_platforms[2]);
			
			_platforms[3] = AssetFactory.getPlatform(3);
			_platforms[3].x = 520;
			_platforms[3].y = 600;
			addChild(_platforms[3]);
			
			_platforms[4] = AssetFactory.getPlatform(4);
			_platforms[4].x = 0;
			_platforms[4].y = 560;
			addChild(_platforms[4]);			
			
			_platforms[5] = AssetFactory.getPlatform(5);
			_platforms[5].x = 720;
			_platforms[5].y = 560;
			addChild(_platforms[5]);	
			
			_platforms[6] = AssetFactory.getPlatform(6);
			_platforms[6].x = 0;
			_platforms[6].y = 0;
			addChild(_platforms[6]);		
			
			_platforms[7] = AssetFactory.getPlatform(7);
			_platforms[7].x = 920;
			_platforms[7].y = 0;
			addChild(_platforms[7]);				
			
			_platforms[8] = AssetFactory.getPlatform(8);
			_platforms[8].x = 40;
			_platforms[8].y = 320;
			addChild(_platforms[8]);
			
			_platforms[9] = AssetFactory.getPlatform(9);
			_platforms[9].x = 720;
			_platforms[9].y = 320;
			addChild(_platforms[9]);				
			
			_platforms[10] = AssetFactory.getPlatform(10);
			_platforms[10].x = 240;
			_platforms[10].y = 200;
			addChild(_platforms[10]);	
			
			_platforms[11] = AssetFactory.getPlatform(11);
			_platforms[11].x = 40;
			_platforms[11].y = 0;
			addChild(_platforms[11]);				
			
			_platforms[12] = AssetFactory.getPlatform(12);
			_platforms[12].x = 520;
			_platforms[12].y = 0;
			addChild(_platforms[12]);					
			
			_rectangles = new Vector.<Rectangle>();			
			for (var i:uint = 1; i < _platforms.length; ++i)
			{
				_rectangles.push(new Rectangle(_platforms[i].x, _platforms[i].y, _platforms[i].width, _platforms[i].height));
			}

			
			_fireFrames = AssetFactory.getFire();
			
			for (var j:uint = 0; j < _fireFrames.length; ++j)
			{
				_fireFrames[j].x = 440;
				_fireFrames[j].y = 600;
			}
			
			_gameover = new LevelAssets.GAMEOVER();
			_gameover.y = 200;
		}
		
		public function gameover():void 
		{

			addChild(_gameover);			
		}
		
		public function resetGame():void 
		{
			if (_gameover.parent)
			{
				_gameover.parent.removeChild(_gameover);
			}
		}
		
		public function getRectangles():Vector.<Rectangle>
		{
			return _rectangles;
		}
		
		public function onTick():void 
		{
			if (_counter++ % 2 != 0)
			{
				return;
			}
			
			
			if (_fireFrames[_fireFrameCounter].parent)
			{
				_fireFrames[_fireFrameCounter].parent.removeChild(_fireFrames[_fireFrameCounter]);
			}
			
			_fireFrameCounter = (_fireFrameCounter + 1) % _fireFrames.length;
			
			addChild(_fireFrames[_fireFrameCounter]);
		}
		
	}

}