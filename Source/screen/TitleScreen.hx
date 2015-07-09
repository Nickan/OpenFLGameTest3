package screen;
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
	var _startingX :Float;
	var _startingY :Float;
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
		setupStartingPosition();
		setupBackground();
		setupGameTitleText();
		setupHighScoreText();
		setupTextButton("Easy", _startingX + _unitX * 1, _startingY + _unitY * 5.5);
		setupTextButton("Normal", _startingX + _unitX * 1, _startingY + _unitY * 6.5);
		setupTextButton("Hard", _startingX + _unitX * 1, _startingY + _unitY * 7.5);
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
		//for (button in _buttons) 
			//button.dispose();
	}
	

	function setupUnits() 
	{
		_unitX = 40;
		_unitY = 40;
	}
	
	function setupStartingPosition() 
	{
		_startingX = stage.stageWidth * 0.2;
		_startingY = stage.stageHeight * 0.2;
	}
	
	function setupBackground() 
	{
		var bg = new BackgroundSprite(0xFFFFFF, _unitX * 10, _unitY * 10);
		bg.x = _startingX;
		bg.y = _startingY;
		addChild(bg);
	}
	
	function setupGameTitleText() 
	{
		_gameTitle = new TextSprite();
		addChild(_gameTitle);
		_gameTitle.x = _startingX + _unitX * 3;
		_gameTitle.y = _startingY + _unitX * 2;
		_gameTitle.showText("Snake Clone");
	}
	
	function setupHighScoreText() 
	{
		_highScoreText = new TextSprite();
		addChild(_highScoreText);
		_highScoreText.x = _startingX + _unitX * 2;
		_highScoreText.y = _startingY + _unitY * 4;
		
		var highScore = SharedObject.getLocal("high_score");
		if (highScore.data.high_score != null)
			_highScoreText.showText("High score: " + highScore.data.high_score);
		else
			_highScoreText.showText("High score: " + 0);
	}
	
}