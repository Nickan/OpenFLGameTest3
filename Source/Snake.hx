package;
import event.CollisionEvent;
import event.SnakeCollisionEvent;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;

/**
 * ...
 * @author Nickan
 */
class Snake extends Sprite
{
	static var DEFAULT_PARTS_NUMBER :Int = 3;
	static var INTERVAL_REDUCTION :Float = 0.4;
	static var DEFAULT_INTERVAL = 1 + INTERVAL_REDUCTION;
	
	public var currentLevel(default, set) :Int;
	
	var _headPosition :Point;
	var _direction :Point;
	var _tailPosition :Point;
	var _updateInterval :Float;
	var _updateTimer :Float = 0;
	var _numberOfParts :Int = DEFAULT_PARTS_NUMBER;
	var _parts :Array<SnakePart>;
	var _isDirectionUpdated :Bool = true;
	
	public function new() 
	{
		super();
		initializeVariables();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.ENTER_FRAME, onUpdate);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
	}


	function initializeVariables() 
	{
		_headPosition = new Point(5, 5);
		_direction = new Point(0, -1);
		_parts = [];
		currentLevel = 1;
		_tailPosition = new Point();
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		setupParts();
		setupController();
	}
	
	private function onRemoved(e:Event):Void 
	{
		removeEventListener(Event.REMOVED_FROM_STAGE, onRemoved);
		removeEventListener(Event.ENTER_FRAME, onUpdate);
	}
	
	function setupParts() 
	{
		addSnakePart(false);
		addSnakePart(false);
		addSnakePart(false);
	}
	
	function setupController() 
	{
		addChild(new SnakeController());
	}
	
	
	function addSnakePart(append :Bool = true) 
	{
		var part = new SnakePart();
		
		if (_parts.length == 0) {
			part.x = _headPosition.x * part.width;
			part.y = _headPosition.y * part.height;
			_parts.push(part);
			addChild(part);
			return;
		}
		
		if (append) {
			if (_parts.length < 2) {
				_tailPosition = _headPosition.subtract(_direction);
			} else {
				if (_tailPosition != null) {
					
				} else {
					var tailPart = _parts[_parts.length - 1];
					var tailPos = new Point(tailPart.x / tailPart.width, tailPart.y / tailPart.height);
					
					var secondToLastPart = _parts[_parts.length - 2];
					var secondToLastPos = new Point(secondToLastPart.x / secondToLastPart.width, secondToLastPart.y / secondToLastPart.height);
					
					var tailDirection = tailPos.subtract(secondToLastPos);
					_tailPosition = tailDirection.add(tailPos);
				}
				
				
			}
			
			part.x = _tailPosition.x * part.width;
			part.y = _tailPosition.y * part.height;
			
			_parts.push(part);
		} else {
			_headPosition = _headPosition.add(_direction);
			part.x = _headPosition.x * part.width;
			part.y = _headPosition.y * part.height;
			
			_parts.insert(0, part);
		}
		
		addChild(part);
	}
	
	private function onUpdate(e:Event):Void 
	{
		var delta = TimeManager.getInstance().delta;
		_updateTimer += delta;
		if (_updateTimer >= _updateInterval) {
			_updateTimer -= _updateInterval;
			updateSnake();
			checkForHeadAndBodyCollision();
		}
	}
	
	function updateSnake() 
	{
		_headPosition = _headPosition.add(_direction);
		_isDirectionUpdated = false;
		
		//...
		//trace("Direction: " + _direction);
		
		if (_headPosition.x < 0) 
			_headPosition.x = 9;
		
		if (_headPosition.x > 9) 
			_headPosition.x = 0;
		
		if (_headPosition.y < 0) 
			_headPosition.y = 9;
		
		if (_headPosition.y > 9)
			_headPosition.y = 0;
		
		var tailPart = _parts.pop();
		
		
		_tailPosition.x = tailPart.x / tailPart.width;
		_tailPosition.y = tailPart.y / tailPart.height;
		
		tailPart.x = _headPosition.x * tailPart.width;
		tailPart.y = _headPosition.y * tailPart.height;
		_parts.insert(0, tailPart);
	}
	
	function checkForHeadAndBodyCollision() 
	{
		var bounds = _parts[0].getBounds(this);
		for (part in _parts) {
			var partX = part.x / bounds.width;
			var partY = part.y / bounds.height;
			for (samePart in _parts) {
				if (part == samePart)
					continue;
					
				var samePartX = samePart.x / bounds.width;
				var samePartY = samePart.y / bounds.height;
				
				if (partX == samePartX && partY == samePartY) {
					dispatchEvent(new SnakeCollisionEvent(SnakeCollisionEvent.SNAKE_COLLISION));
					break;
				}
			}
		}
	}
	
	
	function set_currentLevel(value :Int) 
	{
		currentLevel = value;
		_updateInterval = DEFAULT_INTERVAL - (INTERVAL_REDUCTION * currentLevel);
		return currentLevel;
	}
	
	
	// ================================================ FUNCTIONS TO USE ================================================== //
	public function moveUp() {
		if (_isDirectionUpdated)
			return;
		
		if (_direction.y != 1) {
			_isDirectionUpdated = true;
			_direction = new Point(0, -1);
		}
	}	
	
	public function moveDown() {
		if (_isDirectionUpdated)
			return;
		
		if (_direction.y != -1) {
			_isDirectionUpdated = true;
			_direction = new Point(0, 1);
		}
	}
	
	public function moveLeft() {
		if (_isDirectionUpdated)
			return;
		
		if (_direction.x != 1) {
			_isDirectionUpdated = true;
			_direction = new Point(-1, 0);
		}
	}
	
	public function moveRight() {
		if (_isDirectionUpdated)
			return;
		
		if (_direction.x != -1) {
			_isDirectionUpdated = true;
			_direction = new Point(1, 0);
		}
	}
	
	public function containsCoordinate(x :Int, y :Int) {
		var bounds = _parts[0].getBounds(this);
		for (part in _parts) {
			var partX = part.x / bounds.width;
			var partY = part.y / bounds.height;
			if (partX == x && partY == y)
				return true;
		}
		return false;
	}
	
	public function onAppleCollision(e:CollisionEvent)
	{
		addSnakePart();
	}
	
	
	
	
	// ================================================ GETTERS AND SETTERS ================================================== //
	public function getHead() :SnakePart
	{
		return _parts[0];
	}
	
}