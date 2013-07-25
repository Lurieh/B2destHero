package ;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.joints.B2RevoluteJointDef;

/**
 * ...
 * @author Mathieu Foucat
*/
class JsonRevoluteJointDef extends B2RevoluteJointDef
{

	public function new(jsonJointObject:Dynamic, pBodyA:B2Body, pBodyB:B2Body) 
	{
		super ();

		bodyA = Outils.getIfNotNull(bodyA, pBodyA);
		bodyB = Outils.getIfNotNull(bodyB, pBodyB);
		localAnchorA = Outils.getVectorIfNotNull(localAnchorA, jsonJointObject.anchorA);
		localAnchorB = Outils.getVectorIfNotNull(localAnchorB, jsonJointObject.anchorB);
		referenceAngle = Outils.getIfNotNull(referenceAngle, -jsonJointObject.refAngle);
		lowerAngle = Outils.getIfNotNull(lowerAngle, -jsonJointObject.lowerLimit);
		upperAngle = Outils.getIfNotNull(upperAngle, -jsonJointObject.upperLimit);
		maxMotorTorque = Outils.getIfNotNull(maxMotorTorque, jsonJointObject.maxMotorTorque);
		motorSpeed = Outils.getIfNotNull(motorSpeed, -jsonJointObject.motorSpeed);
		enableLimit = Outils.getIfNotNull(enableLimit, jsonJointObject.enableLimit);
		enableMotor = Outils.getIfNotNull(enableMotor, jsonJointObject.enableMotor);
		userData = new JointData(jsonJointObject.name);
		
		//collideConnected = false;
	}
	
}