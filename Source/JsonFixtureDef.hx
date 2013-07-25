package ;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.collision.shapes.B2Shape;
import box2D.dynamics.B2FilterData;
import box2D.dynamics.B2FixtureDef;
import box2D.common.math.B2Vec2;

/**
 * ...
 * @author Mathieu Foucat
*/
class JsonFixtureDef extends B2FixtureDef
{
	public function new(jsonFixtureObject:Dynamic) 
	{
		super ();
		
		friction =  Outils.getIfNotNull(friction, jsonFixtureObject.friction);
		restitution =  Outils.getIfNotNull(restitution, jsonFixtureObject.restitution);
		density =  Outils.getIfNotNull(density, jsonFixtureObject.density);
		filter.categoryBits =  Outils.getIfNotNull(filter.categoryBits, jsonFixtureObject.filterCategoryBits);
		filter.maskBits =  Outils.getIfNotNull(filter.maskBits, jsonFixtureObject.filterMaskBits);
		isSensor =  Outils.getIfNotNull(isSensor, jsonFixtureObject.sensor);
		userData =  Outils.getIfNotNull(userData, new FixtureData(jsonFixtureObject.name));
		lookForShape(jsonFixtureObject);

		//groupIndex =  Outils.getIfNotNull(filter.groupIndex, jsonFixtureObject);
	}
		
	private function lookForShape(jsonFixtureObject:Dynamic):Void {
			if (jsonFixtureObject.polygon != null) {
				var verticesX:Array<Float> = jsonFixtureObject.polygon.vertices.x;
				var verticesY:Array<Float> = jsonFixtureObject.polygon.vertices.y;
				var points:Array<B2Vec2> = new Array<B2Vec2>();
				var j:Int;
				
				//TODO les polygones sont chargés avec le Y mal signé mais le rendre négatif met les normales à l'envers?
				for (j in 0...verticesX.length) {
					points.push(new B2Vec2(verticesX[j], verticesY[j]));
				}
				j = verticesX.length;
				var polygonShape:B2PolygonShape=new B2PolygonShape();
				polygonShape.setAsVector(points,j);
				shape = polygonShape;
				
			} else if (jsonFixtureObject.circle != null) {
				//TODO propriété "center" du json ignoré
				shape = new B2CircleShape (jsonFixtureObject.circle.radius);
			}
	}
}