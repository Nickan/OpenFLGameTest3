package;
import event.LevelManagerEvent;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Nickan
 */
class LevelManager extends Sprite
{
	static inline var LEVEL_CHANGE_INTERVAL :Float = 15;
	static inline var MAX_LEVEL :Int = 3;
	var _levelChangeTimer :Float = 0;
	var _level :Int = 1;
	var _difficulty :String;
	
	public function new(difficulty :String) 
	{
		super();
		_difficulty = difficulty;
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		//addEventListener(Event.ENTER_FRAME, onUpdate);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		switch (_difficulty) {
			case "Easy": dispatchEvent(new LevelManagerEvent(LevelManagerEvent.CHANGE_LEVEL, false, false, 1));
			case "Normal": dispatchEvent(new LevelManagerEvent(LevelManagerEvent.CHANGE_LEVEL, false, false, 2));
			case "Hard": dispatchEvent(new LevelManagerEvent(LevelManagerEvent.CHANGE_LEVEL, false, false, 3));
			default:
		}
	}
	
	private function onUpdate(e:Event):Void 
	{
		//_levelChangeTimer += TimeManager.getInstance().delta;
		//
		//if (_level >= MAX_LEVEL)
			//return;
		//
		//if (_levelChangeTimer > LEVEL_CHANGE_INTERVAL) {
			//_levelChangeTimer -= LEVEL_CHANGE_INTERVAL;
			//dispatchEvent(new LevelManagerEvent(LevelManagerEvent.CHANGE_LEVEL, true, false, ++_level));
		//}
	}
	
}