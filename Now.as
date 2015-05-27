package 
{

	import flash.events.Event;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;
	import fl.motion.Color;

	public class Now extends Sprite //Umbenennen in Clock
	{
		public var now:Date;
		public var hours;
		public var minutes;
		public var seconds = 0;
		public var day;
		public var daySpelled;
		public var month;
		public var monthSpelled;
		public var year;
		public var dayOfMonth;
		
		var champagne = new Champagne();
		var textFormat:TextFormat = new TextFormat();
		var textField:TextField = new TextField();
		

		public function Now()
		{

		}

		public function getTime(event:Event):void
		{

			now = new Date();

			if (now.seconds > this.seconds)
			{
				if (now.hours < 10) {
					hours = "0" + now.hours;
				}else{
					hours = now.hours;
				}if (now.minutes < 10){
					minutes = "0" + now.minutes;
				}else{
					minutes = now.minutes;
				}if (now.seconds < 10){
					seconds = "0" + now.seconds;
				}else{
					seconds = now.seconds;
				}if (now.day<10) {
					day ="0"+now.day+1;
				}else{
					day = now.day+1;
				}if (now.month<10) {
					month=now.month+1;
					month ="0"+month;
				}else{
					month = now.month;
				}
				
				switch (now.day)
				{
				case 1 :
				daySpelled = "Monday";
				break;
				
				case 2 :
				daySpelled = "Tuesday";
				break;

				case 3 :
				daySpelled = "Wednesday";
				break;
				
				case 4 :
				daySpelled = "Friday";
				break;
				
				case 5 :
				daySpelled = "Saturday";
				break;
				
				case 6 :
				daySpelled = "Sunday";
				break;
				
				}
				
				year = now.fullYear;
				dayOfMonth = now.date;
				/*
				switch (dayOfMonth)
				{
				
				case 1 :
				dayOfMonth = dayOfMonth + "st of";
				break;
				
				case 2 :
				dayOfMonth = dayOfMonth + "nd of";
				break;
				
				default :
				dayOfMonth = dayOfMonth + "th of";
				}*/


				showTime();
			}
			
			if (now.seconds < this.seconds)
			{
				if (now.seconds < 10){
					seconds = "0" + now.seconds;
				}else{
					seconds = now.seconds;
				}if (now.hours < 10){
					hours = "0" + now.hours;
				}else{
					hours = now.hours;
				}if (now.minutes < 10){
					minutes = "0" + now.minutes;
				}else{
					minutes = now.minutes;
				}
				
				
				showTime();
			}
			//var seconds:SecondsText = new SecondsText(minutes);

			//trace (minutes,seconds);
		}

		
		private function showTime()
		{
			textFormat.size = 17;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.font = champagne.fontName;
			
			textField.defaultTextFormat = textFormat;
			textField.embedFonts = true;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			trace(now.hours,now.minutes,now.seconds);
			textField.text = this.hours + ":" + this.minutes + ":" + this.seconds+ " - " + this.dayOfMonth+"-"+this.month+"-"+this.year;
			textField.text = this.daySpelled +", "+this.dayOfMonth+"."+this.month+"."+this.year+"\n"+this.hours + ":" + this.minutes + ":" + this.seconds;
			textField.textColor = 0xFFFFFF;
			textField.x = 280;
			textField.y = 70;
			textField.width = 300;
			textField.border = true;
			//textField.borderColor
			addChild(textField);
		}

	}

}





/*
//Stage?
hours_txt.addEventListener(Event.ENTER_FRAME, timehandler);
function timehandler(event:Event):void
{
var now:Date = new Date();
var hours = now.hours;
var minutes = now.minutes;
var seconds = now.seconds;
var day = now.day;
var month = now.month;
var year = now.fullYear;
var dayOfMonth = now.date;


switch (dayOfMonth)
{

case 1 :
dayOfMonth_txt.text = dayOfMonth + "st of";
break;

case 2 :
dayOfMonth_txt.text = dayOfMonth + "nd of";
break;

default :
dayOfMonth_txt.text = dayOfMonth + "th of";
}


switch (day)
{


case 1 :
day = "monday";
break;

case 2 :
day = "tuesday";
break;

case 3 :
day = "wednesday";
break;

case 4 :
day = "friday";
break;

case 5 :
day = "saturday";
break;

case 6 :
day = "sunday";
break;

}

switch (month)
{

case 0 :
month = "january";
break;

case 1 :
month = "february";
break;

case 2 :
month = "march";
break;

case 3 :
month = "april";
break;

case 4 :
month = "may";
break;

case 5 :
month = "june";
break;

case 6 :
month = "july";
break;

case 7 :
month = "august";
break;

case 8 :
month = "september";
break;

case 9 :
month = "october";
break;

case 10 :
month = "november";
break;

case 11 :
month = "december";
break;

}

day_txt.text = day + "";
month_txt.text = month;
year_txt.text = year + "";


if (hours <=12)
{
ampm_txt.text = "am";
}
else
{
ampm_txt.text = "pm";
}
*/