package;
import openfl.display.Sprite;

/**
 * ...
 * @author Nickan
 */
class SnakePart extends Sprite
{
	public var radius(default, null) :Float = 20;
	
	public function new() 
	{
		super();
		graphics.beginFill(0x0000FF);
		graphics.drawCircle(0 + radius, 0 + radius, radius);
		graphics.endFill();
	}
	
}