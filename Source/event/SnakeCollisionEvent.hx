package event;
import openfl.events.Event;

/**
 * ...
 * @author Nickan
 */
class SnakeCollisionEvent extends Event
{
	public static inline var SNAKE_COLLISION :String = "snake collision";
	
	public function new(type :String, bubbles :Bool = false, cancelable :Bool = false) 
	{
		super(type, bubbles, cancelable);
	}
	
}