package screen;
import event.StartGameEvent;
import event.TitleScreenEvent;
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
		setupBackground();
		setupSavedHighScore();
		setupGameOverText();
	}

	function setupBackground() 
	{
		var bg = new BackgroundSprite(0xFFFFFF, 400, 400);
		addChild(bg);
	}
	
	function setupSavedHighScore() 
	{
		_savedHighScoreSprite = new TextSprite();
		addChild(_savedHighScoreSprite);
		
		var highScore = SharedObject.getLocal("high_score");
		if (highScore.data.high_score != null)
			_savedHighScore = highScore.data.high_score;
		else
			_savedHighScore = 0;
		_savedHighScoreSprite.showText("High Score: " + _savedHighScore);
		
		_savedHighScoreSprite.x = stage.stageWidth * 0.5 - (_savedHighScoreSprite.width * 0.5);
		_savedHighScoreSprite.y = stage.stageHeight * 0.25;
		
		if (_score > _savedHighScore) {
			highScore.data.high_score = _score;
			highScore.flush();
		}
	}
	
	function setupGameOverText() 
	{
		_gameOverText = new TextSprite();
		addChild(_gameOverText);
		if (_score > _savedHighScore)
			_gameOverText.showText("New High Score: " + _score);
		else
			_gameOverText.showText("Your Score: " + _score);
			
		_gameOverText.x = stage.stageWidth * 0.5 - (_gameOverText.width * 0.5);
		_gameOverText.y = stage.stageHeight * 0.55;
	}
	
	// ================================================ UPDATE ================================================== //
	private function onUpdate(e:Event):Void 
	{
		
	}
	
	// ================================================ CONTROL EVENT ================================================== //
	private function onMouseClicked(e:MouseEvent):Void 
	{
		removeEventListener(MouseEvent.CLICK, onMouseClicked);
		dispatchEvent(new TitleScreenEvent(TitleScreenEvent.TITLE_SCREEN));
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
			
			dispatchEvent(new TitleScreenEvent(TitleScreenEvent.TITLE_SCREEN));
		}
	}
	
	private function onRemoved(e:Event):Void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyboardDown);
	}
}