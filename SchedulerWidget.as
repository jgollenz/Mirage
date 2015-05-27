package 
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import Preloader;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;

	public class SchedulerWidget extends MovieClip
	{

		var champagne = new Champagne();
		var textFormat:TextFormat = new TextFormat();
		var textField:TextField = new TextField();
		var callingClass:Object;

		public function SchedulerWidget(lessons:Array, callingClass:Object)
		{
			this.callingClass = callingClass;
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
			textField.y = 50;
			textField.width = 515;
			textField.height = 500;
			textField.border = true;

			callingClass.addChild(textField);

		}
	}
}