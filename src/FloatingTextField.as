package  
{
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author boogie
	 */
	public class FloatingTextField extends TextField
	{		
		private var _startTime:uint;
		private var _finished:Boolean;
		
		[Embed(source="../assets/ArcadeClassic.ttf", fontFamily="ArcadeClassic")] 
		public var ArcadeClassic:String;		
		
		public function FloatingTextField(size:uint = 20) 
		{
			_startTime = getTimer();
		
			  var format:TextFormat	      = new TextFormat();
			  format.font		      	  = "ArcadeClassic";
			  format.color                = 0xFFFFFF;
			  format.size                 = size;
							
			  autoSize = TextFieldAutoSize.CENTER;
			  embedFonts = true;
			  defaultTextFormat = format;
			  
			  width = 140;
		}
		
		public function onTick():void 
		{
			y -= 2;
			if (getTimer() > _startTime + 2000)
			{
				_finished = true;
			}
		}
		
		
		public function isFinished():Boolean
		{
			return _finished;
		}
		
	}

}