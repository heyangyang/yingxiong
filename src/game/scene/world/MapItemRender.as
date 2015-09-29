package game.scene.world {
    import com.components.RollTips;
    import com.langue.Langue;
    import com.view.View;
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import flash.utils.getDefinitionByName;

    import game.data.MainLineData;
    import game.data.MonsterData;
    import game.data.Val;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.view.uitils.Res;
    import game.view.viewBase.Map_world_101Base;
    import game.view.viewBase.Map_world_102Base;
    import game.view.viewBase.Map_world_103Base;
    import game.view.viewBase.Map_world_104Base;
    import game.view.viewBase.Map_world_10Base;
    import game.view.viewBase.Map_world_11Base;
    import game.view.viewBase.Map_world_12Base;
    import game.view.viewBase.Map_world_13Base;
    import game.view.viewBase.Map_world_14Base;
    import game.view.viewBase.Map_world_15Base;
    import game.view.viewBase.Map_world_16Base;
    import game.view.viewBase.Map_world_17Base;
    import game.view.viewBase.Map_world_1Base;
    import game.view.viewBase.Map_world_2Base;
    import game.view.viewBase.Map_world_3Base;
    import game.view.viewBase.Map_world_4Base;
    import game.view.viewBase.Map_world_5Base;
    import game.view.viewBase.Map_world_6Base;
    import game.view.viewBase.Map_world_7Base;
    import game.view.viewBase.Map_world_8Base;
    import game.view.viewBase.Map_world_9Base;

    import spriter.SpriterClip;

    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.filters.ColorMatrixFilter;

    public class MapItemRender extends Sprite {
        public static const maps:Array = [Map_world_1Base, Map_world_2Base, Map_world_3Base, Map_world_4Base, Map_world_5Base,
                                          Map_world_6Base, Map_world_7Base, Map_world_8Base, Map_world_9Base, Map_world_10Base,
                                          Map_world_11Base, Map_world_12Base, Map_world_13Base, Map_world_14Base, Map_world_15Base,
                                          Map_world_16Base, Map_world_17Base, Map_world_101Base, Map_world_102Base, Map_world_103Base,
                                          Map_world_104Base];
        private var mainData:MainLineData;
        private var view:View;
        private var animation:SpriterClip;
        public var index:int;


        public function MapItemRender() {

        }

        public function set data(value:MainLineData):void {
            mainData = value;
            if (mainData == null){
                return;}

            if (!view) {
                var strName:String = "Map_world_" + (mainData.chapterID) + "Base";
                var resClass:Class = getDefinitionByName("game.view.viewBase::" + strName) as Class;
                view = new resClass();
                addChild(view);
                view["bg"].flatten();
                view["pointname"].text = mainData.chapterName;
            }
            updata();
        }

        private function updata():void {
            var len:int = mainData.chapterScope.length;
            var mianLineData:MainLineData = null;
            var point:DisplayObjectContainer = null;
            var head:Image = null;
            var star:Image = null;
            var headBtn:Button = null;
            this.animation && this.animation.removeFromParent();
            for (var i:int = 0; i < len; i++) {
                mianLineData = mainData.chapterScope[i];
                point = view.getChildByName("point_" + (i + mainData.startIndex)) as DisplayObjectContainer;
                if (mianLineData.boss_type == 2 || mianLineData.boss_type == 3) //boss关卡
                {
                    var monster:MonsterData = MonsterData.monster.getValue(mianLineData.boss_id) as MonsterData;
                    headBtn = point.getChildByName("headBtn") as Button;
                    head = point.getChildByName("head") as Image;
                    if (mianLineData.boss_level > 1) {
                        headBtn.upState = AssetMgr.instance.getTexture((mianLineData.pointID > GameMgr.instance.tollgateID) ? "ui_touxiangdi02_03_2" : "ui_touxiangdi02_03");
                    } else {
                        headBtn.upState = AssetMgr.instance.getTexture((mianLineData.pointID > GameMgr.instance.tollgateID) ? "ui_touxiangdi02_02_2" : "ui_touxiangdi02_02");
                    }

                    if (head) {
                        headBtn.container.addChildAt(head, 0);
                        head.texture = Res.instance.getHeroIconTexture(monster.show);
                    }

                    for (var j:int = 0; j < 3; j++) {
                        star = point.getChildByName("star_" + j) as Image;
                        star.visible = mianLineData.pointID <= GameMgr.instance.tollgateID;
                        star.texture = AssetMgr.instance.getTexture("ui_xingyunxing0" + (((mianLineData.tollgateData.nightmare_star & Math.pow(2,
                                                                                                                                               j)) == 0 ? "2" : "1") + "_tubiao"));
                    }
                    headBtn.addEventListener(Event.TRIGGERED, triggered);
                } else if (mianLineData.boss_type == 1) //小点关卡
                {
                    if (mainData.chapterID > 100) //副本
                    {
                        (point as Button).upState = AssetMgr.instance.getTexture(mianLineData.points_ico);
                        point.filter = (mianLineData.pointID > GameMgr.instance.tollgateID) ? new ColorMatrixFilter(Val.filter) : null;
                    } else //小点关卡
                    {
                        (point as Button).upState = AssetMgr.instance.getTexture((mianLineData.pointID > GameMgr.instance.tollgateID) ? "ui_ditu_guankajiedian02" : "ui_ditu_guankajiedian");
                    }
                    point.addEventListener(Event.TRIGGERED, triggered);
                }
                if (mianLineData.pointID == GameMgr.instance.tollgateID) {
                    if (this.animation == null) {
                        this.animation = AnimationCreator.instance.create("effect_034", AssetMgr.instance);
                        this.animation.play("effect_034");
                        this.animation.animation.looping = true;
                        this.animation.touchable = false;
                    }
                    if (!point.contains(this.animation)) {
                        this.animation.x = point.width * 0.5 - 12;
                        if (point.y < 100) {
                            this.animation.scaleY = -1;
                            this.animation.y = point.height - 15;
                        } else {
                            this.animation.scaleY = 1;
                            this.animation.y = 0;
                        }
                        point.addChild(this.animation);
                        point.parent.setChildIndex(point, point.parent.numChildren - 1);
                    }
                }
            }

//            this.flatten();
        }

        private function triggered(e:Event):void {
            var curName:String = (e.currentTarget as DisplayObject).name;
            if (curName == "headBtn") {
                curName = (e.currentTarget as DisplayObject).parent.name;
            }
            var index:int = uint(curName.split("_")[1]) - mainData.startIndex;
            var curdata:MainLineData = mainData.chapterScope[index] as MainLineData;
            var isOpen:Boolean, isPass:Boolean;
            isOpen = curdata.pointID <= GameMgr.instance.tollgateID;
            isPass = curdata.boss_type == 1 && GameMgr.instance.tollgateID > curdata.pointID;
            if (!isOpen) //主线或者副本未开启
            {
                /*if (this.owner.verticalPageIndex > 0)
                   {
                   if (index == 0) //找上一章节最后一关数据
                   {
                   var lastData:MainLineData=this.owner.dataProvider.getItemAt(this.owner.verticalPageIndex - 1) as MainLineData;
                   curdata=lastData.chapterScope[lastData.chapterScope.length - 1] as MainLineData;
                   }
                   else
                   {
                   curdata=mainData.chapterScope[index - 1] as MainLineData;
                   }
                 }*/
                RollTips.addLangue(Langue.getLangue("onOpen") + (curdata ? curdata.pointName : ""));
                return;
            }
            if (!curdata.isFb && isPass) //主线已经通关不能再打小关卡
            {
                RollTips.addLangue("onPass");
                return;
            }
            if (isOpen) {
                ViewDispatcher.dispatch(EventType.UPDATE_SELECTED_MAINLINE, curdata);
            }
        }

        override public function dispose():void {
            animation && animation.removeFromParent(true);
            view && view.removeFromParent();
            super.dispose();
        }
    }
}
