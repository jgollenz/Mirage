package  {
	
	public class Lesson {
	
		var lessonName:String;
		var lecturer:String;
		var lessonType:String;
		var lessonStart:String;
		var lessonEnd:String;
		var lessonLocation:String;
		var lessonUniqueID:String;
		var startHour:String
		var startMinute:String
		var endHour:String
		var endMinute

		public function Lesson(lessonName:String, lecturer:String, lessonType:String,
							   lessonStart:String, lessonEnd:String, lessonLocation:String, lessonUniqueID:String) {
			
			this.lessonName=lessonName;
			this.lecturer=lecturer;
			this.lessonType=lessonType;
			this.lessonStart=lessonStart;
			this.lessonEnd=lessonEnd;
			this.lessonLocation=lessonLocation;
			this.lessonUniqueID=lessonUniqueID;
			
		}
		
		public function toString():String {
			
			startHour = lessonStart.slice(9,11);
			startMinute =lessonStart.slice(11,13);
			endHour = lessonEnd.slice(9,11);
			endMinute =lessonEnd.slice(11,13);
			//trace(this.lessonName, this.lecturer, this.lessonType, this.lessonStart, this.lessonEnd);
			return this.lessonName+", "+ this.lessonType+"\n"+ this.lecturer+"\n"+this.lessonLocation+"\n"+this.startHour+":"+this.startMinute+" - "+this.endHour+":"+this.endMinute+"\n \n\n";
		}
		
		public function getUniqueID():String {
			return lessonUniqueID;
		}

	}
	
}
