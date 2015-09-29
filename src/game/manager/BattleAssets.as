/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-21
 * Time: 下午3:40
 * To change this template use File | Settings | File Templates.
 */
package game.manager
{
	import com.singleton.Singleton;

	import starling.utils.AssetManager;

	/**
		 * 战斗资源库
		 * @author Administrator
		 *
		 */
	public class BattleAssets extends AssetManager
	{
		public static function get instance():BattleAssets
		{
			return Singleton.getInstance(BattleAssets) as BattleAssets;
		}

	}

}
