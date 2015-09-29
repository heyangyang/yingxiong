/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-8
 * Time: 上午11:57
 * To change this template use File | Settings | File Templates.
 */
package game.fight
{
    import com.scene.SceneMgr;
    import com.sound.SoundManager;
    import com.utils.Constants;
    
    import game.data.HeroData;
    import game.data.RoleShow;
    import game.data.SkillData;
    import game.hero.Hero;
    import game.manager.AssetMgr;
    import game.manager.BattleAssets;
    import game.manager.BattleHeroMgr;
    import game.net.data.IData;
    import game.net.data.vo.BattleTarget;
    import game.net.data.vo.BattleVo;
    import game.scene.BattleScene;
    
    import org.osflash.signals.ISignal;
    import org.osflash.signals.Signal;
    
    import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;

/*
    *
    * 觉醒技能
    * */
    public class PowerSkill
    {
        private var scene:BattleScene;
        private var battleTarget:Vector.<IData>;
        private var command:BattleVo;
        public var onComplete:ISignal;
        private var photo:Image;
        private var bg:Image;
        /*
        * 觉醒技能
        *
        * */
        public function PowerSkill(skillData:SkillData, battleTarget:Vector.<IData>, command:BattleVo)
        {
            var sponsor:Hero=BattleHeroMgr.instance.hash.getValue(command.sponsor) as Hero;
            this.battleTarget=battleTarget;
            this.command=command;
            scene=SceneMgr.instance.getCurScene() as BattleScene;
            onComplete=new Signal(PowerSkill);
            var half_photo:String =(RoleShow.hash.getValue(sponsor.data.show) as RoleShow).half_photo;

            photo= new Image(BattleAssets.instance.getTexture(half_photo));
            photo.scaleX = photo.scaleY = 1.3;
            bg= new Image(AssetMgr.instance.getTexture("ui_gongyong_heisetongmingding50"));

            var delayTime:Number = 0.5/Constants.speed;
            var tweenTime:Number = 0.6/Constants.speed;
           if(sponsor.data.team == HeroData.RED)
           {
               scene.addEffect(photo, Constants.virtualWidth, Constants.virtualHeight - photo.height);
               Starling.juggler.tween(photo,tweenTime,{x:Constants.virtualWidth-photo.width,transition:Transitions.EASE_IN_OUT_BACK,onComplete:complete1})
               function complete1():void{
                   Starling.juggler.tween(photo,tweenTime,{delay:delayTime,x:Constants.virtualWidth,transition:Transitions.EASE_IN_OUT_BACK})
               }
           }
           else
           {
               photo.scaleX *= -1;
               scene.addEffect(photo,0, Constants.virtualHeight - photo.height);
               Starling.juggler.tween(photo,tweenTime,{x:photo.width,transition:Transitions.EASE_IN_OUT_BACK,onComplete:complete2})

               function complete2():void{
                   Starling.juggler.tween(photo,tweenTime,{x:0,delay:delayTime,transition:Transitions.EASE_IN_OUT_BACK})
               }
           }

            bg.width= Constants.virtualWidth;
            bg.height =Constants.virtualHeight;
            bg.alpha = 0;
            Starling.juggler.tween(bg,tweenTime,{alpha:1,transition:Transitions.EASE_IN_OUT_BACK,onComplete:complete3})

            function complete3():void{
                Starling.juggler.tween(bg,tweenTime,{x:0,delay:delayTime,transition:Transitions.EASE_IN_OUT_BACK,onComplete:skillWordComplate})
            }
            battleTarget=command.targets as Vector.<IData>;
            var len:int=battleTarget.length;

            for (var i:int=0; i < len; i++)
            {
                var battleT:BattleTarget=battleTarget[i] as BattleTarget;
                var target:Hero=BattleHeroMgr.instance.hash.getValue(battleT.id) as Hero;
                scene.addToPowerSkillLayer(target, target.x, target.y);
            }

            SoundManager.instance.playSound("juexingtexiao");

            scene.addToPowerSkillLayer(bg,0,0);
            scene.addToPowerSkillLayer(sponsor, sponsor.x, sponsor.y);
        }

        private function unPowerSkill():void
        {
            if (this.command)
            {
                var battleTarget:Vector.<IData>=this.command.targets as Vector.<IData>;
                var len:int=battleTarget.length;

                for (var i:int=0; i < len; i++)
                {
                    var battleT:BattleTarget=battleTarget[i] as BattleTarget;
                    var target:Hero=BattleHeroMgr.instance.hash.getValue(battleT.id) as Hero;
                    scene.addToRoleLayer(target, target.x, target.y);
                }
                target=BattleHeroMgr.instance.hash.getValue(this.command.sponsor) as Hero;
                scene.addToRoleLayer(target, target.x, target.y);
                this.command=null;
            }
        }

        private function skillWordComplate():void
        {
            photo.removeFromParent(true);
            bg.removeFromParent(true);
            unPowerSkill();
            onComplete.dispatch(this);
        }
    }
}


