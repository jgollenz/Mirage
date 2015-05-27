package 
{

	import flash.display.MovieClip;
	import flash.events.Event;


	public class MagicMirror extends MovieClip
	{

		var now:Now = new Now();
		var versuch:Scheduler = new Scheduler(now,this);
		var schedulerWidget:SchedulerWidget;


		public function MagicMirror()
		{
			stage.addEventListener(Event.ENTER_FRAME, now.getTime);
			//var seconds:SecondsText = new SecondsText("placeholder");
			addChild(now);

		}
	}

}