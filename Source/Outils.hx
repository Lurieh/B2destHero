package ;
import box2D.collision.shapes.B2CircleShape;
import box2D.common.math.B2Transform;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import flash.display.Sprite;
import flash.geom.Matrix;
import flash.geom.Rectangle;

/**
 * ...
 * @author Mathieu Foucat
*/
class Outils
{

	public function new() 
	{
		
	}
	
	static public function lerpVector(pStart:B2Vec2, pEnd:B2Vec2, pPercentTravelPerIteration:Float):B2Vec2
	{
		var start:B2Vec2 = pStart.copy();
		var percentTravelPerIteration:Float = pPercentTravelPerIteration;
		var distance:B2Vec2 = pEnd.copy();
		
		distance.subtract(start);
		distance.multiply(percentTravelPerIteration);
		distance.add(start);
		return distance;
	}
	
	static public function lerpFloat(pStart:Float, pEnd:Float, pPercentTravelPerIteration:Float):Float
	{
		var start:Float = pStart;
		var percentTravelPerIteration:Float = pPercentTravelPerIteration;
		var distance:Float = pEnd;
		
		distance -= start;
		distance *= percentTravelPerIteration;
		distance += start;
		return distance;
	}
	
	//applique une matrice B2D sur une matrice Sprite
	static public function applyB2DTransformToSprite(bodyTransform:B2Transform, fixtureData:FixtureData, pixelPerMeter:Float,  horizontalMirror:Int=1):Void
	{
		fixtureData.sprite.transform.matrix = new Matrix (bodyTransform.R.col1.x, bodyTransform.R.col1.y, bodyTransform.R.col2.x, bodyTransform.R.col2.y, bodyTransform.position.x * pixelPerMeter, bodyTransform.position.y * pixelPerMeter);
	
		var offsetMatrix:Matrix = fixtureData.offset.clone();
		var rotatedOffset:B2Vec2 = Outils.rotateVector(new B2Vec2(offsetMatrix.tx * horizontalMirror, offsetMatrix.ty), bodyTransform.getAngle());
		offsetMatrix.concat(fixtureData.sprite.transform.matrix);
		
		fixtureData.sprite.transform.matrix = new Matrix(offsetMatrix.a, offsetMatrix.b, offsetMatrix.c, offsetMatrix.d, -rotatedOffset.x + fixtureData.sprite.x, -rotatedOffset.y + fixtureData.sprite.y);
	}
	
	//pivote le vecteur autour de l'origine
	static public function rotateVector(vectorToRotate:B2Vec2, radians:Float):B2Vec2
	{
		var cs:Float = Math.cos(radians);
		var sn:Float = Math.sin(radians);

		var px:Float = vectorToRotate.x * cs - vectorToRotate.y * sn;
		var py:Float = vectorToRotate.x * sn + vectorToRotate.y * cs;
		
		return new B2Vec2(-px, -py);
	}
	
	static public function getIfNotNull(internalProperty:Dynamic, externalProperty:Dynamic):Dynamic {
		if (externalProperty != null) {
			return externalProperty;
		}else return internalProperty;
	}
	
	static public function getVectorIfNotNull(internalProperty:B2Vec2, externalProperty:Dynamic):Dynamic {
		if (externalProperty != null && externalProperty != 0) {
			return new B2Vec2(externalProperty.x, -externalProperty.y);
		}else return internalProperty;
	}

	static public function createCircle (pos:B2Vec2, radius:Float, world:B2World):B2Body {
		
		var bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (pos.x,	pos.y);
		bodyDefinition.fixedRotation = false;
		
		bodyDefinition.type = B2Body.b2_dynamicBody;
		
		var circle = new B2CircleShape (radius);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = circle;
		fixtureDefinition.friction = 1;
		fixtureDefinition.density = 10;
		
		var body:B2Body = world.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		return body;
	}
}