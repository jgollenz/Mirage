﻿package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;
	import fl.motion.Color;
	import flash.text.TextFormat;

	public class Countdowntimer extends MovieClip
	{
		private var timerHasFinished:Boolean = false;
		private var _timer:Timer = null;
		private var _repeatCount:int = 0;
		private var _totalMinutes:int = 1;
		private var headline:TextField = new TextField  ;
		private var textMinutes:TextField = new TextField  ;
		private var textSeconds:TextField = new TextField  ;
		private var minutes:TextField = new TextField  ;
		private var seconds:TextField = new TextField  ;
		private var textFormat:TextFormat = new TextFormat();
		private var textHeadline:TextFormat = new TextFormat();
		private var champagne = new Champagne();

		public function Countdowntimer():void
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		public function init(e:Event):void
		{
			_repeatCount = _totalMinutes * 60;
			_timer = new Timer(1000,_repeatCount);
			_timer.addEventListener(TimerEvent.TIMER, _OnTimerFired);
		}

		public function startTimer():void
		{
			timerHasFinished = false;
			_timer.start();
		}

		public function getTimerHasFinished():Boolean
		{
			return timerHasFinished;
		}

		public function getCurrentTime():String
		{
			return minutes.text+":"+seconds.text;
		}

		private function _OnTimerFired(e:TimerEvent):void
		{
			textFormat.size = 50;
			textFormat.font = "Orator Std";
			textFormat.color = 0xFFFFFF;

			textHeadline.size = 30;
			textHeadline.font = "Orator Std";
			textFormat.font = champagne.fontName;
			textHeadline.color = 0xFFFFFF;

			headline.defaultTextFormat = textHeadline;
			headline.text = "Countdown Timer";
			headline.antiAliasType = AntiAliasType.ADVANCED;
			headline.x = -120;
			headline.y = -10;
			headline.width = 500;

			minutes.defaultTextFormat = textFormat;
			minutes.antiAliasType = AntiAliasType.ADVANCED;
			minutes.x = -120;
			minutes.y = 30;
			minutes.width = 100;

			seconds.defaultTextFormat = textFormat;
			seconds.antiAliasType = AntiAliasType.ADVANCED;
			seconds.x = -20;
			seconds.y = 30;
			seconds.width = 100;

			var minRem:int = (_repeatCount - _timer.currentCount) / 60;
			var secRem:int = (_repeatCount - _timer.currentCount) % 60;
			trace(minRem + ":" + secRem);

			minutes.text = "0" + minRem.toString() + " : ";
			if (secRem<10)
			{
				seconds.text = "0" + secRem.toString();
			}
			else
			{
				seconds.text = secRem.toString();
			}

			if (minutes.text == "00 : " && seconds.text == "00")
			{
				timerHasFinished = true;
			}

			this.addChild(headline);
			this.addChild(minutes);
			this.addChild(seconds);
		}
	}
}