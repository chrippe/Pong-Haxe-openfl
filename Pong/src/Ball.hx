package ;

import openfl.display.Sprite;

/**
 * ...
 * @author Chrippe
 */
class Ball extends Sprite
{
	
	private var color:UInt;
	private var xpos:Float;
	private var ypos:Float;
	private var radius:Float;
	
	public function new(color:UInt, xpos:Float, ypos:Float, radius:Float) 
	{
		super();
		this.graphics.beginFill(color);
		this.graphics.drawCircle(xpos, ypos, radius);
		this.graphics.endFill();
	}
	
}