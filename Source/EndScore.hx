package;

import flash.display.BlendMode;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.Font;

@:font("assets/ActionManBold.ttf") class EndScoreFont extends Font {}

/**
 * ...
 * @author Mathieu Foucat
*/
class EndScore extends Sprite
{
	
	public function new (pGameWorld:GameWorld) {
		
		super ();
		
		var totalVictims:Int = pGameWorld.getTotalVictims();
		var killedVictims:Int = pGameWorld.getVictimsKiled();
		var savedVictims:Int = pGameWorld.getVictimsSaved();
		var timeSpent:Int = pGameWorld.getTimeSpent();
		
		Font.registerFont (EndScoreFont);

		buttonMode = true;
		focusRect = false;
		
		graphics.beginFill(0x161616);
		graphics.moveTo(0, 0);
		graphics.lineTo(960,0);
		graphics.lineTo(960,540);
		graphics.lineTo(0,540);
		graphics.endFill();
		alpha = 0.75;
		
		var tormat:TextFormat = new TextFormat("Action Man Bold", 48, 0xf4b92a);
		var tormat2:TextFormat = new TextFormat("Action Man Bold", 60, 0xf4b92a, TextFormatAlign.RIGHT);

		var looker:TextField = new TextField();
		looker.defaultTextFormat = tormat;
		looker.embedFonts = true;
		looker.selectable = false;
		looker.width = 900;
		looker.height = 300;
		looker.x = 54;
		looker.y = 40;
		looker.text = "Argent pris : " + cast(savedVictims * 100) + "$ / " + cast(totalVictims * 100) + "$\nVictimes victimisées : " + cast(killedVictims) + "\nTemps : " + cast(timeSpent);
		addChild(looker);

		var looker2:TextField = new TextField();
		looker2.defaultTextFormat = tormat2;
		looker2.embedFonts = true;
		looker2.selectable = false;
		looker2.width = 906;
		looker2.y = 370;
		looker2.text = "Score : " + cast(Math.round((10000 * savedVictims - (killedVictims / 4) ) / (timeSpent / 4) ));
		addChild(looker2);
	}
}