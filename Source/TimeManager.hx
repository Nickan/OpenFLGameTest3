package;
import openfl.Lib;

/**
 * ...
 * @author Nickan
 */
class TimeManager
{
	static var _instance :TimeManager;
	public var delta(default, null) :Float = 0;
	var _lastTime :Float = 0;
	
	function new() { }
	
	/**
	 * Should be called every frame
	 */
	public function update() 
	{
		delta = (Lib.getTimer() - _lastTime) * 0.001;
		_lastTime = Lib.getTimer();
	}
	
	public static function getInstance()
	{
		if (_instance == null)
			_instance = new TimeManager();
		return _instance;
	}
	
}