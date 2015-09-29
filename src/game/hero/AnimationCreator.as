package game.hero
{
import com.mobileLib.utils.ConverURL;
import com.singleton.Singleton;

import game.data.BuffData;
import game.data.EffectSoundData;
import game.data.Goods;
import game.data.HeroData;
import game.data.MonsterData;
import game.data.RoleShow;
import game.data.SkillData;
import game.data.TollgateData;
import game.data.WidgetData;
import game.manager.AssetMgr;
import game.manager.BattleAssets;
import game.manager.HeroDataMgr;
import game.view.city.House;

import spriter.AnimationSet;
import spriter.SpriterClip;

import starling.core.Starling;
import starling.display.DisplayObjectContainer;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

/**
     * 战斗角色动画和特效管理器
     * 注意：
     * 1.角色动画和特效全部以骨骼动画实现
     * 2.每次进入战斗即时加载战斗角色及角色身上携带技能对应的特效
     * 3.独立的角色动画和特效资源管理器
     * @author Michael
     */
    public class AnimationCreator
    {

        public static function get instance():AnimationCreator
        {
            return Singleton.getInstance(AnimationCreator) as AnimationCreator;
        }

        /**
         * 创建一个骨骼动画
         * @param animationName    骨骼动画名字
         * @param assests          指定资源库
         * @param autoRelease      是否自动回收资源
         * @param cacheModule    BattleAssets是否纹理缓存模式
         * @return
         */
        public function create(animationName:String, assests:AssetManager, autoRelease:Boolean=false):SpriterClip
        {
            var atlas:TextureAtlas=assests.getTextureAtlas(animationName);
            if(!atlas)
            {
                assests = AssetMgr.instance;
            }
            atlas=assests.getTextureAtlas(animationName);
            if(!atlas)
            {
                assests = BattleAssets.instance;
            }

            atlas=assests.getTextureAtlas(animationName);
            var spriterClip:SpriterClip=new SpriterClip(getAnimationData(animationName, assests), atlas);
            spriterClip.name=animationName;

            if (autoRelease)
            {
                spriterClip.animationComplete.addOnce(onCompleteClip);
                spriterClip.name=animationName;
            }
            Starling.juggler.add(spriterClip);

            return spriterClip;
        }

        /**
         *
         * @param id
         * @param x
         * @param y
         * @param container
         * @param assets
         * @param onComplement
         * @param cacheModule
         * @return
         *
         */
        public function createSecneEffect(id:String, x:int, y:int, container:DisplayObjectContainer, assets:AssetManager=null, onComplement:Function=null):SpriterClip
        {
            var tmp_animation:SpriterClip=create(id, assets);
            tmp_animation.play(id);
            tmp_animation.animation.looping=false;
            tmp_animation.animationComplete.addOnce(aniComplete);
            tmp_animation.x=x;
            tmp_animation.y=y;
            container.addChild(tmp_animation);
            Starling.juggler.add(tmp_animation);

            function aniComplete(sp:SpriterClip):void
            {
                if (onComplement != null)
                    onComplement();
                sp.removeFromParent(true);
            }
            return tmp_animation;
        }

        /**
         *
         * @param animationName
         * @param assests
         * @return
         *
         */
        public function createHouse(animationName:String, assests:AssetManager):House
        {
            var atlas:TextureAtlas=assests.getTextureAtlas(animationName);
            if (!atlas)
            {
                atlas=assests.getTextureAtlas("town");
            }

            if (!atlas)
                return null;
            var spriterClip:House=new House(getAnimationData(animationName, assests), atlas, animationName);
            return spriterClip;
        }

        /**
         * 加载怪物
         * @param tollgate
         * @param callback
         * @param assests
         *
         */
        public function loadMonsters(tollgate:TollgateData, callback:Function, assests:AssetManager):void
        {
            if (tollgate)
            {
                var monsters:Array=tollgate.monsters;
                var len:int=monsters.length;

                for (var i:int=0; i < len; i++)
                {
                    var type:int=monsters[i][0];
                    var monsterData:MonsterData=MonsterData.monster.getValue(type);
                    var role:RoleShow=RoleShow.hash.getValue(monsterData.show) as RoleShow;
                    var path:String=role.avatar;

                    if (monsterData.skill1 > 0)
                        loadSkillRes(assests, monsterData.skill1);

                    if (monsterData.skill2 > 0)
                        loadSkillRes(assests, monsterData.skill2);

                    if (monsterData.skill3 > 0)
                        loadSkillRes(assests, monsterData.skill3);
                    loadHeroEffect(assests, monsterData);
                    assests.enqueue(ConverURL.conver("role/" + path));

                    var half_photo:String =(RoleShow.hash.getValue(monsterData.show) as RoleShow).half_photo;
                    assests.enqueue(ConverURL.conver("portrait/" + half_photo));
                }
            }
            assests.loadQueue(onComplete);

            function onComplete(ratio:Number):void
            {
                if (ratio == 1.0)
                {
                    if (callback != null)
                    {

                        callback();
                    }
                }

            }

        }

        /**
         * 加载对手
         * @param callback
         * @param assests
         *
         */
        public function loadRiv(callback:Function, assests:AssetManager):void
        {
            HeroDataMgr.instance.battleHeros.eachValue(eachValue);

            function eachValue(hero:Object):void
            {
                if (hero.team != HeroData.RED)
                    return;

                var avatar:String=(RoleShow.hash.getValue(hero.show) as RoleShow).avatar;

                var weapon:int=hero.seat1;
                if (weapon > 0) {
                    var goods:Goods = WidgetData.hash.getValue(weapon);
                    if (goods == null)
                        goods = Goods.goods.getValue(weapon);
                    if (goods && goods.avatar) {
                        assests.enqueue(ConverURL.conver("weapon/" +goods.avatar));
                    }
                }

                var path:String="role/" + avatar;

                if (hero.skill1 > 0)
                    loadSkillRes(assests, hero.skill1);

                if (hero.skill2 > 0)
                    loadSkillRes(assests, hero.skill2);

                if (hero.skill3 > 0)
                    loadSkillRes(assests, hero.skill3);
                assests.enqueue(ConverURL.conver(path));

                var half_photo:String =(RoleShow.hash.getValue(hero.show) as RoleShow).half_photo;
                assests.enqueue(ConverURL.conver("portrait/" + half_photo));

                loadHeroEffect(assests, hero as HeroData);
            }

            assests.loadQueue(onCompleteQueue);

            function onCompleteQueue(ratio:Number):void
            {
                if (ratio == 1.0)
                {
                    if (callback != null)
                    {
                        callback();
                    }
                }
            }
        }

        /**
         * 加载玩家已经上阵的英雄
         * @param assests
         *
         */
        public function loadMeSelfBattleHeros(list:Array, assests:AssetManager):void
        {
            var len:int=list.length;
            var hero:HeroData;

            for (var i:int=0; i < len; i++)
            {
                hero=list[i];

                if (hero.seat > 0)
                {
                    loadHeroRes(hero, assests);
                    loadHeroSkillRes(hero, assests);
                }
            }
        }

        /**
         * 加载单个角色技能资源
         * @param hero
         * @param assests
         *
         */
        public function loadHeroSkillRes(hero:HeroData, assests:AssetManager):void
        {
            if (hero.skill1 > 0)
                loadSkillRes(assests, hero.skill1);

            if (hero.skill2 > 0)
                loadSkillRes(assests, hero.skill2);

            if (hero.skill3 > 0)
                loadSkillRes(assests, hero.skill3);
            loadHeroEffect(assests, hero)
        }

        /**
         * 加载单个角色资源
         * @param hero
         * @param assests
         *
         */
        public function loadHeroRes(hero:HeroData, assests:AssetManager):void
        {

            var avatar:String=(RoleShow.hash.getValue(hero.show) as RoleShow).avatar;
            var path:String="role/" + avatar;
            var weapon:int=hero.seat1;
            if (weapon > 0) {
                var goods:Goods = WidgetData.hash.getValue(weapon);
                if (goods == null)
                    goods = Goods.goods.getValue(weapon);
                if (goods && goods.avatar) {
                    assests.enqueue(ConverURL.conver("weapon/" +goods.avatar));
                }
            }
            assests.enqueue(ConverURL.conver(path));
            var half_photo:String =(RoleShow.hash.getValue(hero.show) as RoleShow).half_photo;
            assests.enqueue(ConverURL.conver("portrait/" + half_photo));
        }


        private function onCompleteClip(sp:SpriterClip):void
        {
            sp.dispose();
        }

        public function getAnimationData(animationName:String, assests:AssetManager):Object
        {
            var xml:XML = assests.getXml(animationName);
            if(xml)
            {
                return AnimationSet.generateXML(xml);
            }
            else
            {
                return assests.getObject(animationName);
            }

        }

        private function loadHeroEffect(assets:AssetManager, heroData:HeroData):void
        {
            var role:RoleShow=RoleShow.hash.getValue(heroData.show);
            var skillWord:String=heroData.skillword;
            var effect:String=role.attackEffect;

            if (effect)
            {
                assets.enqueue(ConverURL.conver("skill/" + effect));
            }

            effect=role.underAttackEffect;

            if (effect)
            {
                assets.enqueue(ConverURL.conver("skill/" + effect));
            }
        }


        /**
         * 加载技能光环特效
         * @param assets
         * @param skill
         *
         */
        private function loadSkillRes(assets:AssetManager, skill:int):void
        {
            var skillData:SkillData=SkillData.getSkill(skill);
            var arr:Array=["ringEffect", "attackEffect", "underAttackEffect", "skillEffect", "fireEffect"];
            var sound:EffectSoundData=EffectSoundData.hash.getValue(skillData.skillEffect);

            var len:int=arr.length;

            for (var i:int=0; i < len; i++)
            {
                var key:String=arr[i];
                var effect:String=skillData[key];

                if (effect)
                {
                    assets.enqueue(ConverURL.conver("skill/" + effect));
                    sound && assets.enqueue(ConverURL.conver("skillAudio/" + sound.sound + ".mp3"));
                }
            }
            var cmd:String=skillData.cmd;

            if (cmd.indexOf("set_buff") != -1)
            {
                arr=cmd.split(",");
                var buffID:int=int(arr[arr.length - 2]);

                if (buffID > 0)
                {
                    var buffData:BuffData=BuffData.hash.getValue(buffID);
                    var sound1:EffectSoundData=EffectSoundData.hash.getValue(buffData.buffEffect);
                    var buffEffect:String=buffData.buffEffect;

                    if (buffEffect)
                    {
                        assets.enqueue(ConverURL.conver("skill/" + buffEffect));
                        sound1 && assets.enqueue(ConverURL.conver("skillAudio/" + sound1.sound + ".mp3"));
                    }
                }
            }
        }
    }
}
