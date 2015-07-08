package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Nickan
 */
class SnakeController extends Sprite
{
	var _snake :Snake;
	
	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
	}
	
	private function onRemoved(e:Event):Void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
		_snake = Std.instance(parent, Snake);
	}
	
	private function onKeyDown(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Keyboard.UP)
			_snake.moveUp();
			
		if (e.keyCode == Keyboard.DOWN)
			_snake.moveDown();
			
		if (e.keyCode == Keyboard.LEFT)
			_snake.moveLeft();
			
		if (e.keyCode == Keyboard.RIGHT)
			_snake.moveRight();
		
	}
	
}