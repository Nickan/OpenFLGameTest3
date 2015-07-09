package event;
import openfl.events.Event;

/**
 * ...
 * @author Nickan
 */
class TitleScreenEvent extends Event
{
	public static inline var TITLE_SCREEN :String = "titleScreen";
	
	public function new(type :String, bubbles :Bool = false, cancelable :Bool = false) 
	{
		super(type, bubbles, cancelable);
	}
	
}