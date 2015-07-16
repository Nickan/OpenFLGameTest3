package screen;
import event.LevelManagerEvent;
import event.StartGameEvent;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.net.SharedObject;

/**
 * ...
 * @author Nickan
 */
class TitleScreen extends Sprite
{
	var _unitX :Float;
	var _unitY :Float;
	var _gameTitle :TextSprite;
	var _highScoreText :TextSprite;
	var _buttons :Array<TextButton>;
	
	public function new() 
	{
		super();
		_buttons = [];
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
	}

	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		setupUnits();
		setupBackground();
		setupGameTitleText();
		setupHighScoreText();
		setupTextButton("Easy", _unitX * 1, _unitY * 5.5);
		setupTextButton("Normal", _unitX * 1, _unitY * 6.5);
		setupTextButton("Hard", _unitX * 1, _unitY * 7.5);
	}

	function setupTextButton(text :String, x :Float, y :Float) 
	{
		var normalBitmap = Assets.getBitmapData("assets/button/button_normal.png");
		var overBitmap = Assets.getBitmapData("assets/button/button_over.png");
		var pressedBitmap = Assets.getBitmapData("assets/button/button_pressed.png");
		
		var textButton = new TextButton(text, new Bitmap(normalBitmap), new Bitmap(overBitmap), 
											new Bitmap(pressedBitmap), new Bitmap(overBitmap), onButtonDown, text);
		addChild(textButton);
		textButton.x = x;
		textButton.y = y;
		_buttons.push(textButton);
	}
	
	function onButtonDown(buttonText :String) 
	{
		dispatchEvent(new StartGameEvent(StartGameEvent.START_GAME, false, false, buttonText));
		for (button in _buttons) 
			button.dispose();
	}
	

	function setupUnits() 
	{
		_unitX = 40;
		_unitY = 40;
	}
	
	function setupBackground() 
	{
		var bg = new BackgroundSprite(0xFFFFFF, _unitX * 10, _unitY * 10);
		addChild(bg);
	}
	
	function setupGameTitleText() 
	{
		_gameTitle = new TextSprite();
		addChild(_gameTitle);
		_gameTitle.showText("Snake Clone");
		_gameTitle.x = stage.stageWidth * 0.5 - (_gameTitle.width * 0.5);
		_gameTitle.y = _unitY * 2;
		
	}
	
	function setupHighScoreText() 
	{
		_highScoreText = new TextSprite();
		addChild(_highScoreText);
		var highScore = SharedObject.getLocal("high_score");
		if (highScore.data.high_score != null)
			_highScoreText.showText("High score: " + highScore.data.high_score);
		else
			_highScoreText.showText("High score: " + 0);
		
		_highScoreText.x = stage.stageWidth * 0.5 - (_highScoreText.width * 0.5);
		_highScoreText.y = _unitY * 4;
	}
	
}