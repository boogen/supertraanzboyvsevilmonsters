package assets 
{
	import adobe.utils.CustomActions;
	import flash.events.TextEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author boogie
	 */
	public class DigitekTextField 
	{
		[Embed(source="../../assets/Digitek.ttf", fontFamily="Digitek")] 
		public var digitek:String;
      			
		public static function getTextField():TextField
		{
          var format:TextFormat	      = new TextFormat();
          format.font		      	  = "digitek";
          format.color                = 0xFFFFFF;
          format.size                 = 32;
						
          var label:TextField         = new TextField();
          label.embedFonts            = true;
          label.autoSize              = TextFieldAutoSize.CENTER;
          label.defaultTextFormat     = format;          
		  label.text = "0";
          
		  return label;
       }
		
	}

}