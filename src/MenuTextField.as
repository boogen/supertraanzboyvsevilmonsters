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
	public class MenuTextField extends TextField
	{		
		
		[Embed(source="../assets/alphbeta.ttf", fontFamily="Alpha Beta BRK")] 
		public var alphabeta:String;		
		
		public function MenuTextField() 
		{
		
			  var format:TextFormat	      = new TextFormat();
			  format.font		      	  = "Alpha Beta BRK";
			  format.color                = 0x000000;
			  format.size                 = 24;
							
			  embedFonts = true;
			  defaultTextFormat = format;
			  
			  width = 140;
		}
		
		
	}

}