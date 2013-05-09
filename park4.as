//Reference:Perkins, T, ActionScript 3.0 in Flash Professional CS5 Essential Training
// http://www.lynda.com/ActionScript-3-tutorials/ActionScript-3-in-Flash-CS5-Essential-Training/67685-2.html
//Accessed: November 20th, 2012

package 
{
	//Import classes so they are available to use throughout the package
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import fl.controls.Button;



	public class park4 extends MovieClip
	{


		var dragdrops:Array;
		//represents how many matches a user gets
		var numOfMatches:uint = 0;
		//represents how fast the finish screen will move 
		var speed:Number = 25;
		var cheer_audio:Sound = new Sound(new URLRequest("cheering.mp3"));
	


		public function park4()
		{
			//corresponds to all of the dragable instances on the stage		
			dragdrops = [el_arbol1,el_pato1,la_nube1,el_sol1,la_flor1,la_hierba1,la_mariposa1];
			//represents the current object in the array as we loop through it.
			var currentObject:DragDrop;
			


			// call function playGame when play_btn is clicked
			getChildByName('play_btn').addEventListener( MouseEvent.CLICK, playGame);

			// go to 'game' frame and stops the movie
			function playGame( event : MouseEvent ):void
			{
				gotoAndStop("game");
			}

			// call function showInstructions when instructionsBtn1 is clicked
			getChildByName('instructionsBtn1').addEventListener( MouseEvent.CLICK, showInstructions);

			// go to 'instructions2' frame which is within the layer 'instructions';
			function showInstructions( event : MouseEvent ):void
			{
				instructions.gotoAndStop("instructions2");
			}// end function playGame


			//i is a set to be a positive integer that increments by 1 each time the loop executes
			//therefore the number of times the equal to the length of the dragdrop array
			for (var i:uint = 0; i < dragdrops.length; i++)
			{
				//each time the code executes it is going to loop through the dragdrops array
				currentObject = dragdrops[i];
				//sets the target to correspond to the current object
				//currentObject.name gets the name of the object rather than the actual movie clip
				currentObject.target = getChildByName(currentObject.name + "_target");
			}
		}

		//match function set to public so it can be accessed in the DragDrop class.
		public function match():void
		{
			//increments numOfMatches by 1 everytime an object is matched to its target
			numOfMatches++;
			//checks if the number of matches equals to number of objects in the dragdrops array
			if (numOfMatches == dragdrops.length)
			{
				finish1.alpha = 1;
				//this event listener runs the function finishGame on every frame of the movie		
				finish1.addEventListener(Event.ENTER_FRAME, finishGame);
				
			}
		}

		function finishGame(evt:Event):void
		{

			//The finish screen is going to move up with every frame
			finish1.y -=  speed;

			//checking if the finish screen's position is <=0
			if (finish1.y <= 0)
			{
				finish1.y = 0;
				//this stops the finishGame function from running once the finish screen is at the top position
				finish1.removeEventListener(Event.ENTER_FRAME, finishGame);
				//executes clickPlayAgain function on mouse click.
				finish1.addEventListener(MouseEvent.CLICK, clickPlayAgain);
				cheer_audio.play();


			}
		}

		function clickPlayAgain(event:MouseEvent):void
		{
			//disables the event listener after button has been clicked once
			finish1.removeEventListener(MouseEvent.CLICK, clickPlayAgain);
			//moves the finish screen back down;
			finish1.addEventListener(Event.ENTER_FRAME, animateDown);
			
			var currentObject:DragDrop;
			//this loop resets the position of the objects
			for (var i:uint = 0; i < dragdrops.length; i++)
			{
				currentObject = dragdrops[i];
				//makes the target invisible again
				getChildByName(currentObject.name + "_target").alpha = 0;
				//makes the current object visible again
				currentObject.visible = true;
			}
			//sets number of matches back to zero
			numOfMatches = 0;
			//places the finish1 screen at the front
			addChild(finish1);
		}

		function animateDown(event:Event)
		{
			//the finish screen is going to move down with every frame
			finish1.y +=  speed;

			//checks if the position of the finish screen is >= height of the stage
			if (finish1.y >= stage.stageHeight)
			{
				//aligns the top of the finish movie clip with the bottom of the stage
				finish1.y = stage.stageHeight;
				//this stops the animateDown function from running once the finish screen is at the bottom position
				finish1.removeEventListener(Event.ENTER_FRAME, animateDown);
			}
		}
	}
}