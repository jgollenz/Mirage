package 
{

	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.xml.*;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;
	import fl.motion.Color;
	import flash.text.TextFormat;


	public class Weather extends MovieClip
	{

		private var _xmlData:XML;
		private var _currentFace:String;
		private var _weatherToday:MovieClip = new MovieClip  ;
		private var textFormat:TextFormat = new TextFormat();
		private var textHeadline:TextFormat = new TextFormat();
		private var textToday:TextFormat = new TextFormat();
		private var champagne = new Champagne();
		private var state:TextField = new TextField();
		private var text:TextField = new TextField();
		private var temp:TextField = new TextField();
		private var maxText:TextField = new TextField();
		private var minText:TextField = new TextField();
		private var max:TextField = new TextField();
		private var min:TextField = new TextField();
		private var day1:TextField = new TextField();
		private var day2:TextField = new TextField();
		private var day3:TextField = new TextField();
		private var day4:TextField = new TextField();
		private var day1min:TextField = new TextField();
		private var day2min:TextField = new TextField();
		private var day3min:TextField = new TextField();
		private var day4min:TextField = new TextField();
		private var day1max:TextField = new TextField();
		private var day2max:TextField = new TextField();
		private var day3max:TextField = new TextField();
		private var day4max:TextField = new TextField();


		public function Weather():void
		{


			loadXML("http://weather.yahooapis.com/forecastrss?w=548536&u=c");


		}

		public function loadXML(xmlURL:String):void
		{
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(xmlURL);

			loader.load(request);
			loader.addEventListener(Event.COMPLETE, loadData);
		}

		private function loadData(event:Event):void
		{

			_xmlData = new XML(event.currentTarget.data);

			var yweather:Namespace = new Namespace("http://xml.weather.yahoo.com/ns/rss/1.0");
			var day:String = _xmlData.channel.item.yweather::forecast[0]. @ day;
			var codeToday:String = _xmlData.channel.item.yweather::forecast[0]. @ code;
			var codePicture:String = _xmlData.channel.item.yweather::condition. @ code;
			var codeDay1:String = _xmlData.channel.item.yweather::forecast[1]. @ code;
			var codeDay2:String = _xmlData.channel.item.yweather::forecast[2]. @ code;
			var codeDay3:String = _xmlData.channel.item.yweather::forecast[3]. @ code;
			var codeDay4:String = _xmlData.channel.item.yweather::forecast[4]. @ code;
			var _weatherToday:MovieClip = new MovieClip();

			
			var sizeOfNextDays:Number = 10;		//How large the next days are displayed
			
			var widthNextDays:Number = 50;			//width of the NextDay TextFields
			var widthNextDaysMinMax:Number = 30;	//width of the NextDayMin and NextDayMax TextFields
			
			var xNextDays:Number = 10;		//First column ... which day
			var xNextDaysMin:Number = 70;	//Second column ... min degrees
			var xNextDaysMax:Number = 105;	//Third column ... max degrees
			
			var yNextDay1:Number = 220;		//First row	... first day
			var yNextDay2:Number = 240;		//Second row ... second day
			var yNextDay3:Number=260;		//Third row ... third day
			var yNextDay4:Number=280;		//Fourth row ... fourth day

			textFormat.size = sizeOfNextDays;
			textFormat.font = champagne.fontName;
			textFormat.color = 0xFFFFFF;

			textHeadline.size = 35;
			textHeadline.font = champagne.fontName;
			textHeadline.color = 0xFFFFFF;

			textToday.size = 17;
			textToday.font = champagne.fontName;
			textToday.color = 0xFFFFFF;


			state.defaultTextFormat = textHeadline;
			state.embedFonts = true;
			state.antiAliasType = AntiAliasType.ADVANCED;
			state.x = 10;
			state.y = 70;
			state.width = 175;

			text.defaultTextFormat = textToday;
			text.embedFonts = true;
			text.antiAliasType = AntiAliasType.ADVANCED;
			text.x = 80;
			text.y = 120;
			text.width = 355;

			temp.defaultTextFormat = textToday;
			temp.embedFonts = true;
			temp.antiAliasType = AntiAliasType.ADVANCED;
			temp.x = 10;
			temp.y = 120;
			temp.width = 120;

			minText.defaultTextFormat = textToday;
			minText.embedFonts = true;
			minText.antiAliasType = AntiAliasType.ADVANCED;
			minText.x = 10;
			minText.y = 150;
			minText.width = 50;
			minText.text = "Min:";

			min.defaultTextFormat = textToday;
			min.embedFonts = true;
			min.antiAliasType = AntiAliasType.ADVANCED;
			min.x = 50;
			min.y = 150;
			min.width = 80;

			maxText.defaultTextFormat = textToday;
			maxText.embedFonts = true;
			maxText.antiAliasType = AntiAliasType.ADVANCED;
			maxText.x = 10;
			maxText.y = 180;
			maxText.width = 50;
			maxText.text = "Max:";

			max.defaultTextFormat = textToday;
			max.embedFonts = true;
			max.antiAliasType = AntiAliasType.ADVANCED;
			max.x = 50;
			max.y = 180;
			max.width = 80;

			day1.defaultTextFormat = textFormat;
			day1.embedFonts = true;
			day1.antiAliasType = AntiAliasType.ADVANCED;
			day1.x = xNextDays;
			day1.y = yNextDay1;
			day1.width = widthNextDays;


			day2.defaultTextFormat = textFormat;
			day2.embedFonts = true;
			day2.antiAliasType = AntiAliasType.ADVANCED;
			day2.x = xNextDays;
			day2.y = yNextDay2;
			day2.width = widthNextDays;

			day3.defaultTextFormat = textFormat;
			day3.embedFonts = true;
			day3.antiAliasType = AntiAliasType.ADVANCED;
			day3.x = xNextDays;
			day3.y = yNextDay3;
			day3.width = widthNextDays;

			day4.defaultTextFormat = textFormat;
			day4.embedFonts = true;
			day4.antiAliasType = AntiAliasType.ADVANCED;
			day4.x = xNextDays;
			day4.y = yNextDay4;
			day4.width = widthNextDays;

			day1min.defaultTextFormat = textFormat;
			day1min.embedFonts = true;
			day1min.antiAliasType = AntiAliasType.ADVANCED;
			day1min.x = xNextDaysMin;
			day1min.y = yNextDay1;
			day1min.width = widthNextDaysMinMax;

			day1max.defaultTextFormat = textFormat;
			day1max.embedFonts = true;
			day1max.antiAliasType = AntiAliasType.ADVANCED;
			day1max.x = xNextDaysMax;
			day1max.y = yNextDay1;
			day1max.width = widthNextDaysMinMax;

			day2min.defaultTextFormat = textFormat;
			day2min.embedFonts = true;
			day2min.antiAliasType = AntiAliasType.ADVANCED;
			day2min.x = xNextDaysMin;
			day2min.y = yNextDay2;
			day2min.width = widthNextDaysMinMax;

			day2max.defaultTextFormat = textFormat;
			day2max.embedFonts = true;
			day2max.antiAliasType = AntiAliasType.ADVANCED;
			day2max.x = xNextDaysMax;
			day2max.y = yNextDay2;
			day2max.width = widthNextDaysMinMax;

			day3min.defaultTextFormat = textFormat;
			day3min.embedFonts = true;
			day3min.antiAliasType = AntiAliasType.ADVANCED;
			day3min.x = xNextDaysMin;
			day3min.y = yNextDay3;
			day3min.width = widthNextDaysMinMax;

			day3max.defaultTextFormat = textFormat;
			day3max.embedFonts = true;
			day3max.antiAliasType = AntiAliasType.ADVANCED;
			day3max.x = xNextDaysMax;
			day3max.y = yNextDay3;
			day3max.width = widthNextDaysMinMax;

			day4min.defaultTextFormat = textFormat;
			day4min.embedFonts = true;
			day4min.antiAliasType = AntiAliasType.ADVANCED;
			day4min.x = xNextDaysMin;
			day4min.y = yNextDay4;
			day4min.width = widthNextDaysMinMax;

			day4max.defaultTextFormat = textFormat;
			day4max.embedFonts = true;
			day4max.antiAliasType = AntiAliasType.ADVANCED;
			day4max.x = xNextDaysMax;
			day4max.y = yNextDay4;
			day4max.width = widthNextDaysMinMax;


			state.text = _xmlData.channel.yweather::location. @ city;
			text.text = _xmlData.channel.item.yweather::condition. @ text;
			temp.text = _xmlData.channel.item.yweather::condition. @ temp + " °C";
			min.text = _xmlData.channel.item.yweather::forecast[0]. @ low + " °C";
			max.text = _xmlData.channel.item.yweather::forecast[0]. @ high + " °C";
			day1min.text = _xmlData.channel.item.yweather::forecast[1]. @ low + " °C";
			day1max.text = _xmlData.channel.item.yweather::forecast[1]. @ high + " °C";
			day2max.text = _xmlData.channel.item.yweather::forecast[2]. @ high + " °C";
			day2min.text = _xmlData.channel.item.yweather::forecast[2]. @ low + " °C";
			day3max.text = _xmlData.channel.item.yweather::forecast[3]. @ high + " °C";
			day3min.text = _xmlData.channel.item.yweather::forecast[3]. @ low + " °C";
			day4max.text = _xmlData.channel.item.yweather::forecast[4]. @ high + " °C";
			day4min.text = _xmlData.channel.item.yweather::forecast[4]. @ low + " °C";


			addChild(state);
			addChild(text);
			addChild(temp);
			addChild(minText);
			addChild(min);
			addChild(maxText);
			addChild(max);
			addChild(day1);
			addChild(day2);
			addChild(day3);
			addChild(day4);
			addChild(day1min);
			addChild(day1max);
			addChild(day2min);
			addChild(day2max);
			addChild(day3min);
			addChild(day3max);
			addChild(day4min);
			addChild(day4max);

			addChild(_weatherToday);
			_weatherToday.x = 100;
			_weatherToday.y = 30;


			switch (day)
			{
				case "Sun" :
					day1.text = "Monday";
					day2.text = "Tuesday";
					day3.text = "Wednesday";
					day4.text = "Thursday";
					break;
				case "Mon" :
					day1.text = "Tuesday";
					day2.text = "Wednesday";
					day3.text = "Thursday";
					day4.text = "Friday";
					break;
				case "Tue" :
					day1.text = "Wednesday";
					day2.text = "Thursday";
					day3.text = "Friday";
					day4.text = "Saturday";
					break;
				case "Wed" :
					day1.text = "Thursday";
					day2.text = "Friday";
					day3.text = "Saturday";
					day4.text = "Sunday";
					break;
				case "Thu" :
					day1.text = "Friday";
					day2.text = "Saturday";
					day3.text = "Sunday";
					day4.text = "Monday";
					break;
				case "Fri" :
					day1.text = "Saturday";
					day2.text = "Sunday";
					day3.text = "Monday";
					day4.text = "Tuesday";
					break;
				case "Sat" :
					day1.text = "Sunday";
					day2.text = "Monday";
					day3.text = "Tuesday";
					day4.text = "Wednesday";
					break;
			}

			switch (codePicture)
			{
				case "28" :
				case "30" :
					var weather01:weather01 = new Weather01();
					_weatherToday.addChild(weather01);
					break;

				case "34" :
				case "32" :
				case "36" :
					var weather02:weather02 = new Weather02();
					_weatherToday.addChild(weather02);
					break;

				case "33" :
					var weather11:weather11 = new Weather11();
					_weatherToday.addChild(weather11);
					break;

				case "0" :
				case "1" :
				case "2" :
				case "4" :
					var weather03:weather03 = new Weather03();
					_weatherToday.addChild(weather03);
					break;

				case "5" :
				case "6" :
				case "7" :
				case "8" :
				case "9" :
				case "19" :
					var weather04:weather04 = new Weather04();
					_weatherToday.addChild(weather04);
					break;

				case "11" :
				case "12" :
					var weather05:weather05 = new Weather05();
					_weatherToday.addChild(weather05);
					break;

				case "13" :
				case "14" :
				case "15" :
				case "16" :
				case "41" :
				case "43" :
					var weather06:weather06 = new Weather06();
					_weatherToday.addChild(weather05);
					break;

				case "3" :
				case "37" :
				case "38" :
				case "39" :
					var weather10:weather10 = new Weather10();
					_weatherToday.addChild(weather10);
					break;
			}
		}
	}
}