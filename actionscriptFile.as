import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.geom.Point;
import flash.display.MovieClip;

// movement variables

var leftArr: Boolean = false;
var rightArr: Boolean = false;
var upArr: Boolean = false;

var facingLeft: Boolean = false;
var facingRight: Boolean = false;

var xMoveSpeed: Number = 1;
var yMoveSpeed: Number = 6;
var speedConstant: int = 8;
var friction: Number = 0.6;
var gravityConstant: Number = 3;

var leftBump: Point = new Point(-25, 0);
var rightBump: Point = new Point(25, 0);
var upBump: Point = new Point(0, -25);
var downBump: Point = new Point(0, 25);

var leftBumping: Boolean = false;
var rightBumping: Boolean = false;
var upBumping: Boolean = false;
var downBumping: Boolean = false;

// missile variables

var missiles: Array = new Array();

function shootMissile(fireball: MovieClip): void
{
	missiles.push(fireball);
	trace("shooting");
	fireball.x = hero.x;
	fireball.y = hero.y;
	this.addChild(fireball);
}

// movement event listeners

stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboardHandler);
stage.addEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
stage.addEventListener(Event.ENTER_FRAME, moveHero);

// missile event listeners

stage.addEventListener(KeyboardEvent.KEY_DOWN, createMissile);

// movement functions

function keyboardHandler(event: KeyboardEvent): void
{
	if (event.type == "keyDown")
	{
		if (event.keyCode == Keyboard.LEFT)
		{
			leftArr = true;
			facingLeft = true;
			facingRight = false;
		}
		if (event.keyCode == Keyboard.RIGHT)
		{
			rightArr = true;
			facingRight = true;
			facingLeft = false;
		}
		if (event.keyCode == Keyboard.UP)
		{
			upArr = true;
		}
	}
	if (event.type == "keyUp")
	{
		if (event.keyCode == Keyboard.LEFT)
		{
			leftArr = false;
		}
		if (event.keyCode == Keyboard.RIGHT)
		{
			rightArr = false;
		}
		if (event.keyCode == Keyboard.UP)
		{
			upArr = false;
		}
	}
}

function moveHero(event: Event): void
{
	if (leftArr == true)
	{
		xMoveSpeed += speedConstant;
	}
	if (rightArr == true)
	{
		xMoveSpeed -= speedConstant;
	}
	if (upArr == true)
	{
		yMoveSpeed += speedConstant;
	}

	if (terrain.hitTestPoint(hero.x + leftBump.x, hero.y + leftBump.y, true))
	{
		trace("leftBumping");
		leftBumping = true;
	}
	else
	{
		leftBumping = false;
	}

	if (terrain.hitTestPoint(hero.x + rightBump.x, hero.y + rightBump.y, true))
	{
		trace("rightBumping");
		rightBumping = true;
	}
	else
	{
		rightBumping = false;
	}

	if (terrain.hitTestPoint(hero.x + upBump.x, hero.y + upBump.y, true))
	{
		trace("upBumping");
		upBumping = true;
	}
	else
	{
		upBumping = false;
	}

	if (terrain.hitTestPoint(hero.x + downBump.x, hero.y + downBump.y, true))
	{
		trace("downBumping");
		downBumping = true;
	}
	else
	{
		downBumping = false;
	}

	if (leftBumping == true)
	{
		if (xMoveSpeed > 0)
		{
			xMoveSpeed *= -0.5;
		}
	}

	if (rightBumping == true)
	{
		if (xMoveSpeed < 0)
		{
			xMoveSpeed *= -0.5;
		}
	}

	if (upBumping == true)
	{
		if (yMoveSpeed < 0)
		{
			yMoveSpeed -= 0.5;
		}
	}

	if (downBumping == true && upArr == false)
	{
		yMoveSpeed = 0;
	}

	if (downBumping == false && upArr == false)
	{
		yMoveSpeed -= gravityConstant;
	}

	xMoveSpeed *= friction;
	yMoveSpeed *= friction;
	terrain.x += xMoveSpeed;
	terrain.y += yMoveSpeed;

	trace(yMoveSpeed);
}

// missile functions

function createMissile(event: KeyboardEvent): void
{
	if (event.keyCode == Keyboard.SPACE)
	{
		if (facingLeft == true)
		{
			var lFireball: LeftFireball = new LeftFireball();
			shootMissile(lFireball);
		}
		if (facingRight == true)
		{
			var rFireball: RightFireball = new RightFireball();
			shootMissile(rFireball);
		}
	}
	/*missiles.push(fireball);
		trace("shooting");
		fireball.x = hero.x;
		fireball.y = hero.y;
		this.addChild(fireball);*/
}
