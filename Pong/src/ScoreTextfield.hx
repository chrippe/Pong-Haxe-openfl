package ;

import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Chrippe
 */
class ScoreTextfield extends TextField
{
	
	private var scoreFormat:TextFormat;	
	
	public function new() 
	{
		super();
		scoreFormat = new TextFormat("Verdana", 24, 0xbbbbbb, true);
		scoreFormat.align = TextFormatAlign.CENTER;
		
		this.width = 500;
		this.height = 30;
		this.selectable = false;
		this.defaultTextFormat = scoreFormat;
	}
	
}