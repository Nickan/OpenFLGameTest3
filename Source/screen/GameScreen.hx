package screen;

import event.CollisionEvent;
import event.GameOverEvent;
import event.LevelManagerEvent;
import event.SnakeCollisionEvent;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.net.SharedObject;

/**
 * ...
 * @author Nickan
 */
class GameScreen extends Sprite
{
	var _snake :Snake;
	var _apple :AppleSprite;
	var _score :Int = 0;
	var _scoreSprite :TextSprite;
	var _levelManager :LevelManager;
	var _levelSprite :TextSprite;
	var _difficulty :String;
	
	public function new(difficulty :String) 
	{
		super();
		_difficulty = difficulty;
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.ENTER_FRAME, onUpdate);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		addEventListener(Event.ACTIVATE, onActivated);
		addEventListener(Event.DEACTIVATE, onDeactivated);
	}
	
	private function onActivated(e:Event):Void 
	{
		//...
		trace("Activate: " + Lib.getTimer());
		TimeManager.getInstance().pause = false;
	}
	
	private function onDeactivated(e:Event):Void 
	{
		//...
		trace("Deactivate: " + Lib.getTimer());
		TimeManager.getInstance().pause = true;
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
		
		//setupBackground();
		setupSnake();
		setupApples();
		setupScoreSprite();
		setupLevelSprite();
		setupLevelManager();
		
	}
	
	function setupBackground() 
	{
		var bg = new BackgroundSprite(0xFFFFFF, 400, 400);
		addChild(bg);
	}
	
	function setupSnake() 
	{
		_snake = new Snake();
		addChild(_snake);
		
		_snake.addEventListener(SnakeCollisionEvent.SNAKE_COLLISION, onSnakeCollision);
	}
	
	function setupApples() 
	{
		_apple = new AppleSprite(_snake);
		addChild(_apple);
		
		_apple.addEventListener(CollisionEvent.COLLIDES_WITH_APPLE, _snake.onAppleCollision);
		_apple.addEventListener(CollisionEvent.COLLIDES_WITH_APPLE, onAppleCollision);
	}
	
	function setupScoreSprite() 
	{
		_scoreSprite = new TextSprite();
		addChild(_scoreSprite);
		_scoreSprite.showText("Score: " + _score);
		_scoreSprite.x = stage.stageWidth * 0.5 - (_scoreSprite.width * 0.5);
	}
	
	function setupLevelManager() 
	{
		_levelManager = new LevelManager(_difficulty);
		_levelManager.addEventListener(LevelManagerEvent.CHANGE_LEVEL, onLevelChanged);
		addChild(_levelManager);
		
	}
	
	function setupLevelSprite() 
	{
		_levelSprite = new TextSprite();
		addChild(_levelSprite);
		_levelSprite.showText("Level: " + 1);
		
		_levelSprite.x = stage.stageWidth * 0.5 - (_levelSprite.width * 0.5);
		_levelSprite.y = _snake.getHead().height * 8.5;
	}
	
	// ================================================ UPDATE ================================================== //
	private function onUpdate(e:Event):Void 
	{
		var delta = TimeManager.getInstance().delta;
		//_score += delta;
		
	}
	
	// ================================================ EVENT ================================================== //
	private function onAppleCollision(e:CollisionEvent):Void 
	{
		_scoreSprite.showText("Score: " + Std.int(++_score));
	}
	
	private function onLevelChanged(e:LevelManagerEvent):Void 
	{
		var difficultySetting = "";
		switch (e.level) {
			case 1: difficultySetting = "Easy";
			case 2: difficultySetting = "Normal";
			case 3: difficultySetting = "Hard";
			default: difficultySetting = "Error";
		}
		_levelSprite.showText("Difficulty: " + difficultySetting);
		_levelSprite.x = stage.stageWidth * 0.5 - (_levelSprite.width * 0.5);
		_snake.currentLevel = e.level;
	}
	
	private function onSnakeCollision(e:SnakeCollisionEvent):Void 
	{
		dispatchEvent(new GameOverEvent(GameOverEvent.GAME_OVER, false, false, Std.int(_score)));
	}
	
}