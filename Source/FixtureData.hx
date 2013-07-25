package ;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.geom.Matrix;

/**
 * ...
 * @author Mathieu Foucat
*/
class FixtureData
{
	public var name:String;
	public var sprite:Sprite;
	//public var movie:MovieClip;
	public var offset:Matrix;
	
	
	public function new(pName:String) 
	{
		//movie = new MovieClip();
		name = pName;
	}
	
}