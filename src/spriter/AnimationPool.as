package spriter
{
    import com.singleton.Singleton;

    public class AnimationPool
    {
        private var _pool:Object=null;

        public static function get instance():AnimationPool
        {
            return Singleton.getInstance(AnimationPool) as AnimationPool;
        }

        public function AnimationPool()
        {
            _pool=new Object();
        }

        public function get pool():Object
        {
            return _pool;
        }

        public function clear():void
        {
            _pool=new Object();
        }

    }
}
