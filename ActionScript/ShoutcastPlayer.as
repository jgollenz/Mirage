package 
{
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.ui.Mouse;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flashx.textLayout.formats.Float;
	import flash.net.URLLoader;

	public class ShoutcastPlayer extends Sprite
	{
		var loadSnd:URLRequest = new URLRequest("http://mp3stream1.apasf.apa.at:8000/;");
		//var loadSnd:URLRequest = new URLRequest("http://fm4.orf.at");

		var thisSnd:Sound = new Sound();
		var sndChannel:SoundChannel = new SoundChannel();
		//var sndChannel2:SoundChannel = new SoundChannel();
		var sndTransform = new SoundTransform();
		var soundVolume:Number = 0.5;
		var swoosh:Swoosh = new Swoosh();
		var loader:URLLoader = new URLLoader();


		private var oldPosition:Number;
		
		public function onEnterFrame(e:Event):void
		{
			var stillPlaying:Boolean;
			var newPosition = sndChannel.position;
			if (newPosition-oldPosition>1)
			{
				stillPlaying = true;
			}
			else
			{
				stillPlaying = false;
			}
			oldPosition = newPosition;
			trace ("PLAYING: ",stillPlaying, "VOLUME: ", sndChannel.soundTransform.volume);
		}


		private function soundLoaded(e:Event):void 
		{
			trace("SOUNDLOADED\nSOUNDLOADED\nSOUNDLOADED\nSOUNDLOADED\nSOUNDLOADED\nSOUNDLOADED\nSOUNDLOADED\nSOUNDLOADED\nSOUNDLOADED\n");
			trace("URL OF SOUND: ", thisSnd.url);
			trace("LOADED BYTES OF SOUND: ", thisSnd.bytesLoaded);
			trace("BYTES TOTAL OF SOUND: ", thisSnd.bytesTotal);
			trace("LENGTH OF SOUND: ", thisSnd.length);
		}
				
		private function loaderLoaded(e:Event):void
		{
			trace("CONTENT OF LOADER: ", loader.data);
		}
		
		public function ShoutcastPlayer()
		{
			thisSnd.addEventListener(Event.COMPLETE, soundLoaded);
			thisSnd.load(loadSnd);
			
			loader.addEventListener(Event.COMPLETE, loaderLoaded);
			loader.load(loadSnd);
			//this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			//play_Btn.addEventListener(MouseEvent.CLICK,playF);
			//stop_Btn.addEventListener(MouseEvent.CLICK,stopF);
			//stop_Btn.visible = false;
		}

		public function playF():void
		{
			//SoundMixer.stopAll();
			sndTransform.volume=soundVolume+0.01;
			sndChannel = thisSnd.play();
			//sndChannel2=swoosh.play();
			trace("VOLUME: ",sndChannel.soundTransform.volume);
			sndChannel.soundTransform = sndTransform;
			trace("PLAYER.START gets CAlLED");
			trace(sndChannel.toString());
			//play_Btn.visible = false;
			//stop_Btn.visible = true;
		}

		public function stopF():void
		{
			//SoundMixer.stopAll();
			sndChannel.stop();
			//thisSnd.load(loadSnd);
			trace("PLAYER.STOP gets CAlLED");
			//play_Btn.visible = true;
			//stop_Btn.visible = false;
		}

		public function adjustVolume(soundVolume:Number):void
		{
			this.soundVolume = soundVolume;
			sndTransform.volume = soundVolume + 0.01;
			sndChannel.soundTransform = sndTransform;
		}
	}
}