package ;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Chrippe
 */
class MessageTextField extends TextField
{
	
	private var messageFormat:TextFormat;
	
	public function new() 
	{
		super();
		messageFormat = new TextFormat("Verdana", 18, 0xbbbbbb, true);
		messageFormat.align = TextFormatAlign.CENTER;
		
		this.width = 500;
		this.defaultTextFormat = messageFormat;
		this.selectable = false;
		this.text = "Press SPACE to start\nUse ARROW KEYS to move your platform";
	}
	
}