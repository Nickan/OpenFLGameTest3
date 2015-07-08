package event;
import openfl.events.Event;

/**
 * ...
 * @author Nickan
 */
class LevelManagerEvent extends Event
{
	public static inline var CHANGE_LEVEL : String = "change level";
	public var level(default, null) :Int;
	
	public function new(type :String, bubbles :Bool = false, cancelable :Bool = false, level :Int) 
	{
		super(type, bubbles, cancelable);
		this.level = level;
	}
	
}