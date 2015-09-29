/**
 * Created by Administrator on 2014/10/3 0003.
 */
package game.manager {
    import com.singleton.Singleton;

    import starling.utils.AssetManager;

    public class LoginAssets extends AssetManager {
        public static function get instance():AssetManager {
            return Singleton.getInstance(AssetManager) as AssetManager;
        }
    }
}
