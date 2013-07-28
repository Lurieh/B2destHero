package ;
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.Font;

@:font("assets/ActionManBold.ttf") class RetryFont extends Font {}

/**
 * ...
 * @author Mathieu Foucat
*/
class RetryButton extends Sprite
{

	public function new() 
	{
		super ();
		//buttonMode = true;
		//graphics.beginFill(0x80FF80, 0.5);
		//graphics.beginFill(0xFF8080, 0.5);
        //graphics.moveTo(860,50);
        //graphics.lineTo(910,50);
        //graphics.lineTo(910,100);
        //graphics.lineTo(860,100);
        //graphics.endFill();
		//bouton recommencer
		
		buttonMode = true;
		focusRect = false;
		graphics.beginFill (0x000000, 0.5);
		graphics.drawEllipse (0, 0, 224, 81);
	    graphics.endFill();
		//blendMode = BlendMode.SUBTRACT;
		x = 725;
		y = 8;
		width = 224;
		height = 81;
		
		Font.registerFont (RetryFont);

		var tormat:TextFormat = new TextFormat("Action Man Bold", 24, 0xface00, TextFormatAlign.CENTER);

		var looker2:TextField;
		looker2 = new TextField();
		looker2.defaultTextFormat = tormat;
		looker2.embedFonts = true;
		looker2.selectable = false;
		looker2.mouseEnabled = false;
		looker2.width = 224;
		looker2.height = 100;
		looker2.x = 0;
		looker2.y = 20;
		looker2.text = "Recommencer";
		addChild(looker2);
	}
	
}