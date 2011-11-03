package  
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author boogie
	 */
	public class Collision 
	{
		public function Collision(s:uint , r:Rectangle)
		{
			side = s;
			rect = r;
		}
		
		public var side:uint;
		public var rect:Rectangle;
		
	}

}