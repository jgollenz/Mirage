package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	import flash.text.TextField;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;


	public class Newsfeed extends MovieClip
	{

		private var _rssLoader:URLLoader = new URLLoader();
		private var _rssURL:URLRequest = new URLRequest("http://derStandard.at/?page=rss&ressort=Seite1");
		private var date00:TextField = new TextField();
		private var date01:TextField = new TextField();
		private var date02:TextField = new TextField();
		private var title00:TextField = new TextField();
		private var title01:TextField = new TextField();
		private var title02:TextField = new TextField();
		private var description00:TextField = new TextField();
		private var description01:TextField = new TextField();
		private var description02:TextField = new TextField();
		private var textFormat:TextFormat = new TextFormat();
		private var champagne = new Champagne();



		public function Newsfeed()
		{
			_rssLoader.addEventListener(Event.COMPLETE, rssLoaded);
			_rssLoader.load(_rssURL);
		}


		public function rssLoaded(evt:Event):void
		{
			var _rssXML = XML(_rssLoader.data);
			trace(_rssXML);

			textFormat.size = 17;
			textFormat.font = champagne.fontName;
			textFormat.color = 0xFFFFFF;

			date00.defaultTextFormat = textFormat;
			date00.embedFonts = true;
			date00.antiAliasType = AntiAliasType.ADVANCED;
			date00.x = 10;
			date00.y = 70;
			date00.width = 490;

			title00.defaultTextFormat = textFormat;
			title00.embedFonts = true;
			title00.antiAliasType = AntiAliasType.ADVANCED;
			title00.multiline = true;
			title00.autoSize = "left";
			title00.wordWrap = true;
			title00.x = 10;
			title00.y = 100;
			title00.width = 490;

			description00.defaultTextFormat = textFormat;
			description00.embedFonts = true;
			description00.antiAliasType = AntiAliasType.ADVANCED;
			description00.multiline = true;
			description00.autoSize = "left";
			description00.wordWrap = true;
			description00.x = 10;
			description00.y = 150;
			description00.width = 490;
			description00.height = 200;

			date01.defaultTextFormat = textFormat;
			date01.embedFonts = true;
			date01.antiAliasType = AntiAliasType.ADVANCED;
			date01.x = 10;
			date01.y = 250;
			date01.width = 500;

			title01.defaultTextFormat = textFormat;
			title01.embedFonts = true;
			title01.antiAliasType = AntiAliasType.ADVANCED;
			title01.multiline = true;
			title01.autoSize = "left";
			title01.wordWrap = true;
			title01.x = 10;
			title01.y = 280;
			title01.width = 490;

			description01.defaultTextFormat = textFormat;
			description01.embedFonts = true;
			description01.antiAliasType = AntiAliasType.ADVANCED;
			description01.multiline = true;
			description01.autoSize = "left";
			description01.wordWrap = true;
			description01.x = 10;
			description01.y = 330;
			description01.width = 490;
			description01.height = 100;

			date02.defaultTextFormat = textFormat;
			date02.embedFonts = true;
			date02.antiAliasType = AntiAliasType.ADVANCED;
			date02.x = 10;
			date02.y = 430;
			date02.width = 490;

			title02.defaultTextFormat = textFormat;
			title02.embedFonts = true;
			title02.antiAliasType = AntiAliasType.ADVANCED;
			title02.multiline = true;
			title02.autoSize = "left";
			title02.wordWrap = true;
			title02.x = 10;
			title02.y = 460;
			title02.width = 490;

			description02.defaultTextFormat = textFormat;
			description02.embedFonts = true;
			description02.antiAliasType = AntiAliasType.ADVANCED;
			description02.multiline = true;
			description02.autoSize = "left";
			description02.wordWrap = true;
			description02.x = 10;
			description02.y = 510;
			description02.width = 490;
			description02.height = 200;

			date00.text = _rssXML.channel.item[0].pubDate.substr(0,22);
			title00.text = _rssXML.channel.item[0].title;
			description00.text = _rssXML.channel.item[0].description;

			date01.text = _rssXML.channel.item[1].pubDate.substr(0,22);
			title01.text = _rssXML.channel.item[1].title;
			description01.text = _rssXML.channel.item[1].description;

			date02.text = _rssXML.channel.item[2].pubDate.substr(0,22);
			title02.text = _rssXML.channel.item[2].title;
			description02.text = _rssXML.channel.item[2].description;

			addChild(date00);
			addChild(date01);
			addChild(date02);
			addChild(title00);
			addChild(title01);
			addChild(title02);
			addChild(description00);
			addChild(description01);
			addChild(description02);


		}



	}
}