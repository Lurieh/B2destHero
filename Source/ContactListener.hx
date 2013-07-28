package ;

import box2D.dynamics.B2ContactListener;
import box2D.collision.B2Manifold;
import box2D.dynamics.contacts.B2Contact;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2World;

/**
 * ...
 * @author Mathieu Foucat
*/
class ContactListener extends B2ContactListener
{
	public var gameWorld:GameWorld;
	
	public function new(pGameWorld:GameWorld) 
	{
		gameWorld = pGameWorld;
		super ();
	}
	
	override public function beginContact(contact:B2Contact):Void 
	{
		var FixtureA:B2Fixture;
		var FixtureB:B2Fixture;
		FixtureA = contact.getFixtureA();
		FixtureB = contact.getFixtureB();
		
		//si un corps dynamique "dangereux" collisionne une victime elle se fait destroy
		if (FixtureA.getUserData().name == "Victim" && FixtureB.getUserData().name != "GroundStatic" && FixtureB.getUserData().name != "HeroAura" && FixtureB.getUserData().name != "Slab") {
			gameWorld.pushDestroyList(FixtureA.getBody());
		}
		if (FixtureB.getUserData().name == "Victim" && FixtureA.getUserData().name != "GroundStatic" && FixtureA.getUserData().name != "HeroAura" && FixtureA.getUserData().name != "Slab") {
			gameWorld.pushDestroyList(FixtureB.getBody());
		}
		
		//comptabilise quand une victime voit un danger
		if (FixtureA.getUserData().name == "VictimSight") {
			FixtureA.getBody().getUserData().scareyBodies.push(FixtureB.getBody());
			//gameWorld.watcher = "+A : " + cast(FixtureA.getBody().getUserData().scareyBodies.length);
		}
		if (FixtureB.getUserData().name == "VictimSight") {
			FixtureB.getBody().getUserData().scareyBodies.push(FixtureA.getBody());
			//gameWorld.watcher = "+B : " + cast(FixtureB.getBody().getUserData().scareyBodies.length);
		}
		
		//on compte les corps dynamiques qui entre dans l'aura du hero pour les expulser quand le joueur appuie sur le bouton
		if (FixtureA.getUserData().name == "HeroAura") {
			gameWorld.pushHeroAuraContacts(FixtureB.getBody());
		}
		if (FixtureB.getUserData().name == "HeroAura") {
			gameWorld.pushHeroAuraContacts(FixtureA.getBody());
		}
	}
	
	override public function endContact(contact:B2Contact):Void 
	{
		var myFixA:B2Fixture;
		var myFixB:B2Fixture;
		myFixA = contact.getFixtureA();
		myFixB = contact.getFixtureB();
		
		if (myFixA.getUserData().name == "VictimSight") {
			myFixA.getBody().getUserData().scareyBodies.remove(myFixB.getBody());
			//gameWorld.watcher = "-A : " + cast(myFixA.getBody().getUserData().scareyBodies.length);
		}
		if (myFixB.getUserData().name == "VictimSight") {
			myFixB.getBody().getUserData().scareyBodies.remove(myFixA.getBody());
			//gameWorld.watcher = "-B : " + cast(myFixB.getBody().getUserData().scareyBodies.length);
		}
		
		if (myFixA.getUserData().name == "HeroAura") {
			gameWorld.removeHeroAuraContacts(myFixB.getBody());
		}
		if (myFixB.getUserData().name == "HeroAura") {
			gameWorld.removeHeroAuraContacts(myFixA.getBody());
		}
	}
	
}