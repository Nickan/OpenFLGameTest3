package event;
import openfl.events.Event;

/**
 * ...
 * @author Nickan
 */
class GameOverEvent extends Event
{
	public static inline var GAME_OVER :String = "Game over";
	public var score(default, null) :Int;
	
	public function new(type :String, bubbles :Bool = false, cancelable :Bool = false, score :Int) 
	{
		super(type, bubbles, cancelable);
		this.score = score;
	}
	
}