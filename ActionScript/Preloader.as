package
{
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class Preloader
    {
        public var urlLoader:URLLoader;
        public var response:Array = new Array();
        public var callingClass:Object;
        public var numFiles:uint;
        private var counter:uint;

        public function Preloader(callingClass:Object, numfiles:uint)
        {
            this.callingClass = callingClass;
            this.numFiles = numFiles;
        }

        public function load(name:String):void
        {
            var request:URLRequest = new URLRequest(name);
            urlLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, onLoad);
            urlLoader.load(request);
        }

        public function onLoad(event:Event):void
        {
            response[counter] = event.currentTarget.data;
            if(numFiles == counter) {
                callingClass.start();
            } else {
                counter++;
            }
        }
    }
}