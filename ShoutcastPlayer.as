package 
{
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.ui.Mouse;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flashx.textLayout.formats.Float;
	
	public class ShoutcastPlayer extends Sprite
	{
		var loadSnd:URLRequest = new URLRequest("http://mp3stream1.apasf.apa.at:8000/");
		
		var thisSnd:Sound = new Sound();
		var sndChannel:SoundChannel = new SoundChannel();
		var sndTransform = new SoundTransform();
		var soundVolume:Number=0.5;
		
		
		public function ShoutcastPlayer()
		{
			thisSnd.load(loadSnd);
			
			//play_Btn.addEventListener(MouseEvent.CLICK,playF);
			//stop_Btn.addEventListener(MouseEvent.CLICK,stopF);
			//stop_Btn.visible = false;
		}

		public function playF():void
		{
			//SoundMixer.stopAll();
			sndTransform.volume=soundVolume+0.01;
			sndChannel = thisSnd.play();
			sndChannel.soundTransform = sndTransform;
			trace("PLAYER.STARTgets CAlLED");
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
		
		public function adjustVolume(soundVolume:Number):void {
			
			this.soundVolume=soundVolume;
			sndTransform.volume=soundVolume+0.01;
			sndChannel.soundTransform = sndTransform;
			
		}	
	}

}