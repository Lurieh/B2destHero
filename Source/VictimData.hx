package ;
import box2D.dynamics.B2Body;
import flash.display.Bitmap;
import flash.display.BlendMode;
import flash.display.MovieClip;
import flash.display.Sprite;
import openfl.Assets;

/**
 * ...
 * @author Mathieu Foucat
*/
class VictimData extends BodyData
{
	public var scared:Bool;
	public var saved:Bool;
	public var redeemed:Bool;
	public var scareyBodies:Array<B2Body>;
	public var directionArrow:Sprite;

	public function new(pName:String) 
	{
		super (pName);
		scareyBodies = new Array<B2Body>();
		scared = false;
		//une victime ne commence pas le niveau sauvée
		saved = false;
		redeemed = false;

		directionArrow = new Sprite();
		directionArrow.addChild(new Bitmap(Assets.getBitmapData ("assets/Arrow.png")));
		directionArrow.blendMode = BlendMode.INVERT;
		directionArrow.scaleX = directionArrow.scaleY = 0.5;
	}
	
	public function removeDirectionArrow():Void 
	{
		directionArrow.removeChildren();
	}
}