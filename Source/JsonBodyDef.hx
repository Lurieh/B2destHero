package ;
import box2D.dynamics.B2BodyDef;
import box2D.common.math.B2Vec2;

/**
 * ...
 * @author Mathieu Foucat
*/
class JsonBodyDef extends B2BodyDef
{
	public function new (JsonBodyObject)
	{
		super();
		
		position = Outils.getVectorIfNotNull(position, JsonBodyObject.position);
		linearVelocity =  Outils.getVectorIfNotNull(linearVelocity, JsonBodyObject.linearVelocity);
		angle = - Outils.getIfNotNull(angle, JsonBodyObject.angle);
		angularVelocity =  Outils.getIfNotNull(angularVelocity, JsonBodyObject.angularVelocity);
		linearDamping =  Outils.getIfNotNull(linearDamping, JsonBodyObject.linearDamping);
		angularDamping =  Outils.getIfNotNull(angularDamping, JsonBodyObject.angularDamping);
		allowSleep =  Outils.getIfNotNull(allowSleep, JsonBodyObject.allowSleep);
		awake =  Outils.getIfNotNull(awake, JsonBodyObject.awake);
		fixedRotation =  Outils.getIfNotNull(fixedRotation, JsonBodyObject.fixedRotation);
		bullet =  Outils.getIfNotNull(bullet, JsonBodyObject.bullet);
		type =  Outils.getIfNotNull(type, JsonBodyObject.type);
		active =  Outils.getIfNotNull(active, JsonBodyObject.active);
		inertiaScale =  Outils.getIfNotNull(inertiaScale, JsonBodyObject.gravityScale);
		if (JsonBodyObject.name == "Victim") {
			userData = new VictimData(Outils.getIfNotNull(userData, JsonBodyObject.name));
		} else userData = new BodyData(Outils.getIfNotNull(userData, JsonBodyObject.name));
	}
}