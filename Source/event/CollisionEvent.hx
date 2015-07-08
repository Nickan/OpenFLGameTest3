package event;
import openfl.events.Event;

/**
 * ...
 * @author Nickan
 */
class CollisionEvent extends Event
{
	public static inline var COLLIDES_WITH_APPLE :String = "apple collision";
	
	public function new(type :String, bubbles :Bool = false, cancelable :Bool = false) 
	{
		super(type, bubbles, cancelable);
	}
	
}