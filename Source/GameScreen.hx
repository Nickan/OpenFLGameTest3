package;

import event.CollisionEvent;
import event.GameOverEvent;
import event.LevelManagerEvent;
import event.SnakeCollisionEvent;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.net.SharedObject;

/**
 * ...
 * @author Nickan
 */
class GameScreen extends Sprite
{
	var _startingX :Float;
	var _startingY :Float;
	var _snake :Snake;
	var _apple :AppleSprite;
	var _score :Float = 0;
	var _scoreSprite :TextSprite;
	var _levelManager :LevelManager;
	var _levelSprite :TextSprite;
	
	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.ENTER_FRAME, onUpdate);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
	}
	
	private function onRemoved(e:Event):Void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		removeEventListener(Event.ENTER_FRAME, onUpdate);
		_levelManager.removeEventListener(LevelManagerEvent.CHANGE_LEVEL, onLevelChanged);
		_apple.removeEventListener(CollisionEvent.COLLIDES_WITH_APPLE, _snake.onAppleCollision);
		_apple.removeEventListener(CollisionEvent.COLLIDES_WITH_APPLE, onAppleCollision);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		_startingX = stage.stageWidth * 0.2;
		_startingY = stage.stageHeight * 0.2;
		
		setupLevelManager();
		setupBackground();
		setupSnake();
		setupApples();
		setupScoreSprite();
		setupLevelSprite();
	}
	
	function setupBackground() 
	{
		var bg = new BackgroundSprite(0xFFFFFF, 400, 400);
		bg.x = _startingX;
		bg.y = _startingY;
		addChild(bg);
	}
	
	function setupSnake() 
	{
		_snake = new Snake();
		_snake.x = _startingX;
		_snake.y = _startingY;
		addChild(_snake);
		
		_snake.addEventListener(SnakeCollisionEvent.SNAKE_COLLISION, onSnakeCollision);
	}
	
	function setupApples() 
	{
		_apple = new AppleSprite(_snake);
		_apple.x = _startingX;
		_apple.y = _startingY;
		addChild(_apple);
		
		_apple.addEventListener(CollisionEvent.COLLIDES_WITH_APPLE, _snake.onAppleCollision);
		_apple.addEventListener(CollisionEvent.COLLIDES_WITH_APPLE, onAppleCollision);
	}
	
	function setupScoreSprite() 
	{
		_scoreSprite = new TextSprite();
		_scoreSprite.x = _startingX + stage.stageWidth * 0.13;
		_scoreSprite.y = _startingY;
		addChild(_scoreSprite);
	}
	
	function setupLevelManager() 
	{
		_levelManager = new LevelManager();
		_levelManager.addEventListener(LevelManagerEvent.CHANGE_LEVEL, onLevelChanged);
	}
	
	function setupLevelSprite() 
	{
		_levelSprite = new TextSprite();
		_levelSprite.x = _startingX;
		_levelSprite.y = _startingY;
		addChild(_levelSprite);
		_levelSprite.showText("Level: " + 1);
	}
	
	// ================================================ UPDATE ================================================== //
	private function onUpdate(e:Event):Void 
	{
		var delta = TimeManager.getInstance().delta;
		_score += delta;
		_scoreSprite.showText("Score: " + Std.int(_score));
	}
	
	// ================================================ EVENT ================================================== //
	private function onAppleCollision(e:CollisionEvent):Void 
	{
		///...
	}
	
	private function onLevelChanged(e:LevelManagerEvent):Void 
	{
		_levelSprite.showText("Level: " + e.level);
		_snake.currentLevel = e.level;
	}
	
	private function onSnakeCollision(e:SnakeCollisionEvent):Void 
	{
		dispatchEvent(new GameOverEvent(GameOverEvent.GAME_OVER, false, false, Std.int(_score)));
	}
	
}