package event;
import openfl.events.Event;

/**
 * ...
 * @author Nickan
 */
class StartGameEvent extends Event
{
	public static inline var START_GAME :String = "start game";
	
	public var difficulty(default, null) :String;
	
	public function new(type :String, bubbles :Bool = false, cancelable :Bool = false, difficulty :String) 
	{
		super(type, bubbles, cancelable);
		this.difficulty = difficulty;
	}
	
}