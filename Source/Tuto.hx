package ;
import flash.display.Sprite;
import flash.display.Bitmap;
import openfl.Assets;

/**
 * ...
 * @author ...
 */
class Tuto extends Sprite
{

	public function new() 
	{
		super ();
		
		buttonMode = true;
		
		var bitty:Bitmap = new Bitmap (Assets.getBitmapData("assets/Tuto.png"));
		addChild(bitty);
		
	}
	
}