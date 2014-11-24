package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import openfl.geom.Point;

import openfl.events.KeyboardEvent;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Chrippe
 */

 

class Main extends Sprite 
{
	var inited:Bool;
	
	private var currentGameState:GameState;
	
	private var platform1:Platform;
	private var platform2:Platform;
	private var ball:Ball;
	private var ballMovement:Point;
	private var ballSpeed:Int;
	
	private var scorePlayer:Int;
	private var scoreAI:Int;
		
	private var arrowKeyUp:Bool;
	private var arrowKeyDown:Bool;
	
	private var platformSpeed:Int;
	private var scoreTextField:ScoreTextfield;
	private var messageTextField:MessageTextField;
	
	

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		// (your code here)
		
		platform1 = new Platform(0xFFFFFF, 0, 0, 15, 100);
		platform1.x = 5;
		platform1.y = 200;
		this.addChild(platform1);
		
		platform2 = new Platform(0xFFFFFF, 0, 0, 15, 100);
		platform2.x = 480;
		platform2.y = 200;
		this.addChild(platform2);
		
		ball = new Ball(0xFFFFFF, 0, 0, 10);
		ball.x = 250;
		ball.y = 250;
		this.addChild(ball);
		
		scoreTextField = new ScoreTextfield();
		this.addChild(scoreTextField);
		
		messageTextField = new MessageTextField();
		messageTextField.y = 450;
		this.addChild(messageTextField);
		
		scorePlayer = 0;
		scoreAI = 0;
		setGameState(Paused);
		arrowKeyDown = false;
		arrowKeyUp = false;
		platformSpeed = 7;
		ballMovement = new Point(0, 0);
		ballSpeed = 7;
		
		stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		
		this.addEventListener(Event.ENTER_FRAME, this_enterFrame);
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}
	

	
	private function keyUp(e:KeyboardEvent):Void 
	{
		if (e.keyCode ==38) //UP 
		{
			arrowKeyUp = false;
		}
		else if (e.keyCode == 40) //DOWN 
		{
			arrowKeyDown = false;
		}
	}
	
	private function keyDown(e:KeyboardEvent):Void 
	{
		if (currentGameState == Paused && e.keyCode == 32) //SPACE
		{
			setGameState(Playing);
		}
		else if (e.keyCode == 38) //UP
		{
			arrowKeyUp = true;
		}
		else if (e.keyCode == 40) //DOWN
		{
			arrowKeyDown = true;
		}
	}
	
	private function updateScore():Void
	{
		scoreTextField.text = scorePlayer + ":" + scoreAI;
	}
	
	private function bounceBall():Void
	{
		var direction:Int = (ballMovement.x > 0)?( -1):(1);
		var randomAngle:Float = (Math.random() * Math.PI / 2) - 45;
		ballMovement.x = direction * Math.cos(randomAngle) * ballSpeed;
		ballMovement.y = Math.sin(randomAngle) * ballSpeed;
	}
	
	private function setGameState(state:GameState):Void
	{
		currentGameState = state;
		updateScore();
		if (state == Paused) 
		{
			messageTextField.alpha = 1;
		}
		else
		{
			messageTextField.alpha = 0;
			platform1.y = 200;
			platform2.y = 200;
			ball.x = ball.y = 250;
			
			//(condition)?(true_value):(false_value);
			var direction:Int  = (Math.random() > .5) ? (1):( -1);
			var randomAngle:Float = (Math.random() * Math.PI/2) - 45;
			ballMovement.x = direction * Math.cos(randomAngle) * ballSpeed;
			ballMovement.y = Math.sin(randomAngle) * ballSpeed;
		}
	}
	
	private function winGame(player:Player):Void
	{
		if (player == Human) 
		{
			scorePlayer++;
		}
		else
		{
			scoreAI++;
		}
		setGameState(Paused);
	}
	
	private function this_enterFrame(e:Event):Void 
	{
		if (currentGameState == Playing) 
		{
			//player platform movement
			if (arrowKeyUp) 
			{
				platform1.y -= platformSpeed;
			}
			
			if (arrowKeyDown) 
			{
				platform1.y += platformSpeed;
			}
			
			// AI platform movement
			if (ball.x > 300 && ball.y > platform2.y + 70) {
				platform2.y += platformSpeed;
			}
			if (ball.x > 300 && ball.y < platform2.y + 30) {
				platform2.y -= platformSpeed;
			}
			
			// player platform limits
			if (platform1.y < 5 ) platform1.y = 5;
			if (platform1.y > 395) platform1.y = 395;
			
			// AI platform limits
			if (platform2.y < 5) platform2.y = 5;
			if (platform2.y > 395) platform2.y = 395;
			
			//ball movement
			ball.x += ballMovement.x;
			ball.y += ballMovement.y;
			
			// ball platform bounce
			if (ballMovement.x < 0 && ball.x < 30 && ball.y >= platform1.y && ball.y <= platform1.y + 100) {
				bounceBall();
				ball.x = 30;
			}
			if (ballMovement.x > 0 && ball.x > 470 && ball.y >= platform2.y && ball.y <= platform2.y + 100) {
				bounceBall();
				ball.x = 470;
			}
			
			//ball edge bounce
			if (ball.y < 5 || ball.y > 495) ballMovement.y *= -1;
			//ball goal
			if (ball.x < 5) winGame(AI);
			if (ball.x > 495) winGame(Human);
		}
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
