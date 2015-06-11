package 
{
	import flash.display.MovieClip;
	import Preloader;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;


	public class Scheduler extends MovieClip
	{

		public var lessonsRaw:Array = new Array();
		public var lessons:Array = new Array();
		var now:Now;
		var schedulerWidget:SchedulerWidget;
		public var callingClass:Object;



		public function Scheduler(now:Now, callingClass:Object)
		{
			this.now = now;
			this.callingClass = callingClass;
		}


		public var preloader:Preloader = new Preloader(this,1);

		public function Controller()
		{
			preloader.load('http://almaty.fh-joanneum.at/stundenplan/search.php?q=IMA+2013+-G2+-G3');
		}
		//Link zum .ics file;


		public function start():void
		{
			trace("NOW: "+now.year, now.month, now.dayOfMonth);
			var patternRaw:RegExp = new RegExp("BEGIN.+\n.+\n.+\n.+(?="+"IMA2013"+").+\n.+\n.+(?=:):"+now.year+now.month+"0"+now.dayOfMonth+".*\n.+\n.+\n","g");
			var patternLesson:RegExp = /.+(?=:):([^\\|\n]+)\\,\s([^\\]+)\\,\s(PR|VO|G1)[^:]+:(.+)[^:]+:(.+)\n[^:]+:(\w\.\w{2}\d{1,3}\.\w?\d{2,3})\s(\w{1,3}\d{2})/;
			var patternUniqueID:RegExp = /UID:IMA2013_(\d+)/;

			var result:Array = patternRaw.exec(preloader.response[0]);//hier gehört eigentlich while schleife, wegen möglicher mehrerr files

			//Get first file contents
			while (result != null)
			{
				trace(result.index, " - ", result);
				lessonsRaw.push(result);
				var matchedUniqueID:Object = patternUniqueID.exec(result.toString());
				var matchedLesson:Object = patternLesson.exec(result.toString());
				var newLesson:Lesson = new Lesson(matchedLesson[1],matchedLesson[2],matchedLesson[3],matchedLesson[4],matchedLesson[5],matchedLesson[6] + " " + matchedLesson[7], matchedUniqueID[1]);
				var uniqueIDalreadyTaken:Boolean=false;
				trace("Scheduler ","Lessons length",lessons.length);
				for (var i:int=0; i<lessons.length; i++) {
					if (lessons[i].getUniqueID==matchedUniqueID) {
						uniqueIDalreadyTaken=true;
					}
				}
				if (uniqueIDalreadyTaken==false) {
					lessons.push(newLesson);
				}
				
				result = patternRaw.exec(preloader.response[0]);
			}

			//schedulerWidget = new SchedulerWidget(lessons,callingClass);

			var champagne = new Champagne();
			var textFormat:TextFormat = new TextFormat();
			var textField:TextField = new TextField();


			textFormat.size = 17;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.font = champagne.fontName;
			textField.defaultTextFormat = textFormat;
			textField.embedFonts = true;
			textField.antiAliasType = AntiAliasType.ADVANCED;

			//textField.setTextFormat(textFormat);
			//textField.text = "default";
			trace(lessons.length);
			for (var i:int=0; i<lessons.length; i++)
			{
				textField.text = textField.text + lessons[i].toString();
			}

			textField.textColor = 0xFFFFFF;
			textField.x = 10;
			textField.y = 70;
			textField.width = 515;
			textField.height = 800;
			addChild(textField);
		}

	}
}