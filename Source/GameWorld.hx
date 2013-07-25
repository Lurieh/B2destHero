package;

import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Transform;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2World;
import box2D.dynamics.joints.B2WeldJointDef;
import flash.display.Bitmap;
import flash.display.BlendMode;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.Lib;
import flash.net.URLLoader;
import flash.net.URLRequest;
import haxe.Json;
import haxe.Timer;
import openfl.Assets;
import haxe.Log;


/**
 * ...
 * @author Mathieu Foucat
*/
class GameWorld extends Sprite {
	
	//constantes
	private static var PIXEL_PER_METER:Float = 25;
	private static var EXPULSING_MULT:Float = 25;
	private static var BODY_CONTROL_COOLDOWN:Int = 10000;
	
	//affichage
	private var PhysicsDebug:Sprite;
	private var isDebugDrawing:Bool;
	
	//logique de jeu
	private var heroBody:B2Body;
	private var heroSoul:B2Body;
	private var heroAuraContacts:Array<B2Body>;
	private var objectControlCoolDowned:Bool;
	private var controlledBody:B2Body;
	private var bodies:Array<B2Body>;
	private var destroyList:Array<B2Body>;
	private var contactListener:ContactListener;
	private var victimsTotal:Int;
	private var victimsSaved:Int;
	private var victimsKilled:Int;
	public var levelFinished:Bool = false;
	public var startTime:Float;
	
	//moteur
	private var world:B2World;
	public var okToRun:Bool = false;
	private var stepsPerSeconds:Int;
	private var veloctityIterations:Int;
	private var positionIterations:Int;
	private var animation:MovieClip;

	public var watcher:String;
	
	public function new (pIsDebugDrawing:Bool, pLevel:String) {
		
		super ();
		
		okToRun = false;
		world = new B2World (new B2Vec2 (0, 0.0), true);
		contactListener = new ContactListener(this);
		world.setContactListener(contactListener);
		
		destroyList = new Array<B2Body>();
		bodies = new Array<B2Body>();
		heroAuraContacts = new Array<B2Body>();
		
		isDebugDrawing = pIsDebugDrawing;
		
		victimsTotal = 0;
		victimsKilled = 0;
		victimsSaved = 0;
		
		PhysicsDebug = new Sprite ();
		addChild (PhysicsDebug);
		
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (PhysicsDebug);
		debugDraw.setDrawScale (PIXEL_PER_METER);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit);
		debugDraw.setFillAlpha(0.5);
		world.setDebugDraw (debugDraw);
		
		watcher = "bli";
		
		// lancement du chargement du fichier JSON généré par R.U.B.E
		var urlReq:URLRequest = new URLRequest(pLevel);
		var urlLoader:URLLoader = new URLLoader(urlReq);
		urlLoader.addEventListener(Event.COMPLETE, JSONLoaded);
		
		objectControlCoolDowned = true;
		Lib.current.stage.addEventListener(MouseEvent.CLICK, clicMullet);
		
		startTime = Timer.stamp();

	}
	
	public function this_onEnterFrame (event:Event):Void {
		if (!okToRun) return;
		world.step (1/stage.frameRate, veloctityIterations, positionIterations);
		world.clearForces ();
		if (isDebugDrawing) {
			world.drawDebugData ();
		}
		
		
		
		//mise à jour des bodies
		//TODO wake all au changement de phase
		for (i in 0...bodies.length) {
			if (bodies[i] == null)
				continue;
			
			var bodyData:BodyData = bodies[i].getUserData();
			var victimData:VictimData = new VictimData("I shouldn't be called");
			if (bodyData.name == "Victim") victimData = cast(bodyData);

			//On detruit les body de la destroyList (pour l'instant ça arrive qu'aux victimes)
			if (destroyList.remove(bodies[i])) {
				if (bodyData.name == "Victim") {
					victimData.removeDirectionArrow();
					if (!victimData.redeemed) victimsKilled++;
				}
				var fixtureToClean:B2Fixture = bodies[i].getFixtureList();
				while (fixtureToClean != null) {
					var fixtureData:FixtureData = fixtureToClean.getUserData();
					if (fixtureData.sprite == null) {
						fixtureToClean = fixtureToClean.getNext();
						continue;
					}
					fixtureData.sprite.removeChildren();
					fixtureToClean = fixtureToClean.getNext();
				}
				world.destroyBody(bodies[i]);
				bodies.slice(i, 1);
				continue;
			} 
			
			if (bodyData.name == "Victim") {
				//si il y a des corps dans scareyBodies alors la victime est apeurée
				if (victimData.scareyBodies.length > 0) {
					victimData.scared = true;
					victimData.saved = false;
				} else if (victimData.scareyBodies.length == 0 && victimData.scared == true) {
					victimData.scared = false;
					victimData.saved = true;
				}
				//dessine les flèches qui indique la position des victimes et qui sont stockées dans victimData
				var heroPos:B2Vec2 = heroBody.getPosition().copy();
				var victimPos:B2Vec2 = bodies[i].getPosition().copy();
				victimPos.subtract(heroPos);
				if (victimPos.length() > 30) 
				{
					victimData.directionArrow.visible = true;
					var directionAngle:Float = Math.atan2(victimPos.y, victimPos.x);
					var offset:B2Vec2 = new B2Vec2(-237, 31);
					offset = Outils.rotateVector(offset, directionAngle);
					directionAngle = directionAngle * (180 / Math.PI) + 90;
					victimData.directionArrow.rotation = directionAngle;
					victimData.directionArrow.x = offset.x + (heroPos.x * PIXEL_PER_METER);
					victimData.directionArrow.y = offset.y + (heroPos.y * PIXEL_PER_METER);
				} else victimData.directionArrow.visible = false;
			}
			

			//fixtures => texturage si il y a
			var fixture:B2Fixture = bodies[i].getFixtureList();
			while (fixture != null) {
				var fixtureData:FixtureData = fixture.getUserData();
				if (fixtureData.sprite == null) {
					fixture = fixture.getNext();
					continue;
				}
				
				//changement d'affichage des textures contextuelles des victimes
				if(bodyData.name == "Victim"){
					if (fixtureData.name == "NormalSight")
						if (victimData.scared == false && victimData.saved == false && victimData.redeemed == false) {
							fixtureData.sprite.visible = true;
						} else fixtureData.sprite.visible = false;
					if(fixtureData.name == "ScaredSight")
						if (victimData.scared == true && victimData.saved == false && victimData.redeemed == false) {
							fixtureData.sprite.visible = true;
						} else fixtureData.sprite.visible = false;
					if(fixtureData.name == "RedeemableSight")
						if (victimData.scared == false && victimData.saved == true && victimData.redeemed == false) {
							fixtureData.sprite.visible = true;
						} else fixtureData.sprite.visible = false;
					if(fixtureData.name == "SavedSight")
						if (victimData.redeemed == true) {
							fixtureData.sprite.visible = true;
						} else fixtureData.sprite.visible = false;
				}
				
				//on bouge les sprites des fixtures (c'est probablement fait de manière plus compliquée que ça ne devrais l'être...j'ai eu des problèmes...)
				var bodyTransform:B2Transform = bodies[i].getTransform();
				fixtureData.sprite.transform.matrix = Outils.B2DToSpriteMatrix(fixtureData.sprite, bodyTransform, PIXEL_PER_METER);
				
				var tempMatrix:Matrix = fixtureData.offset.clone();
				var rotatedOffset:B2Vec2 = Outils.rotateVector(new B2Vec2(tempMatrix.tx, tempMatrix.ty), bodyTransform.getAngle());
				tempMatrix.tx = rotatedOffset.x;
				tempMatrix.ty = rotatedOffset.y;
				tempMatrix.concat(fixtureData.sprite.transform.matrix);
				fixtureData.sprite.transform.matrix = new Matrix(tempMatrix.a, tempMatrix.b, tempMatrix.c, tempMatrix.d, -rotatedOffset.x + fixtureData.sprite.x, -rotatedOffset.y + fixtureData.sprite.y);
				
				//animation très basique du hero...
				if (fixtureData.name == "HeroBody") 
				{
					var velocity:B2Vec2 = getSoulVelocity();
					velocity.normalize();
					var sign:Int = velocity.x < 0 ? -1 : 1;
					fixtureData.sprite.scaleX *= velocity.x < 0 ? -1 : 1;
					var offset:Float = fixtureData.sprite.width * sign;
					fixtureData.sprite.x -= offset < 0 ? offset : 0;
				}
				
				fixture = fixture.getNext();
			}
		}
	}
	
	private function clicMullet(event:MouseEvent):Void {
		//var mouseClicPos:B2Vec2 = new B2Vec2(mouseX / PIXEL_PER_METER , mouseY / PIXEL_PER_METER);
		//bodyControl(mouseClicPos);
	}
	
	//pour prendre le controle d'un corps là ou se trouve "pos"
	public function bodyControl(pos:B2Vec2):Void {
		if (!okToRun) return;
		if (!objectControlCoolDowned) return;

		//var tempHeroPos:B2Vec2 = getHeroPos();
		var opos:B2Vec2 = pos.copy();
		opos.multiply(0.90);

		//var lineRay:Shape = new Shape();
		//lineRay.x = opos.x;
		//lineRay.y = opos.y;
		//lineRay.graphics.moveTo(opos.x * PIXEL_PER_METER, opos.y * PIXEL_PER_METER);
		//lineRay.graphics.lineStyle(3, 0xFFC080, 1, 0.1);
		//lineRay.graphics.lineTo(pos.x * PIXEL_PER_METER, pos.y * PIXEL_PER_METER);
		//addChild(lineRay);
		//Timer.delay(shootEnd.bind(lineRay), 500);
		objectControlCoolDowned = false;
		Timer.delay(function() objectControlCoolDowned = true, BODY_CONTROL_COOLDOWN);
		watcher = "object control available : " + cast(objectControlCoolDowned);

		//set up input
		//var input:B2RayCastInput;
		//input.p1 = tempHeroPos;
		//input.p2 = pos;
		//input.maxFraction = 100;
		var fixtureHit:B2Fixture = world.rayCastOne(opos, pos);
		if (fixtureHit != null) {
			if (fixtureHit.getBody().getType() != B2Body.b2_staticBody) 
			{
				controlledBody.setLinearVelocity(new B2Vec2(0, 0));
				controlledBody = fixtureHit.getBody();
				setSoulPosition(controlledBody.getPosition());
				return;
			}
		}
		fixtureHit = world.rayCastOne(pos, opos);
		if (fixtureHit != null) {
			if (fixtureHit.getBody().getType() != B2Body.b2_staticBody) 
			{
				controlledBody.setLinearVelocity(new B2Vec2(0, 0));
				controlledBody = fixtureHit.getBody();
				setSoulPosition(controlledBody.getPosition());
			}
		}
		
	}

	public function heroAskReward():Void {
		for (i in 0...heroAuraContacts.length) {
			if (heroAuraContacts[i].getUserData().name == "Victim") 
			{
				var victimData:VictimData = heroAuraContacts[i].getUserData();
				if (victimData.saved && !victimData.redeemed) {
					victimData.redeemed = true;
					victimsSaved++;
					victimData.removeDirectionArrow();
					if (getVictimsLeft() == 0){
						levelFinished = true;
					}
				}
			}
		}
	}
	
	//expulse les body qui se trouvent dans l'aura
	//TODO coolDown sur l'expulsion
	public function expulseHeroAuraContacts():Void {
		var heroPos:B2Vec2 = heroBody.getPosition();
		for (i in 0...heroAuraContacts.length) 
		{
			if (heroAuraContacts[i].getUserData().name == "Victim") continue;
			var bodyPos:B2Vec2 = heroAuraContacts[i].getPosition();
			var distance:B2Vec2 = bodyPos.copy();
			distance.subtract(heroPos.copy());
			distance.multiply(EXPULSING_MULT);
			heroAuraContacts[i].setAwake(true);
			heroAuraContacts[i].applyImpulse(distance, bodyPos);
		}
		Timer.delay(function() watcher = " ", 1000);
	}
	
	public function goBackToHeroBody():Void {
		controlledBody = heroBody;
		setSoulPosition(controlledBody.getPosition());
	}
	
	public function getVictimsLeft():Int
	{
		return victimsTotal - victimsKilled - victimsSaved;
	}
	
	public function getVictimsKiled():Int
	{
		return victimsKilled;
	}
	
	public function getVictimsSaved():Int
	{
		return victimsSaved;
	}
	
	public function getTimeSpent():Int
	{
		return Math.floor(Timer.stamp() - startTime);
	}
	
	public function getPixelPerMeter ():Float {
		return PIXEL_PER_METER;
	}

	public function getHeroPos ():B2Vec2 {
		return controlledBody.getPosition().copy();
	}

	public function getSoulPos ():B2Vec2 {
		return heroSoul.getPosition().copy();
	}

	public function setSoulPosition (point:B2Vec2):Void {
		heroSoul.setPosition(point);
	}
	
	public function setSoulMove (force:B2Vec2):Void {
		heroSoul.applyForce(force, getHeroPos());
	}
	
	public function getSoulVelocity():B2Vec2 {
		return heroSoul.getLinearVelocity().copy();
	}

	public function setHeroVelocity(velocity:B2Vec2):Void {
		controlledBody.setAwake(true);
		controlledBody.setLinearVelocity(velocity);
	}

	public function clearHeroVelocity ():Void {
		heroSoul.setLinearVelocity(new B2Vec2(0, 0));
	}
	
	public function setDrawingState (pIsDebugDrawing:Bool):Void {
		isDebugDrawing = pIsDebugDrawing;
		this.PhysicsDebug.visible = isDebugDrawing;
	}
	
	public function pushDestroyList(pBody:B2Body):Void {
		destroyList.push(pBody);
	}
	
	public function pushHeroAuraContacts(pBody:B2Body):Void {
		heroAuraContacts.push(pBody);
	}
	
	public function removeHeroAuraContacts(pBody:B2Body):Void {
		heroAuraContacts.remove(pBody);
	}
		
	private function JSONLoaded(e:Event):Void {
		//parse vers JSONOBject
		var JSONData:String = new String(e.target.data);
		var JSONObject:Dynamic = Json.parse(JSONData);
		
		if (stage != null) stage.frameRate = JSONObject.stepsPerSecond;
		
		//configure le world mais toute les propriétés du json ne sont pas récupèrées
		world.setContinuousPhysics(JSONObject.continuousPhysics);
		world.setWarmStarting(JSONObject.warmStarting);
		veloctityIterations = JSONObject.velocityIterations;
		positionIterations = JSONObject.positionIterations;

		if (JSONObject.gravity != 0)
			world.setGravity(new B2Vec2(JSONObject.gravity.x, -JSONObject.gravity.y));
		
		if (JSONObject.body != null && JSONObject.body != 0) {
			for (i in 0...JSONObject.body.length) {
				//bodyDef
				var bodyDef:JsonBodyDef = new JsonBodyDef(JSONObject.body[i]);
				
				var body:B2Body;

				if (bodyDef.userData.name == "HeroBody") {
					body = world.createBody(bodyDef);
					heroBody = body;
					controlledBody = heroBody;
				} else if (bodyDef.userData.name == "HeroSoul") {
					body = world.createBody(bodyDef);
					heroSoul = body;
				} else if (bodyDef.userData.name == "Victim") {
					addChild(bodyDef.userData.directionArrow);
					body = world.createBody(bodyDef);
					victimsTotal++;
				} else body = world.createBody(bodyDef);
				
				//fixtureDef
				//les catégories de collisions sont défini ici par le json
				var j:Int = 0;
				while (JSONObject.body[i].fixture[j] != null) {
					var myJsonFixtureDef:JsonFixtureDef = new JsonFixtureDef(JSONObject.body[i].fixture[j]);
					body.createFixture(myJsonFixtureDef);
					j++;
				}
				
				bodies.push(body);
			}
		}
		
		//jointDef
		if (JSONObject.joint != null && JSONObject.joint != 0) {
			for ( i in 0...JSONObject.joint.length) {
				var jointObject:Dynamic = JSONObject.joint[i];
				if (jointObject.type == "weld"){
					var jointDef:B2WeldJointDef = new B2WeldJointDef();
					jointDef.bodyA = bodies[jointObject.bodyA];
					jointDef.bodyB = bodies[jointObject.bodyB];
					jointDef.localAnchorA = new B2Vec2(jointObject.anchorA.x, -jointObject.anchorA.y);
					jointDef.localAnchorB = new B2Vec2(jointObject.anchorB.x, -jointObject.anchorB.y);
					jointDef.referenceAngle = -jointObject.refAngle;
					world.createJoint(jointDef);
				}
				if (jointObject.type == "revolute"){
					var jointDef:JsonRevoluteJointDef = new JsonRevoluteJointDef(jointObject, bodies[jointObject.bodyA], bodies[jointObject.bodyB]);
					world.createJoint(jointDef);				}
			}
		}
		//chargement des textures
		if (JSONObject.image != null && JSONObject.image != 0) {
			for (i in 0...JSONObject.image.length) {
				//Rube associe les objets de textures ("image") aux body
				var bodyNumber = JSONObject.image[i].body;
				if (bodyNumber == -1) continue;
				var imageObject:Dynamic = JSONObject.image[i];
				
				//j'associe ensuite les images aux fixtures (polygonShape->rectangulaires uniquement) par leur noms
				var fixture:B2Fixture = bodies[bodyNumber].getFixtureList();
				while (fixture != null) {
					if (fixture.getUserData().name == imageObject.name) {
						break;
					} else fixture = fixture.getNext();
				}
				if (fixture == null) continue;
				
				var fixtureSprite:Sprite = new Sprite ();
				var bitty:Bitmap = new Bitmap (Assets.getBitmapData (imageObject.file));
				bitty.alpha = imageObject.opacity;

				if (imageObject.opacity < 1) bitty.blendMode = BlendMode.NORMAL;
				
				fixtureSprite.addChild (bitty);
				
				var polyShape:B2PolygonShape = cast (fixture.getShape(), B2PolygonShape);
				var poly:Array<B2Vec2> = polyShape.getVertices();
				
				//Log.trace(fixture.getUserData().name);
				//dimensionne les textures à la taille de la fixture
				fixtureSprite.transform.matrix = new Matrix(poly[0].x * (PIXEL_PER_METER / bitty.width*2), 0, 0,  -poly[0].y * (PIXEL_PER_METER / bitty.height*2), poly[2].x * PIXEL_PER_METER, -poly[2].y * PIXEL_PER_METER);
				addChild (fixtureSprite);
				
				//les textures sont contenue dans les fixtures
				var fixtureData:FixtureData = fixture.getUserData();
				fixtureData.offset = fixtureSprite.transform.matrix;
				fixtureData.sprite = fixtureSprite;
				fixture.SetUserData(fixtureData);
			}
		}
		okToRun = true;
	}
}