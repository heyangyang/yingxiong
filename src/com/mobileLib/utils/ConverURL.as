package com.mobileLib.utils
{
	import flash.filesystem.File;
	import flash.utils.Dictionary;

	public class ConverURL
	{
		public static var down_url : String;
		public static var down_list : Array = [];
		public static var update_dic : Dictionary = new Dictionary();
		private static var slist : Dictionary = new Dictionary();
		public static var AssetsRoot : String;


		public static function conver(url : String) : File
		{
			url = AssetsRoot + url;
			var file : File = slist[url];
			if (file)
				return file;
			file = File.applicationDirectory.resolvePath(url);
			if (!file.exists)
				trace(file.nativePath);
			slist[url] = file;
			return file;
		}
	}
}
