﻿package com.langue
{
	import com.singleton.Singleton;
	import com.utils.Constants;
	
	import game.data.FontJFData;

	/**
	 *文字过滤
	 * @author Michael
	 *
	 */
	public class WordFilter
	{
		private var keyWords : Array; // 正则组
		private var COUNT : int = 0; // 正则数量

		/**
		 * 文字过滤器
		 * @param	words
		 * @return
		 */
		public function filter(words : String) : String
		{
			var tmp_str : String;

			for (var i : int = 0; i < COUNT; i++)
			{
				tmp_str = keyWords[i];

				if (words.indexOf(tmp_str) >= 0)
				{
					words = words.replace(tmp_str, "**");
					continue;
				}
			}
			return words;
		}

		/**
		 * 设置过滤库列表
		 * @param	dirtyWordList
		 */
		public function init(wordList : String) : void
		{
//			wordList = FontJFData.changeJ2F(wordList);
			var _wordList : Array = wordList.split(",");
			keyWords = [];
			var tmp_str : String;

			for (var i : int = 0; i < COUNT; i++)
			{
				tmp_str = _wordList[i];

				if (tmp_str == "")
					continue;
				keyWords.push(tmp_str);
			}
			COUNT = keyWords.length;
		}

		public static function get instance() : WordFilter
		{
			return Singleton.getInstance(WordFilter) as WordFilter;
		}
	}
}


