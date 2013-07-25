package ;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.Font;

@:font("assets/ActionManBold.ttf") class OverlayFont extends Font {}

/**
 * ...
 * @author Mathieu Foucat
*/
class OverlayHUD extends Sprite
{
	private	var looker:TextField;
	//public var ellipse2:Sprite;
	
	
	public function new() 
	{
		super ();
		
		//affiche victime restantes et timer en haut à gauche
		var ellipse:Sprite = new Sprite ();
		
		ellipse.graphics.beginFill (0x000000, 0.5);
		ellipse.graphics.drawEllipse (8, 8, 224, 81);
		//ellipse.blendMode = BlendMode.SUBTRACT;
		
		addChild(ellipse);

		Font.registerFont (OverlayFont);

		var tormat:TextFormat = new TextFormat("Action Man Bold", 24, 0xface00);

		looker = new TextField();
		looker.defaultTextFormat = tormat;
		looker.embedFonts = true;
		looker.selectable = false;
		looker.width = 900;
		looker.height = 100;
		looker.x = 35;
		looker.y = 12;
		addChild(looker);
		
		//Font.registerFont (OverlayFont);
//
		//var tormat:TextFormat = new TextFormat("Action Man Bold", 24, 0xface00, TextFormatAlign.CENTER);
//
		//var looker2:TextField;
		//looker2 = new TextField();
		//looker2.defaultTextFormat = tormat;
		//looker2.embedFonts = true;
		//looker2.selectable = false;
		//looker2.width = 224;
		//looker2.height = 100;
		//looker2.x = 725;
		//looker2.y = 28;
		//looker2.text = "Recommencer";
		//addChild(looker2);
	}
	
	public function setValues(pVictimsLeft:Int, pTimeLeft:Float):Int
	{
		looker.text = "Victimes : " + cast(pVictimsLeft) + "\nTemps : " + cast(Math.round(pTimeLeft));
		return pVictimsLeft;
	}
}