package;
import event.CollisionEvent;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;

/**
 * ...
 * @author Nickan
 */
class AppleSprite extends Sprite
{
	var _snake :Snake;
	var _apple :Bitmap;
	var _hiddenApplePointer :Bitmap;
	
	public function new(snake :Snake) 
	{
		super();
		_snake = snake;
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.ENTER_FRAME, onUpdate);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		respawnApple();
	}
	
	function spawnAppleAt(x :Int, y :Int) 
	{
		if (_apple == null) {
			_apple = new Bitmap(Assets.getBitmapData("assets/apple.png"));
			_hiddenApplePointer = _apple;
			_apple.x = x * _snake.getHead().width;
			_apple.y = y * _snake.getHead().height;
			_apple.width = _snake.getHead().width;
			_apple.height = _snake.getHead().height;
		} else {
			_apple = _hiddenApplePointer;
		}
		addChild(_apple);
	}
	
	
	private function onUpdate(e:Event):Void 
	{
		if (_apple == null)
			return;
			
		var snakeHeadBounds = _snake.getHead().getBounds(this);
		var appleBounds = _apple.getBounds(this);
		if (snakeHeadBounds.intersects(appleBounds)) {
			dispatchEvent(new CollisionEvent(CollisionEvent.COLLIDES_WITH_APPLE));
			removeChild(_apple);
			_apple = null;
			respawnApple();
		}
	}
	
	// ================================================ HELPER ================================================== //
	function respawnApple() 
	{
		while (true) {
			var randX = Random.int(0, 9);
			var randY = Random.int(0, 9);
			if (!_snake.containsCoordinate(randX, randY)) {
				spawnAppleAt(randX, randY);
				break;
			}
		}
		
	}
	
}