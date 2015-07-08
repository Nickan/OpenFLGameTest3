package;
import event.StartGameEvent;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.net.SharedObject;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Nickan
 */
class GameOverScreen extends Sprite
{
	var _startingX :Float;
	var _startingY :Float;
	var _gameOverText :TextSprite;
	var _score :Int;
	var _savedHighScore :Int;
	var _savedHighScoreSprite :TextSprite;

	public function new(score :Int) 
	{
		super();
		_score = score;
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.ENTER_FRAME, onUpdate);
		addEventListener(MouseEvent.CLICK, onMouseClicked);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
	}

	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
		_startingX = stage.stageWidth * 0.2;
		_startingY = stage.stageHeight * 0.2;
		
		setupBackground();
		setupSavedHighScore();
		setupGameOverText();
	}

	function setupBackground() 
	{
		var bg = new BackgroundSprite(0xFFFFFF, 400, 400);
		bg.x = _startingX;
		bg.y = _startingY;
		addChild(bg);
	}
	
	function setupSavedHighScore() 
	{
		_savedHighScoreSprite = new TextSprite();
		_savedHighScoreSprite.x = _startingX + stage.stageWidth * 0.03;
		_savedHighScoreSprite.y = _startingY;
		addChild(_savedHighScoreSprite);
		
		var highScore = SharedObject.getLocal("high_score");
		if (highScore.data.high_score != null)
			_savedHighScore = highScore.data.high_score;
		else
			_savedHighScore = 0;
		_savedHighScoreSprite.showText("High Score: " + _savedHighScore);
		
		if (_score > _savedHighScore) {
			highScore.data.high_score = _score;
			highScore.flush();
		}
	}
	
	function setupGameOverText() 
	{
		_gameOverText = new TextSprite();
		_gameOverText.x = _startingX + stage.stageWidth * 0.03;
		_gameOverText.y = _startingY + stage.stageHeight * 0.2;
		addChild(_gameOverText);
		if (_score > _savedHighScore)
			_gameOverText.showText("New High Score: " + _score);
		else
			_gameOverText.showText("Your Score: " + _score);
	}
	
	// ================================================ UPDATE ================================================== //
	private function onUpdate(e:Event):Void 
	{
		
	}
	
	// ================================================ CONTROL EVENT ================================================== //
	private function onMouseClicked(e:MouseEvent):Void 
	{
		removeEventListener(MouseEvent.CLICK, onMouseClicked);
		dispatchEvent(new StartGameEvent(StartGameEvent.START_GAME));
	}
	
	private function onKeyboardDown(e:KeyboardEvent):Void 
	{
		if (e.keyCode == Keyboard.R) {
			removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
			var highScore = SharedObject.getLocal("high_score");
			if (highScore.data.high_score != null) {
				highScore.data.high_score = 0;
				highScore.flush();
			}
			
			dispatchEvent(new StartGameEvent(StartGameEvent.START_GAME));
		}
	}
	
	private function onRemoved(e:Event):Void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
	}
}