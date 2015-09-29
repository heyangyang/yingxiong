package game.data
{
	import com.utils.Constants;

	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	public class FontJFData
	{
		private static var jt_vecter : Array
		private static var ft_vecter : Array;
		private static var dic : Dictionary;

		public function FontJFData()
		{
		}

		/**
		 * 简体转繁体
		 * @param str
		 * @return
		 *
		 */
		public static function changeJ2F(str : String) : String
		{

			return str;
		}

		/**
		 * 繁体转简体
		 * @param str
		 * @return
		 *
		 */
		public static function changeF2J(str : String) : String
		{
			/*if (!Constants.isFontFt)
				return str;
			var len : int = str.length;
			var tmp : String;
			var index : int;
			var newStr : String = "";

			for (var i : int = 0; i < len; i++)
			{
				tmp = str.charAt(i)
				index = ft_vecter.indexOf(tmp);

				if (index >= 0)
					newStr += jt_vecter[index];
				else
					newStr += tmp;
			}
			return newStr;*/
            return str;
		}

		/**
		 * 改变简体的一些字体
		 * @param str
		 * @return
		 *
		 */
		public static function changeJtFont(str : String) : String
		{
			/*if (!Constants.isFontFt)
				return str;
			var len : int = str.length;
			var newStr : String = "";

			for (var i : int = 0; i < len; i++)
			{
				newStr += changeFont(str.charAt(i));
			}
			return newStr;*/
            return str;
		}

		private static function changeFont(str : String) : String
		{
			var tmp : String = dic[str];

			if (tmp)
				return tmp;
			return str;
		}

		public static function init(data : String) : void
		{
			dic = new Dictionary();
			jt_vecter = [];
			ft_vecter = [];
			var vector : Array = data.split("\r\n");
			var len : int = vector.length;
			var tmp_arr : Array;
			var tmp_str : String;
			var isReplace : Boolean = false;
			var isJt : Boolean = false;
			var time : int = getTimer();

			for (var i : int = 0; i < len; i++)
			{
				tmp_str = vector[i];

				switch (tmp_str)
				{
					case "replace.txt":
						isReplace = true;
						continue;
						break;
					case "jt.txt":
						isJt = true;
						isReplace = false;
						continue;
						break;
					case "ft.txt":
						isJt = false;
						isReplace = false;
						continue;
						break;
				}

				if (isReplace)
				{
					tmp_arr = tmp_str.split(":");
					dic[tmp_arr[0]] = tmp_arr[1];
				}
				else
				{
					if (isJt)
						jt_vecter = jt_vecter.concat(tmp_str.split(""));
					else
						ft_vecter = ft_vecter.concat(tmp_str.split(""));
				}
			}
		}
	}
}