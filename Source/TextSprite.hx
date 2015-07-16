package;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Nickan
 */
class TextSprite extends Sprite
{
	var _textField :TextField;
	
	public function new() 
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, onAdded);
		addEventListener(Event.ENTER_FRAME, onUpdate);
	}
	
	private function onAdded(e:Event):Void 
	{
		removeEventListener(Event.ADDED_TO_STAGE, onAdded);
		setupTextField();
	}
	
	function setupTextField() 
	{
		var textFormat = new TextFormat("Verdana", 30, 0x000000, true);
		//textFormat.align = TextFormatAlign.LEFT;
		
		_textField = new TextField();
		_textField.defaultTextFormat = textFormat;
		_textField.autoSize = TextFieldAutoSize.LEFT;
		//_textField.width = stage.stageWidth;
		addChild(_textField);
	}
	
	
	private function onUpdate(e:Event):Void 
	{
		
	}

	
	public function showText(text :String) {
		_textField.text = text;
	}
}