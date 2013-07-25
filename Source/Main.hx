package;

import box2D.common.math.B2Vec2;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.Lib;
import flash.text.TextField;
import flash.ui.Keyboard;
import openfl.Assets;
import haxe.Log;

/**
 * ...
 * @author Mathieu Foucat
*/
class Main extends Sprite {
	
	//constantes
	static private var CAMERA_OFFSET:B2Vec2 = new B2Vec2(0, -0);
	static private var FORCE_MULT:Int = 200;
	static private var HALF_STAGE_SIZES:B2Vec2;

	//affichage
	private var retryButton:RetryButton;
	private var overlay:OverlayHUD;
	private var endScore:EndScore;
	
	//moteur
	private var gameWorld:GameWorld;
	private var pixelPerMeter:Float;
	private var gameState:GameState;
	
	//inputs
	private var mouseClicPos:B2Vec2;
	private var movingDown:Int;
	private var movingLeft:Int;
	private var movingRight:Int;
	private var movingUp:Int;
	private var keyW:Bool;
	private var keyX:Bool;
	private var keyC:Bool;
	
	//debug
	private var drawDebugGameWorld:Bool = false;	
	private var watcherText1:TextField;
	private var watcherText2:TextField;
	
	public function new () {
		super ();
		
		HALF_STAGE_SIZES = new B2Vec2(stage.stageWidth / 2, stage.stageHeight / 2);

		addEventListener (Event.ENTER_FRAME, onEnterFrame);
		Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, reportKeyDown);
		Lib.current.stage.addEventListener (KeyboardEvent.KEY_UP, reportKeyUp);
		
		gameState = GameState.StartMenu;
		
		start();
	}

	public function start():Void 
	{
		var levelFile:String = new String("");
		switch (gameState) 
		{
			case GameState.StartMenu: {
				var startMenu:StartMenuScreen = new StartMenuScreen();
				Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, anyKeyToStart);
				startMenu.addEventListener(MouseEvent.CLICK, buttonClicked);
				addChild(startMenu);
				return;
			}
			case GameState.TutoScreen: {
				var tutoScreen:Tuto = new Tuto();
				Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, anyKeyToStart);
				tutoScreen.addEventListener(MouseEvent.CLICK, buttonClicked);
				addChild(tutoScreen);
				return;
			}
			case GameState.Level01: {
				levelFile = "assets/Level01.json";
			}
			case GameState.Level02: {
				levelFile = "assets/Level02.json";
			}
			case GameState.Level03: {
				levelFile = "assets/Level03.json";
			}
			case GameState.Level04: {
				levelFile = "assets/Level04.json";
			}
			case GameState.Level05: {
				levelFile = "assets/Level05.json";
			}
		}
		//gameWorld contient le B2DWorld, gere le texturage des body et la majorité de la logique de jeu
		gameWorld = new GameWorld(drawDebugGameWorld, levelFile);
		//fond du décor
		var bitty:BitmapData = Assets.getBitmapData ("assets/Background.png");
		gameWorld.graphics.clear();
		gameWorld.graphics.beginBitmapFill(bitty);
		gameWorld.graphics.drawRect( -stage.stageWidth * 10, -stage.stageHeight * 30, stage.stageWidth * 18, stage.stageHeight * 40);
		gameWorld.graphics.endFill();
		
		addChild(gameWorld);
		//watcherText1.text = levelFile;

		overlay = new OverlayHUD();
		addChild(overlay);
		
		pixelPerMeter = gameWorld.getPixelPerMeter();
		
		watcherText1 = new TextField();
		watcherText1.text = "bla";
		watcherText1.width = stage.stageWidth;
		watcherText1.height = 100;
		watcherText1.textColor = 0x942F2F;
		watcherText1.selectable = false;
		//addChild(watcherText1);
		watcherText2 = new TextField();
		watcherText2.text = "bla2";
		watcherText2.width = stage.stageWidth;
		watcherText2.y = 30;
		watcherText2.textColor = 0x808080;
		watcherText2.selectable = false;
		//addChild(watcherText2);
		
		retryButton = new RetryButton();
		retryButton.addEventListener(MouseEvent.CLICK, buttonClicked);
		addChild(retryButton);
	}

	public function reStart():Void 
	{
		if (gameWorld != null) gameWorld.removeChildren();
		removeChildren();
		endScore = null;
		start();
	}

	private function onEnterFrame (event:Event):Void {
		if (gameState == GameState.StartMenu) return;
		if (gameState == GameState.TutoScreen) return;
		if (!gameWorld.okToRun) return;
		
		//mise à jour des scores - overlay
		gameWorld.this_onEnterFrame(event);
		var victimsLeft:Int = gameWorld.getVictimsLeft();
		var timeSpent:Int = gameWorld.getTimeSpent();
		
		overlay.setValues(victimsLeft, timeSpent);
		
		var heroPos:B2Vec2 = gameWorld.getHeroPos();
		var soulPos:B2Vec2 = gameWorld.getSoulPos();
		var heroBodyVelocity:B2Vec2 = gameWorld.getSoulVelocity();
		var heroBodySoulDistance:B2Vec2 = new B2Vec2((soulPos.x - heroPos.x), (soulPos.y - heroPos.y));
		var force:B2Vec2 = new B2Vec2(movingRight - movingLeft, movingDown - movingUp);
		
		///déplacement de "l'âme" du hero, un corps dynamique qui ne collisionne qu'avec les corps statiques du décor
		gameWorld.setSoulMove(force);
		
		///déplacement du corps du hero, un corps kinematique qui collisionne avec tout sauf les victimes
		heroBodyVelocity.add(heroBodySoulDistance);
		gameWorld.setHeroVelocity(heroBodyVelocity);		
		
		if (keyW) gameWorld.goBackToHeroBody();
		if (keyX) gameWorld.expulseHeroAuraContacts();
		if (keyC) gameWorld.heroAskReward();
		
		///camera scrolling
		gameWorld.scrollRect = new Rectangle(heroPos.x * pixelPerMeter - HALF_STAGE_SIZES.x, heroPos.y * pixelPerMeter - HALF_STAGE_SIZES.y + CAMERA_OFFSET.y, stage.stageWidth, stage.stageHeight);
		

		if (gameWorld.levelFinished && endScore == null) {
			gameWorld.okToRun = false;
			endScore = new EndScore(gameWorld);
			//Lib.current.stage.addEventListener (KeyboardEvent.KEY_DOWN, anyKeyToStart);
			endScore.addEventListener(MouseEvent.CLICK, buttonClicked);
			addChild(endScore);
		}
		//watcherText1.text = "Score : " + cast(score);// + "\n game phase : " + cast(gamePhase);
		//watcherText1.text = "ScrollRect : " + gameWorld.scrollRect.toString() + "\n game phase : " + cast(gamePhase);
		//watcherText1.text = "X : " + cast(this.stage.stageWidth) + "\nY : " + cast(this.stage.stageHeight);
		//watcherText2.text = "X : " + cast(soulVelocity.x) + "\nY : " + cast(soulVelocity.y);
		//watcherText2.text = gameWorld.watcher;
	}

	private function reportKeyDown(keybEvent:KeyboardEvent):Void { 
		//watcherText1.text = "Key Pressed: " + String.fromCharCode(keybEvent.charCode) + " (character code: " + keybEvent.charCode + ")"; 

		//var modValue:Float = 0.25;
		//if (keybEvent.charCode == 108) {
			//gameWorld.offsetY -= modValue;
		//}
		//if (keybEvent.charCode == 111) {
			//gameWorld.offsetY += modValue;
		//}
		//if (keybEvent.charCode == 109) {
			//pixelPerMeter -= modValue;
			//gameWorld.setPixelPerMeter(pixelPerMeter);
			//heroWorld.setPixelPerMeter(pixelPerMeter);
		//}
		//if (keybEvent.charCode == 112) {
			//pixelPerMeter += modValue;
			//gameWorld.setPixelPerMeter(pixelPerMeter);
			//heroWorld.setPixelPerMeter(pixelPerMeter);
		//}
	
		switch (keybEvent.keyCode) {
			case Keyboard.DOWN: movingDown = FORCE_MULT;
			case Keyboard.LEFT: movingLeft = FORCE_MULT;
			case Keyboard.RIGHT: movingRight = FORCE_MULT;
			case Keyboard.UP: movingUp = FORCE_MULT;
			case Keyboard.W: keyW = true;
			case Keyboard.X: keyX = true;
			case Keyboard.C: keyC = true;
		}
	}
	
	private function reportKeyUp(keybEvent:KeyboardEvent):Void { 
		switch (keybEvent.keyCode) {
			case Keyboard.DOWN: movingDown = 0;
			case Keyboard.LEFT: movingLeft = 0;
			case Keyboard.RIGHT: movingRight = 0;
			case Keyboard.UP: movingUp = 0;
			case Keyboard.W: keyW = false;
			case Keyboard.X: keyX = false;
			case Keyboard.C: keyC = false;
		}
	} 
	
	public function anyKeyToStart(keybEvent:KeyboardEvent):Void 
	{
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, anyKeyToStart);
		nextGameState();
	}
	
	public function buttonClicked(event:MouseEvent):Void 
	{
		
		if (event.target == retryButton) {
			event.stopImmediatePropagation();
			reStart();
		}else if (event.target == endScore) {
			event.stopImmediatePropagation();
			nextGameState();
		//}else if (event.target == overlay) {
			//event.stopImmediatePropagation();
			//reStart();
		}else {
			Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, anyKeyToStart);
			nextGameState();
		}
	}
	
	public function nextGameState():Void 
	{
		switch (gameState) 
		{
			case GameState.StartMenu: {
				gameState = GameState.TutoScreen;
			}
			case GameState.TutoScreen: {
				gameState = GameState.Level01;
			}
			case GameState.Level01: {
				gameState = GameState.Level02;
			}
			case GameState.Level02: {
				gameState = GameState.Level03;
			}
			case GameState.Level03: {
				gameState = GameState.StartMenu;
			}
			case GameState.Level04: {
				gameState = GameState.Level05;
			}
			case GameState.Level05: {
				gameState = GameState.StartMenu;
			}
		}
		reStart();
	}
}
