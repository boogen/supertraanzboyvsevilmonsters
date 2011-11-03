package  
{
	import assets.LevelAssets;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author boogie
	 */
	public class Menu extends Sprite
	{
		private var _background:Bitmap;
		
		public function Menu() 
		{
			_background = new LevelAssets.MENU();
			addChild(_background);
			
			var selector:Sprite = new Sprite();
			selector.graphics.beginFill(0xffffff);
			selector.graphics.drawRect(0, 0, 265, 30);
			selector.graphics.endFill();
			selector.x = 347;
			selector.y = 287;
			addChild(selector);
			
			var startgame:MenuTextField = new MenuTextField();
			startgame.text = "start game";
			startgame.x = 410;
			startgame.y = 290;
			
			
			addChild(startgame);
		
			addEventListener(Event.ADDED_TO_STAGE, eventAddedToStage);
			
		}
		
		private function eventAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, eventAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, eventKeyDown);
		}
		
		private function eventKeyDown(e:KeyboardEvent):void 
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, eventKeyDown);
			dispatchEvent(new Event("StartGame"));
		}
		
		
	}

}