package ;

import openfl.display.Sprite;

/**
 * ...
 * @author Chrippe
 */
class Platform extends Sprite
{
	
	private var color:UInt;
	private var xpos:Float;
	private var ypos:Float;
	private var w:Float;
	private var h:Float;
	
	public function new(color:UInt, xpos:Float, ypos:Float, w:Float, h:Float) 
	{
		super();
		this.graphics.beginFill(color);
		this.graphics.drawRect(xpos, ypos, w, h);
		this.graphics.endFill();
	}
	
}