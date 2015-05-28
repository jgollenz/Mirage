package 
{

	//NEU!!!

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.MovieClip;
	import net.eriksjodin.arduino.Arduino;
	import net.eriksjodin.arduino.ArduinoWithServo;
	import net.eriksjodin.arduino.events.ArduinoEvent;
	import net.eriksjodin.arduino.events.ArduinoSysExEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.*;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import fl.motion.Color;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;

	public class MirrorMain extends MovieClip
	{
		// Arduino object
		var a:ArduinoWithServo;
		var defaultPinConfig:Array = new Array(
		null,// Pin 0   null (is RX)
		null,// Pin 1   null (is TX)
		'digitalIn',  // Pin 2   digitalIn or digitalOut 
		'digitalIn',  // Pin 3   pwmOut or digitalIn or digitalOut 
		'digitalIn',  // Pin 4   digitalIn or digitalOut  
		'digitalIn',  // Pin 5   pwmOut or digitalIn or digitalOut 
		'digitalIn',  // Pin 6   pwmOut or digitalIn or digitalOut 
		'digitalIn',  // Pin 7   digitalIn or digitalOut  
		'digitalIn',  // Pin 8   digitalIn or digitalOut  
		'digitalIn',  // Pin 9   pwmOut or digitalIn or digitalOut or servo 
		'digitalIn',  // Pin 10  pwmOut or digitalIn or digitalOut or servo
		'digitalIn',  // Pin 11  pwmOut or digitalIn or digitalOut 
		'digitalIn',  // Pin 12  digitalIn or digitalOut 
		'digitalOut', // Pin 13  digitalIn or digitalOut ( led connected )
		'analogIn',   // Analog pin 0  analogIn
		'analogIn',   // Analog pin 1  analogIn
		'analogIn',   // Analog pin 2  analogIn
		'analogIn',   // Analog pin 3  analogIn
		'analogIn',   // Analog pin 4  analogIn
		'analogIn');
		
		
		
		var now:Now = new Now();
		var time:Date = new Date();
		var scheduler:Scheduler = new Scheduler(now,this);
		//var schedulerWidget:SchedulerWidget;
		var shoutcastPlayer:ShoutcastPlayer = new ShoutcastPlayer();
		var testArray:Array = new Array();
		var weather:Weather = new Weather();
		var newsfeed:Newsfeed = new Newsfeed();
		var _rssLoader:URLLoader = new URLLoader();
		var _rssURL:URLRequest = new URLRequest("http://derStandard.at/?page=rss&ressort=Seite1");

		var refreshTimer = new Timer(50);
		// Change this array to the pin configuration you use in your own setup.;
		

		

		
		var receivedValuesLeft:Array = new Array();
		var receivedValuesRight:Array = new Array();
		var receivedValuesBoth:Array = new Array();
		//var rightTriggeredLeftvalues:Array = new Array();
		//var now:Date = new Date();
		var timer:Timer = new Timer(800,1);		//Time in which the second value must be recognized to trigger a swipe
		var holdDownTimer:Number = 0;
		var fromDirection:String;
		var currentlyDisplayed:String = "mainScreen";	//initial Screen displayed


		var ball:Ball = new Ball();
		var ballLeft = new Ball();
		var ballRight = new Ball();
		var ballTest = new Ball();
		var alphaThreshhold:int=0;	//For ball visibility
		var menuInit:Boolean = false;
		var menuActivated:Boolean = false;
		
		//TextFields
		var textFieldLeft:TextField = new TextField(); //TODO ändern in textFieldMenuLeft
		var textFieldRight:TextField = new TextField();
		var textFieldMenuCenter:TextField = new TextField();
		var textFieldScreensaver:TextField = new TextField();
		
		//Collision detection
		var hitLeft:Boolean;
		var hitRight:Boolean;
		
		
		var menuStartSensorValueUpper:Number = 170;	//TODO verifiy if correct
		var menuStartSensorValueLower:Number = 110;
		var menuStopSensorValueUpper:Number = 6;
		var menuStopSensorValueLower:Number = 0;
		
		var playerIsOn:Boolean = false;
		var volumeControl:Boolean = false;
		var hitCurrentlyDetected:Boolean =false;
		
		var swipeTriggerSensorValue:Number = 200; //TODO implement
		
		var magicMirrorOn:Boolean=false;




		public function MirrorMain()
		{
			stage.addEventListener(Event.ENTER_FRAME, now.getTime);
			refreshTimer.addEventListener(TimerEvent.TIMER, onTick);
			weather.loadXML("http://weather.yahooapis.com/forecastrss?w=548536&u=c");

			a = new ArduinoWithServo("127.0.0.1",5331);
			// listen for connection 
			a.addEventListener(Event.CONNECT,onSocketConnect);
			a.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			timer.addEventListener(TimerEvent.TIMER, timerStart);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerStop);
			// listen for firmware (sent on startup)
			a.addEventListener(ArduinoEvent.FIRMWARE_VERSION, onReceiveFirmwareVersion);
			
			
			
			//stage.addChild(ball);
			//stage.setChildIndex(ball, numChildren-1);  
			
			mainScreen.addChild(now);
			mainScreen.addChild(weather);
			mainScreen.addChild(shoutcastPlayer);
			menuContainer.addChild(ball);
			menuContainer.addChild(ballLeft);
			menuContainer.addChild(ballRight);
			menuContainer.addChild(ballTest);
			menuContainer.addChild(textFieldLeft);
			menuContainer.addChild(textFieldRight);
			menuContainer.addChild(textFieldMenuCenter);
			menuContainer.setChildIndex(ball, numChildren-1);  
			
			screensaver.addChild(textFieldScreensaver);
			
			ballTest.x=stage.width/2;
			ballTest.y=stage.height/2;
			
			_rssLoader.addEventListener(Event.COMPLETE, newsfeed.rssLoaded);
			_rssLoader.load(_rssURL);

			leftScreen.addChild(newsfeed);
			rightScreen.addChild(scheduler);
			scheduler.Controller();
			ball.alpha=0;
			ballLeft.alpha=0;
			ballRight.alpha=0;
			textFieldLeft.alpha=0;
			textFieldRight.alpha=0;
			textFieldMenuCenter.alpha=0;
			
			ball.y=0;
			ballLeft.x=	50-menuContainer.x ;
			ballRight.x=menuContainer.x-50;
			ballLeft.y = 0;
			ballRight.y =  0;
			
			//textFieldLeft.text ="Try Left";
			textFieldLeft.x=ballLeft.x-(textFieldLeft.width/4);
			textFieldLeft.y=40;
			textFieldLeft.textColor = 0xFFFFFF;
			
			//textFieldRight.text ="Try Right";
			textFieldRight.x=ballRight.x-(textFieldRight.width/4);
			textFieldRight.y=40;
			textFieldRight.textColor = 0xFFFFFF;
			
			textFieldMenuCenter.x=0-(textFieldMenuCenter.width/2);
			textFieldMenuCenter.y= -50;
			textFieldMenuCenter.textColor = 0xFFFFFF;
			
			textFieldScreensaver.x=0-(textFieldScreensaver.width/2);
			textFieldScreensaver.y=0;
			textFieldScreensaver.textColor = 0xFFFFFF;
			textFieldScreensaver.autoSize = "left";
			textFieldScreensaver.multiline = true;
			textFieldScreensaver.defaultTextFormat = new TextFormat('Verdana',16,0xDEDEDE);
			textFieldScreensaver.text="Good morning, Beautiful!";
			textFieldScreensaver.alpha=0;
			
			
		}
		// == SETUP AND INITIALIZE CONNECTION ( don't modify ) ==================================

		// triggered when there is an IO Error
		function errorHandler(errorEvent:IOErrorEvent):void
		{
			trace("- "+errorEvent.text);
			trace("- Did you start the Serproxy program ?");
		}

		// triggered when a serial socket connection has been established
		function onSocketConnect(e:Object):void
		{
			trace("- Connection with Serproxy established. Wait one moment.");

			// request the firmware version
			a.requestFirmwareVersion();
		}

		function onReceiveFirmwareVersion(e:ArduinoEvent):void
		{
			trace("- Connection with Arduino - Firmata version: " + String(e.value));
			trace("- Set default pin configuration.");

			// set Pinmodes by the default array. 
			for (var i:int = 2; i<defaultPinConfig.length; i++)
			{// set digital output pins
				if (defaultPinConfig[i] == "digitalOut")
				{
					a.setPinMode(i, Arduino.OUTPUT);
				}// set digital input pins
				if (defaultPinConfig[i] == "digitalIn")
				{
					a.setPinMode(i, Arduino.INPUT);
				}// set pwm output pins
				if (defaultPinConfig[i] == "pwmOut")
				{
					a.setPinMode(i, Arduino.PWM);
				}// set servo output pins
				if (defaultPinConfig[i] == "servo")
				{
					a.setupServo(i, 0);
					// write set start position to 0 otherwise it turns directly to 90 degrees.
					a.writeAnalogPin(i, 0);
				}
			}

			// you have to turn on reporting for every ANALOG pin individualy. 
			for (var j:int = 0; j<6; j++)
			{
				a.setAnalogPinReporting(j, Arduino.ON);
			}

			// for digital pins its only one setting
			a.enableDigitalPinReporting();

			startProgram();
		}

		// == START PROGRAM =====================================================================

		function startProgram()
		{
			trace("- Start program.");

			// start the timer that calls the onTick function
			refreshTimer.start();
		}


		function valueMean(receivedValues:Array):Number
		{
			var arraySize:Number = receivedValues.length;
			var run:Number = 0;
			var sum:Number = 0;
			for (run=0; run<(arraySize); run++)
			{
				sum +=  receivedValues[run];
			}
			return Math.round(sum/arraySize);
		}

		function onScreensaverVisibleFinish(event:TweenEvent):void {
			var tweenTxtScreensaverVisible:Tween = new Tween(textFieldScreensaver,"alpha",Strong.easeInOut,0,1,2,true);
			tweenTxtScreensaverVisible.addEventListener(TweenEvent.MOTION_FINISH, onTxtVisibleFinalFinish);
		}

		function onTxtInvisibleFinish(event:TweenEvent):void {
			var tweenScreenSaverInvisible:Tween = new Tween(screensaver,"alpha",Strong.easeInOut,1,0,3,true);
		}
		
		function onTxtVisibleFinish(event:TweenEvent):void {
			var tweenTxtScreensaverInvisible:Tween = new Tween(textFieldScreensaver,"alpha",Strong.easeInOut,1,0,2,true);
			tweenTxtScreensaverInvisible.addEventListener(TweenEvent.MOTION_FINISH, onTxtInvisibleFinish);
		}
		
		function onTxtVisibleFinalFinish(event:TweenEvent):void {
			var tweenTxtScreensaverInvisible:Tween = new Tween(textFieldScreensaver,"alpha",Strong.easeInOut,1,0,2,true);
		}

		function onTick(event:TimerEvent):void	
		{
			// calculate position
			var valueLeft:Number;
			var valueRight:Number;
			var valueLight:Number;
			var arrayLength = 15;  //TODO better outside of function

			valueLeft = a.getAnalogData(3);
			valueRight = a.getAnalogData(4);
			valueLight = a.getAnalogData(5);
			

			if (magicMirrorOn==false && valueLight<300) {
				magicMirrorOn=true;
				trace("MagicMirror turned on");
				textFieldScreensaver.text="Good morning, Beautiful!";
				var tweenTxtScreensaverVisible:Tween = new Tween(textFieldScreensaver,"alpha",Strong.easeInOut,0,1,2,true);
				tweenTxtScreensaverVisible.addEventListener(TweenEvent.MOTION_FINISH, onTxtVisibleFinish);
			}else if (magicMirrorOn==true && valueLight>590) {
				magicMirrorOn=false;
				trace("MagicMirror turned off");
				textFieldScreensaver.text="Goodbye!";
				var tweenScreenSaverVisible:Tween = new Tween(screensaver,"alpha",Strong.easeInOut,0,1,2,true);
				tweenScreenSaverVisible.addEventListener(TweenEvent.MOTION_FINISH, onScreensaverVisibleFinish);
			}
			
			
			
						
			if ((valueMean(receivedValuesRight) - valueMean(receivedValuesLeft))>(menuContainer.x-50-ballRight.width)) {
				ball.x = menuContainer.x-50-ballRight.width;
			}else if ((valueMean(receivedValuesRight) - valueMean(receivedValuesLeft))<(ballLeft.width+50-menuContainer.x)) {
				ball.x=ballLeft.width+50-menuContainer.x; 
					  }else{
			ball.x = (valueMean(receivedValuesRight) - valueMean(receivedValuesLeft));
					  }
			// Fill the Array with Values from the Sensor
			receivedValuesLeft.unshift(valueLeft);
			if (receivedValuesLeft.length > arrayLength)
			{
				receivedValuesLeft.pop();
			}

			// Fill the Array with Values from the Sensor;
			receivedValuesRight.unshift(valueRight);
			if (receivedValuesRight.length > arrayLength)
			{
				receivedValuesRight.pop();
			}

			trace("Value left: ", valueLeft, "Value right: ", valueRight, " ValueLight ", valueLight," Screensaver.alpha ", screensaver.alpha," Player is on: ",playerIsOn, " menuActivated: ", menuActivated, " menuInit: ", menuInit);

			time = new Date();//WHAT FOR? ??

			//Don't detect swipes if holdDownTimer is active
			if (holdDownTimer>0)
			{
				holdDownTimer = holdDownTimer - 1;
			}

			//Go in if one of the two values is greater than 200
			if ((valueRight>200 || valueLeft>200) && menuActivated==false && menuInit==false)  //TODO outsource the 200 into a variable at the top
			{

				//Check if holDownTimer is not active
				if (holdDownTimer==0)
				{
					//Check if it is from direction RIGHT
					if (valueRight>200 && valueLeft<valueRight) // valueRight could be greater than 200, but valueLeft could be greater than 400 at the same time. Weird, I know
					{
						fromDirection = "RIGHT";
						trace("Incoming direction changed to RIGHT");
					}
					else
					{
						fromDirection = "LEFT";
						trace("Incoming direction changed to LEFT");
					}

					possibleSwipeDetected();
					//Activate the holdDownTimer
					holdDownTimer = 15;
				}
			}
			
			
			
			if (volumeControl==true && playerIsOn == true) {
				
				//TODO diese x-Werte statisch machen
				shoutcastPlayer.adjustVolume(((ball.x+319.9)/639.8)+0.0);
				//TODO string passt nicht in text field
				textFieldMenuCenter.text="Move to Ball to adjust the Volume.\nRemove your hand from action area to accept Volume";
				if (textFieldMenuCenter.alpha<1){
					textFieldMenuCenter.alpha=textFieldMenuCenter.alpha+0.2;
				}
			}else{
				if (textFieldMenuCenter.alpha>=0){
					textFieldMenuCenter.alpha=textFieldMenuCenter.alpha-0.2;
				}
			}
			
			
			
			hitLeft= ball.hitTestObject(ballLeft);
			hitRight= ball.hitTestObject(ballRight);
			
			if ((hitLeft==true || hitRight==true)&& hitCurrentlyDetected==false && menuActivated==true && menuInit==true) {
				hitCurrentlyDetected=true;
				if (hitLeft==true) {
					switch (currentlyDisplayed) {
						
						case "mainScreen":
						trace("COLLISION LEFT DETECTED ON: ", currentlyDisplayed);
						break;
						
						case "leftScreen":
						trace("COLLISION LEFT DETECTED ON: ", currentlyDisplayed)
						//Init read article
						break;
						
						case "rightScreen":
						trace("COLLISION LEFT DETECTED ON: ", currentlyDisplayed)
						if (volumeControl==false) {
							volumeControl=true;
						}
						break;
					}
				}else{
					switch (currentlyDisplayed) {
						
						case "mainScreen":
						trace("COLLISION RIGHT DETECTED ON: ", currentlyDisplayed)
						break;
						
						case "leftScreen":
						trace("COLLISION RIGHT DETECTED ON: ", currentlyDisplayed)
						//Init next articles
						break;
						
						case "rightScreen":
						trace("COLLISION RIGHT DETECTED ON: ", currentlyDisplayed)
						if (playerIsOn==true && volumeControl==false) {
							shoutcastPlayer.stopF();
							playerIsOn=false;
							//TODO hier ist der Fehler. Nächste Zeile auskommentieren dann gehts
							//shoutcastPlayer = new ShoutcastPlayer();
							textFieldRight.text="Start Radio";
						}else if (playerIsOn==false && volumeControl==false){
							
							shoutcastPlayer.playF();
							playerIsOn=true;
							textFieldRight.text="Stop Radio";
						}
						break;
					}
				}
			}
			
			if (hitLeft==false && hitRight==false) {
				hitCurrentlyDetected=false;
			}
			
			if ((valueRight>menuStopSensorValueLower && valueRight<menuStopSensorValueUpper)&&(valueLeft>menuStopSensorValueLower && valueLeft<menuStopSensorValueUpper)) {
				menuActivated=false;
				if (volumeControl==true){
					volumeControl=false;
				}
			}
			
			if ((valueRight>menuStartSensorValueLower && valueRight<menuStartSensorValueUpper)&&(valueLeft>menuStartSensorValueLower && valueLeft<menuStartSensorValueUpper)) {
				
				//trace("MirrorMain", "onTick", "both values are in correct range for Menu start");
				if (menuInit == true) {
					switch (currentlyDisplayed) {
								case "mainScreen":
								trace("DO SOMETHIG HERE");
								textFieldLeft.text="";
								textFieldRight.text="";
								break;
								
								case "leftScreen":
								trace("DO SOMETHIG HERE");
								textFieldLeft.text="Read articles";
								textFieldRight.text="Next articles";
								break;
								
								case "rightScreen":
								textFieldLeft.text="Adjust Volume";
								if (playerIsOn==false){
									textFieldRight.text="Start Radio";
								}else{
									textFieldRight.text="Stop Radio";
								}
								break;
							}
					if (alphaThreshhold >= 3) {
						if (ball.alpha < 1) {
							ball.alpha = ball.alpha + 0.1;
							ballLeft.alpha=ballLeft.alpha+0.1;
							ballRight.alpha=ballRight.alpha+0.1
							
							
							textFieldLeft.alpha=textFieldLeft.alpha+0.1
							textFieldRight.alpha=textFieldRight.alpha+0.1
						}else {
							menuActivated = true;
						}
					}else {
						alphaThreshhold++;
					}	
				}else{
					menuInit = true;
					trace("MirrorMain","onTick","menuInit = true");
				}
			}else {
				if (alphaThreshhold > 0) {
					alphaThreshhold--
				}else {
					
					if (menuActivated==false) {
						if (ball.alpha>0) {
							ball.alpha = ball.alpha - 0.1;
							ballLeft.alpha=ballLeft.alpha-0.1;
							ballRight.alpha=ballRight.alpha-0.1;
							textFieldLeft.alpha=textFieldLeft.alpha-0.1
							textFieldRight.alpha=textFieldRight.alpha-0.1
						}else{
							menuInit = false;
							
						}
					}
					/*
					if (ball.alpha <= 0) {
						menuActivated  = false;
					} else if (ball.alpha < 2) {
						ball.alpha = ball.alpha - 0.05;
					}*/
					
					
				}
			}
			
			/*
				
				Als nächstes: 	*Irgendwie einen loop starten der überprüft ob die nächsten Werte richtig sind
								*Wenn ja: Threshold einrichten: z.B. fünfmal beide Werte im richtigen Bereich -> Alpha des Balls um 5% verringern
								*Für jedes weitere mal Alpha des Balls um 5% verringern
								*Wenn Werte nicht stimmen -> Alpha wieder um 5% erhöhen
								*Wenn Alpha bei 100%: aus Loop rausgehen
								*Wenn Alpha bei 0%: MenuMode auf True setzen
								*Wenn beide Werte auf/nahe Null sind (Hände weg aus dem Sensor-Bereich): MenuMode auf False setzen
								
								
						Vorschlag für Menu:
								
								Man kommt in ein Menu wenn man die Hand in die Mitte hält
								Dann wird ein Ball sichtbar
								Diesen kann man nach links oder rechts bewegen, und  dadurch zwei Aktionen starten.
								Je nachdem wo man sich befindet, werden verschiedene Aktionen ausgeführt
									MainScreen:
									RightScreen:
										Radio starten
										Lautstärke? (Sehr schwierig, wird noch komplizierter)
									LeftScreen:
										Artikel lesen
										Neue Artikel laden
								Wenn man die Hand wieder wegnimmt verlässt man das Menu.
				
				
				*/
			
			
			
			
			
			
			//TODO get rid of all those comments down there
			
			
			
			
			

			//now.x=valueMean(receivedValuesRight)-valueMean(receivedValuesLeft)+(stage.stageWidth/2)-500;


			// keep the ball2 in range of the stage 
			//ball2.y = valueRight * ((stage.stageHeight-ball2.height)/1023); 
			// keep the ball3 in range of the stage and smooth movement
			//var position:Number = valueLeft * ((stage.stageHeight-ball3.height)/1023); 
			// smooth factor between 0-1. The higher the slower the changes, but more smooth. 
			//var factor:Number = 0.8; 
			// set ball y position
			//ball3.y = (factor * ball3.y) + ((1-factor) * position);

			//trace("ball1.y: "+ball1.y+" - ball2.y: "+ball2.y+" - ball3.y: "+ball3.y);

			// set the light on pin13 to HIGH (1) when the analogValue is higher than 512
			// otherwise to LOW (0) when the analogValue is below 512

			if (valueLeft>512)
			{
				a.writeDigitalPin(13, 1);
			}
			else
			{
				a.writeDigitalPin(13, 0);
			}
		}
		
		
		
		
		
		//Is this function really necessary? couldnt the timer be started in the onTick() function?
		function possibleSwipeDetected():void
			{
				//this timer gets started, so that the receivedValues get evaluated after timer expires
				timer.start();
			}

			//also this function is not really necessary, right?
			function timerStart(e:TimerEvent):void
			{
				trace("Timer start");
			}

			function timerStop(e:TimerEvent):void
			{
				trace("Timer stop");
				//iteration should not be greater than length of receivedValues, ideally one lesser
				var iteration:Number;
				
				//just important if the function gets called immediately after the programm starts
				if (receivedValuesLeft.length < 15 || receivedValuesRight.length < 15)
				{
					if (receivedValuesLeft.length < receivedValuesRight.length < 15)
					{
						iteration = receivedValuesLeft.length;
					}
					else
					{
						iteration = receivedValuesRight.length;
					}
				}
				else
				{
					iteration = 15;
				}
				
				//Iterate over the receivedValues
				for (var i:Number=0; i<iteration; i++)
				{
					trace(receivedValuesLeft[i], receivedValuesRight[i]);

					if (receivedValuesLeft[i] > 200 && fromDirection == "RIGHT" && receivedValuesRight[i] < 200 )
					{
						trace(currentlyDisplayed);

						//var tweenContainerMainToLeft:Tween = new Tween(mainScreen,"x",Strong.easeInOut,mainScreen.x,mainScreen.x - 900,2,true);
						//var tweenContainerLeftToLeft:Tween = new Tween(leftScreen,"x",Strong.easeInOut,leftScreen.x,leftScreen.x - 900,2,true);
						//var tweenContainerRightToLeft:Tween = new Tween(rightScreen,"x",Strong.easeInOut,rightScreen.x,rightScreen.x - 900,2,true);
						trace("Swipe from ", fromDirection, "to LEFT detected");
						//really it goes RIGHT
						switch (currentlyDisplayed) {
						case "mainScreen": 
						//tweenContainerMainToLeft.start();
						//tweenContainerRightToLeft.start();
						var tweenContainerMainBackToLeft:Tween = new Tween(mainScreen,"x",Strong.easeInOut,mainScreen.x,mainScreen.x - 900,1,true);
						var tweenContainerRightToLeft:Tween = new Tween(rightScreen,"x",Strong.easeInOut,rightScreen.x,rightScreen.x - 900,1,true);
						currentlyDisplayed="rightScreen";
						break;
						
						case "leftScreen":
						var tweenContainerMainToLeft:Tween = new Tween(mainScreen,"x",Strong.easeInOut,mainScreen.x,mainScreen.x - 900,1,true);
						var tweenContainerLeftToLeft:Tween = new Tween(leftScreen,"x",Strong.easeInOut,leftScreen.x,leftScreen.x - 900,1,true);
						currentlyDisplayed="mainScreen";
						break;
						
						case "rightScreen":
						var tweenContainerRightEnd:Tween= new Tween (rightScreen, "x", Elastic.easeOut, rightScreen.x, rightScreen.x,1,true);
						break;
						}
						break;
					}
					else if (receivedValuesRight[i] > 200 && fromDirection=="LEFT")
					{
						//var tweenContainerMainToRight:Tween = new Tween(mainScreen,"x",Strong.easeInOut,mainScreen.x,mainScreen.x + 900,2,true);
						//var tweenContainerLeftToRight:Tween = new Tween(leftScreen,"x",Strong.easeInOut,leftScreen.x,leftScreen.x + 900,2,true);
						//var tweenContainerRightToRight:Tween = new Tween(rightScreen,"x",Strong.easeInOut,rightScreen.x,rightScreen.x + 900,2,true);
						trace(currentlyDisplayed);
						trace("Swipe from ", fromDirection, "to RIGHT detected");
						//really it goes LEFT
						switch (currentlyDisplayed) {
							case "mainScreen":
							var tweenContainerMainBackToRight:Tween = new Tween(mainScreen,"x",Strong.easeInOut,mainScreen.x,mainScreen.x + 900,1,true);
							var tweenContainerLeftToRight:Tween = new Tween(leftScreen,"x",Strong.easeInOut,leftScreen.x,leftScreen.x + 900,1,true);
							currentlyDisplayed="leftScreen";
							break;
							
							case "rightScreen":
							var tweenContainerMainToRight:Tween = new Tween(mainScreen,"x",Strong.easeInOut,mainScreen.x,mainScreen.x + 900,1,true);
							var tweenContainerRightToRight:Tween = new Tween(rightScreen,"x",Strong.easeInOut,rightScreen.x,rightScreen.x + 900,1,true);
							currentlyDisplayed="mainScreen";
							break;
							
							case "leftScreen":
							break;
							
						}
						
						break;
					}
				}
			}
	}

}// == YOUR PROGRAM HERE =================================================================;