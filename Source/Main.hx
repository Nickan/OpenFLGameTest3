package;


import event.GameOverEvent;
import event.StartGameEvent;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;


class Main extends Sprite {
	
	var _gameScreen:GameScreen;
	var _gameOverScreen:GameOverScreen;

	public function new () {
		
		super ();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.ENTER_FRAME, onUpdate);
	}
	
	private function onUpdate(e:Event):Void 
	{
		TimeManager.getInstance().update();
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		setupGameScreen();
	}
	
	function setupGameScreen()
	{
		_gameScreen = new GameScreen();
		addChild(_gameScreen);
		_gameScreen.addEventListener(GameOverEvent.GAME_OVER, onGameOver);
	}

	function showGameOverScreen(playerScore:Int) 
	{
		_gameOverScreen = new GameOverScreen(playerScore);
		addChild(_gameOverScreen);
		_gameOverScreen.addEventListener(StartGameEvent.START_GAME, onStartGame);
	}

	// ================================================ EVENT ================================================== //
	private function onStartGame(e:StartGameEvent):Void 
	{
		disposeGameOverScreen();
		setupGameScreen();
	}
	
	private function onGameOver(e:GameOverEvent):Void 
	{
		disposeGameScreen();
		showGameOverScreen(e.score);
	}
	
	// ================================================ HELPER ================================================== //
	private function disposeGameScreen()
	{
		_gameScreen.removeEventListener(GameOverEvent.GAME_OVER, onGameOver);
		removeChild(_gameScreen);
		_gameScreen = null;
	}
	
	function disposeGameOverScreen()
	{
		_gameOverScreen.removeEventListener(StartGameEvent.START_GAME, onStartGame);
		removeChild(_gameOverScreen);
		_gameOverScreen = null;
	}
	
	
}