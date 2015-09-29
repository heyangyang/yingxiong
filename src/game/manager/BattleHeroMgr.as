
package game.manager
{
    import com.data.HashMap;
    import com.singleton.Singleton;

    import game.data.HeroData;
    import game.hero.Hero;

import starling.utils.AssetManager;

/**
     * 游戏内的英雄数据有，布阵位置索引
     * 战斗内英雄列表
     * @author Administrator
     *
     */
    public class BattleHeroMgr
    {
        /**
         *
         * @return
         */
        public static function get instance():BattleHeroMgr
        {
            return Singleton.getInstance(BattleHeroMgr) as BattleHeroMgr;
        }

        /**
         *
         */
        public function BattleHeroMgr()
        {
            hash=new HashMap();
            otherHash=new HashMap();
        }

        // 创建一个英雄
        /**
         * 游戏内的英雄数据有，布阵位置索引
         * @default
         */
        public var hash:HashMap;

        private var otherHash:HashMap;


        /**
         *
         * @param data
         * @return
         */
        public function createHero(data:HeroData, isSave:Boolean=true,assets:AssetManager = null):Hero
        {
            var hero:Hero=new Hero(data,assets);
            if (isSave)
            {
                hash.put(hero.id, hero);
            }
            else
            {
                otherHash.put(hero.id, hero);
            }
            return hero;
        }

        public function put(key:int, value:Hero):void
        {
            hash.put(key, value);
        }

        /**
         *
         */
        public function dispose():void
        {

            var temp:Vector.<*>=hash.values();
            var len:int=temp.length;
            var hero:Hero;
            for (var i:int=0; i < len; i++)
            {
                hero=temp[i];
                hero.removeFromParent(true);
            }
            hash.clear();

            temp=otherHash.values();
            len=temp.length;
            for (var j:int=0; j < len; j++)
            {
                hero=temp[j];
                hero.removeFromParent(true);
            }
            otherHash.clear();

        }
    }
}
