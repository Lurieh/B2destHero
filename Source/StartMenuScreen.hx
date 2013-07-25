package ;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.Font;

@:font("assets/ComicBook.ttf") class StartMenuFont extends Font {}

/**
 * ...
 * @author Mathieu Foucat
*/
class StartMenuScreen extends Sprite
{

	public function new() 
	{
		super ();
		
		buttonMode = true;
		
		Font.registerFont (StartMenuFont);

		graphics.beginFill(0x000000);
		graphics.moveTo(0, 0);
		graphics.lineTo(960,0);
		graphics.lineTo(960,540);
		graphics.lineTo(0,540);
		graphics.endFill();
		
		var tormat:TextFormat = new TextFormat("Comic Book", 72, 0xface00, TextFormatAlign.LEFT);

		var looker:TextField = new TextField();
		looker.defaultTextFormat = tormat;
		looker.embedFonts = true;
		looker.selectable = false;
		looker.width = 960;
		looker.x = 170;
		looker.y = 100;
		looker.text = "Greedie$t";
		addChild(looker);

		var tormat2:TextFormat = new TextFormat("Comic Book", 72, 0xffffff, TextFormatAlign.RIGHT);

		var looker2:TextField = new TextField();
		looker2.defaultTextFormat = tormat2;
		looker2.embedFonts = true;
		looker2.selectable = false;
		looker2.width = 740;
		looker2.x = 0;
		looker2.y = 100;
		looker2.text = " Hero";
		addChild(looker2);
	
		var tormat3:TextFormat = new TextFormat("Comic Book", 30, 0xffffff, TextFormatAlign.CENTER);

		var looker3:TextField = new TextField();
		looker3.defaultTextFormat = tormat3;
		looker3.embedFonts = true;
		looker3.selectable = false;
		looker3.width = 930;
		looker3.y = 270;
		looker3.text = "Appuyez sur une touche pour commencer";
		addChild(looker3);

		var tormat4:TextFormat = new TextFormat("Comic Book", 18, 0xface00, TextFormatAlign.CENTER);

		var looker4:TextField = new TextField();
		looker4.defaultTextFormat = tormat4;
		looker4.embedFonts = true;
		looker4.selectable = false;
		looker4.width = 930;
		looker4.height = 100;
		looker4.x = 0;
		looker4.y = 500;
		looker4.text = "Fait par Lurieh en haxe avec Box2D et R.U.B.E";
		addChild(looker4);
	}
	
}