﻿package 
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
		private var link00Loader:URLLoader = new URLLoader();
		private var link01Loader:URLLoader = new URLLoader();
		private var link02Loader:URLLoader = new URLLoader();
		private var _rssURL:URLRequest = new URLRequest("http://derStandard.at/?page=rss&ressort=Web");
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
		private var headlineFormat:TextFormat = new TextFormat();
		private var articleTitleLength:Number = 70;
		private var articleDescriptionLength:Number = 200;
		private var paddingDateTitle:Number=20;
		private var paddingTitleDescription:Number=70;
		private var paddingDescriptionDate:Number=100;
		private var article1:String;
		private var matchedArticle:Object;
		private var article2:String;
		private var article3:String;
		
		//private var patternHtmlCopyText:RegExp = /UID:IMA2013_(\d+)/;
		private var patternHtmlCopyText:RegExp = /<div class="copytext">.+?(?=<\/div>)/;
		//private var champagne = new Champagne();



		public function Newsfeed()
		{
			_rssLoader.addEventListener(Event.COMPLETE, rssLoaded);
			_rssLoader.load(_rssURL);
		}

		public function getArticle(index:Number):String 
		{
			switch (index)
			{
				case 1:
					return this.article1;
					break;
				case 2: 
					return this.article2;
					break;
				case 3: 
					return this.article3;
					break;
				default:
					return this.article1;
			}
		}
		
		private function linkLoaded(e:Event):void
		{
			//trace("THIS SHOULD BE HTML TEXT: "+link00Loader.data);
			/*article1=link00Loader.data;
			matchedArticle= patternHtmlCopyText.exec(article1);
			trace("THIS SHOULD BE MATCHED HTML: ", matchedArticle)
			article1 = matchedArticle.toString();*/
			switch (e.target) 
			{
				case link00Loader:
					article1 = link00Loader.data;
					matchedArticle = patternHtmlCopyText.exec(article1);
					article1 = matchedArticle.toString();
					break;
				case link01Loader:
					article2= link01Loader.data;
					matchedArticle = patternHtmlCopyText.exec(article2);
					article2 = matchedArticle.toString();
					break;
				case link02Loader:
					article3 = link02Loader.data;
					matchedArticle = patternHtmlCopyText.exec(article3);
					article3 = matchedArticle.toString();
					break;
			}
		}
		
		public function rssLoaded(evt:Event):void
		{
			var _rssXML = XML(_rssLoader.data);
			//trace(_rssXML);
			
			var link00:URLRequest = new URLRequest(_rssXML.channel.item[0].link);
			link00Loader.addEventListener(Event.COMPLETE, linkLoaded);
			link00Loader.load(link00);
			var link01:URLRequest = new URLRequest(_rssXML.channel.item[1].link);
			link01Loader.addEventListener(Event.COMPLETE, linkLoaded);
			link01Loader.load(link01);
			var link02:URLRequest = new URLRequest(_rssXML.channel.item[2].link);
			link02Loader.addEventListener(Event.COMPLETE, linkLoaded);
			link02Loader.load(link02);
			
			headlineFormat.size = 20;
			headlineFormat.font = "Orator Std";
			headlineFormat.color = 0xFFFFFF;
						
			textFormat.size = 15;
			textFormat.font = "Orator Std";
			textFormat.color = 0xFFFFFF;

			date00.defaultTextFormat = textFormat;
			date00.antiAliasType = AntiAliasType.ADVANCED;
			date00.x = 10;
			date00.y = 70;
			date00.width = 490;

			title00.defaultTextFormat = headlineFormat;
			title00.antiAliasType = AntiAliasType.ADVANCED;
			title00.multiline = true;
			title00.autoSize = "left";
			title00.wordWrap = true;
			title00.x = 10;
			title00.y = date00.y +paddingDateTitle;
			title00.width = 490;

			description00.defaultTextFormat = textFormat;
			description00.antiAliasType = AntiAliasType.ADVANCED;
			description00.multiline = true;
			description00.autoSize = "left";
			description00.wordWrap = true;
			description00.x = 10;
			description00.y = title00.y+paddingTitleDescription;
			description00.width = 490;
			description00.height = 200;

			date01.defaultTextFormat = textFormat;
			date01.antiAliasType = AntiAliasType.ADVANCED;
			date01.x = 10;
			date01.y = description00.y+paddingDescriptionDate;
			date01.width = 500;

			title01.defaultTextFormat = headlineFormat;
			title01.antiAliasType = AntiAliasType.ADVANCED;
			title01.multiline = true;
			title01.autoSize = "left";
			title01.wordWrap = true;
			title01.x = 10;
			title01.y = date01.y +paddingDateTitle;
			title01.width = 490;

			description01.defaultTextFormat = textFormat;
			description01.antiAliasType = AntiAliasType.ADVANCED;
			description01.multiline = true;
			description01.autoSize = "left";
			description01.wordWrap = true;
			description01.x = 10;
			description01.y = title01.y+paddingTitleDescription;
			description01.width = 490;
			description01.height = 100;

			date02.defaultTextFormat = textFormat;
			date02.antiAliasType = AntiAliasType.ADVANCED;
			date02.x = 10;
			date02.y = description01.y+paddingDescriptionDate;
			date02.width = 490;

			title02.defaultTextFormat = headlineFormat;
			title02.antiAliasType = AntiAliasType.ADVANCED;
			title02.multiline = true;
			title02.autoSize = "left";
			title02.wordWrap = true;
			title02.x = 10;
			title02.y = date02.y +paddingDateTitle;
			title02.width = 490;

			description02.defaultTextFormat = textFormat;
			description02.antiAliasType = AntiAliasType.ADVANCED;
			description02.multiline = true;
			description02.autoSize = "left";
			description02.wordWrap = true;
			description02.x = 10;
			description02.y = title02.y+paddingTitleDescription;
			description02.width = 490;
			description02.height = 200;

			date00.text = _rssXML.channel.item[0].pubDate.substr(0,22);
			title00.text = _rssXML.channel.item[0].title.substr(0,articleTitleLength);
			description00.text = _rssXML.channel.item[0].description.substr(0,articleDescriptionLength);
			
			
			date01.text = _rssXML.channel.item[1].pubDate.substr(0,22);
			title01.text = _rssXML.channel.item[1].title.substr(0,articleTitleLength);
			description01.text = _rssXML.channel.item[1].description.substr(0,articleDescriptionLength);
			

			date02.text = _rssXML.channel.item[2].pubDate.substr(0,22);
			title02.text = _rssXML.channel.item[2].title.substr(0,articleTitleLength);
			description02.text = _rssXML.channel.item[2].description.substr(0,articleDescriptionLength);
			
			
			trace("THIS IS THE LINK:", _rssXML.channel.item[0].link);
			
			if((_rssXML.channel.item[0].title).toString().length>articleTitleLength)
			{
				title00.text+="...";
			}
			if((_rssXML.channel.item[1].title).toString().length>articleTitleLength)
			{
				title01.text+="...";
			}
			if((_rssXML.channel.item[2].title).toString().length>articleTitleLength)
			{
				title02.text+="...";
			}
			
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