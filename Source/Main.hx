package;


import event.GameOverEvent;
import event.LevelManagerEvent;
import event.StartGameEvent;
import event.TitleScreenEvent;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import screen.GameOverScreen;
import screen.GameScreen;
import screen.TitleScreen;


class Main extends Sprite {
	
	var _gameScreen:GameScreen;
	var _gameOverScreen:GameOverScreen;
	var _titleScreen:TitleScreen;

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
		setupTitleScreen();
	}
	
	function setupTitleScreen() 
	{
		_titleScreen = new TitleScreen();
		addChild(_titleScreen);
		_titleScreen.addEventListener(StartGameEvent.START_GAME, onStartGame);
	}
	
	function setupGameScreen(difficulty :String)
	{
		_gameScreen = new GameScreen(difficulty);
		addChild(_gameScreen);
		_gameScreen.addEventListener(GameOverEvent.GAME_OVER, onGameOver);
	}

	function showGameOverScreen(playerScore:Int) 
	{
		_gameOverScreen = new GameOverScreen(playerScore);
		addChild(_gameOverScreen);
		_gameOverScreen.addEventListener(TitleScreenEvent.TITLE_SCREEN, onTitleScreen);
	}

	// ================================================ EVENT ================================================== //
	private function onStartGame(e:StartGameEvent):Void 
	{
		disposeGameOverScreen();
		disposeTitleScreen();
		setupGameScreen(e.difficulty);
	}
	
	private function onGameOver(e:GameOverEvent):Void 
	{
		disposeGameScreen();
		showGameOverScreen(e.score);
	}
	
	private function onTitleScreen(e:TitleScreenEvent):Void 
	{
		disposeGameOverScreen();
		disposeGameScreen();
		setupTitleScreen();
	}
	
	// ================================================ HELPER ================================================== //
	private function disposeGameScreen()
	{
		if (_gameScreen == null)
			return;
		_gameScreen.removeEventListener(GameOverEvent.GAME_OVER, onGameOver);
		removeChild(_gameScreen);
		_gameScreen = null;
	}
	
	function disposeGameOverScreen()
	{
		if (_gameOverScreen == null)
			return;
		_gameOverScreen.removeEventListener(TitleScreenEvent.TITLE_SCREEN, onTitleScreen);
		removeChild(_gameOverScreen);
		_gameOverScreen = null;
	}
	
	
	function disposeTitleScreen() 
	{
		if (_titleScreen == null)
			return;
		_titleScreen.removeEventListener(StartGameEvent.START_GAME, onStartGame);
		removeChild(_titleScreen);
		_titleScreen = null;
	}
	
}