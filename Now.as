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

	//Umbenennen in Clock
	public class Now extends Sprite
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
		public var fullDayOfMonth;

		var champagne = new Champagne();
		var textFormatHoursAndMinutes:TextFormat = new TextFormat();
		var textFormatSeconds:TextFormat = new TextFormat();
		var textFormatWeekdayAndDate:TextFormat = new TextFormat();
		var tfHoursAndMinutes:TextField = new TextField();
		var tfSeconds:TextField = new TextField();
		var tfWeekday:TextField = new TextField();
		var tfDate:TextField = new TextField();


		public function Now()
		{

		}

		public function getTime(event:Event):void
		{

			now = new Date();

			if (now.seconds > this.seconds)
			{
				if (now.hours < 10)
				{
					hours = "0" + now.hours;
				}
				else
				{
					hours = now.hours;
				}
				if (now.minutes < 10)
				{
					minutes = "0" + now.minutes;
				}
				else
				{
					minutes = now.minutes;
				}
				if (now.seconds < 10)
				{
					seconds = "0" + now.seconds;
				}
				else
				{
					seconds = now.seconds;
				}
				if (now.day < 10)
				{
					day = "0" + now.day + 1;
				}
				else
				{
					day = now.day + 1;
				}
				if (now.month < 10)
				{
					month = now.month + 1;
					month = "0" + month;
				}
				else
				{
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
						daySpelled = "Thursday";
						break;

					case 5 :
						daySpelled = "Friday";
						break;

					case 6 :
						daySpelled = "Saturday";
						break;

					case 7 :
						daySpelled = "Sunday";
						break;
				}

				switch (now.month)
				{
					case 0 :
						monthSpelled = "january";
						break;

					case 1 :
						monthSpelled = "february";
						break;

					case 2 :
						monthSpelled = "march";
						break;

					case 3 :
						monthSpelled = "april";
						break;

					case 4 :
						monthSpelled = "may";
						break;

					case 5 :
						monthSpelled = "june";
						break;

					case 6 :
						monthSpelled = "july";
						break;

					case 7 :
						monthSpelled = "august";
						break;

					case 8 :
						monthSpelled = "september";
						break;

					case 9 :
						monthSpelled = "october";
						break;

					case 10 :
						monthSpelled = "november";
						break;

					case 11 :
						monthSpelled = "december";
						break;
				}

				year = now.fullYear;
				dayOfMonth = now.date;

				if (dayOfMonth<10)
				{
					fullDayOfMonth = "0" + dayOfMonth;
				}
				else
				{
					fullDayOfMonth = dayOfMonth;
				}
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
				if (now.seconds < 10)
				{
					seconds = "0" + now.seconds;
				}
				else
				{
					seconds = now.seconds;
				}
				if (now.hours < 10)
				{
					hours = "0" + now.hours;
				}
				else
				{
					hours = now.hours;
				}
				if (now.minutes < 10)
				{
					minutes = "0" + now.minutes;
				}
				else
				{
					minutes = now.minutes;
				}
				showTime();
			}
			//var seconds:SecondsText = new SecondsText(minutes);

			//trace (minutes,seconds);
		}


		private function showTime()
		{
			textFormatHoursAndMinutes.size = 40;
			textFormatHoursAndMinutes.align = TextFormatAlign.CENTER;
			textFormatHoursAndMinutes.font = "Orator Std";
			textFormatHoursAndMinutes.color = "0xFFFFFF";

			textFormatSeconds.size = 17;
			textFormatSeconds.align = TextFormatAlign.CENTER;
			textFormatSeconds.font = "Orator Std";
			textFormatSeconds.color = "0xFFFFFF";

			textFormatWeekdayAndDate.size = 20;
			textFormatWeekdayAndDate.align = TextFormatAlign.CENTER;
			textFormatWeekdayAndDate.font = "Orator Std";
			textFormatWeekdayAndDate.color = "0xFFFFFF";


			tfHoursAndMinutes.defaultTextFormat = textFormatHoursAndMinutes;
			//tfHoursAndMinutes.embedFonts = true;
			//tfHoursAndMinutes.antiAliasType = AntiAliasType.ADVANCED;
			trace(now.hours,now.minutes,now.seconds);
			tfHoursAndMinutes.text = this.hours + ":" + this.minutes;
			//tfHoursAndMinutes.textColor = 0xFFFFFF;
			tfHoursAndMinutes.x = 370;
			tfHoursAndMinutes.y = 30;
			tfHoursAndMinutes.autoSize = "left";
			tfHoursAndMinutes.multiline = true;
			//tfHoursAndMinutes.width = 300;
			tfHoursAndMinutes.border = true;

			tfSeconds.defaultTextFormat = textFormatSeconds;
			tfSeconds.text = this.seconds;
			tfSeconds.x = tfHoursAndMinutes.x + tfHoursAndMinutes.width;
			tfSeconds.y = tfHoursAndMinutes.y + 10;
			tfSeconds.autoSize = "left";
			tfSeconds.multiline = true;

			tfWeekday.defaultTextFormat = textFormatWeekdayAndDate;
			tfWeekday.text = this.daySpelled + " " + this.day;// +" "+ this.monthSpelled;
			tfWeekday.autoSize = "left";
			tfWeekday.multiline = true;
			tfWeekday.x = tfHoursAndMinutes.x;
			tfWeekday.y = 90;

			tfDate.defaultTextFormat = textFormatWeekdayAndDate;
			tfDate.text = this.dayOfMonth + ". " + this.monthSpelled + " " + this.year;
			tfDate.autoSize = "left";
			tfDate.multiline = true;
			tfDate.x = tfHoursAndMinutes.x - 10;
			tfDate.y = tfWeekday.y + tfWeekday.height + 5;

			//tfHoursAndMinutes.text = this.daySpelled +", "+this.dayOfMonth+"."+this.month+"."+this.year+"\n"+this.hours + ":" + this.minutes + ":" + this.seconds;

			addChild(tfHoursAndMinutes);
			addChild(tfSeconds);
			addChild(tfWeekday);
			addChild(tfDate);
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