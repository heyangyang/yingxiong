package game.view.heroHall.view {
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.mvc.interfaces.INotification;
    import com.view.base.event.EventType;

    import flash.geom.Point;
    import flash.geom.Rectangle;

    import feathers.controls.Scroller;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.data.ExpData;
    import game.data.Goods;
    import game.data.HeroData;
    import game.data.SkillData;
    import game.data.Val;
    import game.data.WidgetData;
    import game.dialog.ShowLoader;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.net.data.s.SHeroPotion;
    import game.net.message.EquipMessage;
    import game.view.comm.HeroInfoDialog;
    import game.view.goodsGuide.EquipInfoDlg;
    import game.view.goodsGuide.GoodsEquipOrForgeDlg;
    import game.view.heroHall.HeroDialog;
    import game.view.heroHall.SkillDesDialog;
    import game.view.heroHall.render.HeroCardShow;
    import game.view.heroHall.render.HeroEquipRender;
    import game.view.heroHall.render.HeroExpGridRender;
    import game.view.heroHall.render.HeroLevelRander;
    import game.view.viewBase.EquimentViewBase;

    import spriter.SpriterClip;

    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.filters.ColorMatrixFilter;
    import starling.text.TextField;

    /**
     * 英雄装备版面
     * @author Samule
     */
    public class EquimentView extends EquimentViewBase {
        /**当前英雄数据*/
        private var _currData:HeroData = null;
        /**英雄模型显示*/
        public var _heroAvatar:HeroCardShow = null;
        /**等级*/
        private var _deji:HeroLevelRander = null;
        /**选中*/
        private var _selectedAnimation:SpriterClip;


        public function EquimentView() {
            super();
        }

        /**初始化*/
        override protected function init():void {
            ziliao_Scale9Button.text = Langue.getLangue("hero_Details"); //英雄资料
            zbBtn_Scale9Button.text = Langue.getLangue("autoMakeup"); //自动换装
            cion_equip.touchable = false;

            _selectedAnimation = AnimationCreator.instance.create("effect_012", AssetMgr.instance);
            _selectedAnimation.play("effect_012");
            _selectedAnimation.animation.looping = true;
            //装备列表
            const listLayout:TiledRowsLayout = new TiledRowsLayout();
            listLayout.gap = 5;
            listLayout.paddingTop = 2;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_equip.layout = listLayout;
            list_equip.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_equip.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_equip.itemRendererFactory = tileListItemRendererFactory;

            const listExpLayout:TiledRowsLayout = new TiledRowsLayout();
            listExpLayout.gap = 5;
            listExpLayout.paddingTop = 2;
            listExpLayout.useSquareTiles = false;
            listExpLayout.useVirtualLayout = true;
            listExpLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listExpLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_exp.layout = listExpLayout;
            list_exp.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_exp.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_exp.itemRendererFactory = expListItemRendererFactory;
            list_exp.dataProvider = new ListCollection(Goods.getExpList());

            //英雄模型
            _heroAvatar = new HeroCardShow();
            _heroAvatar.x = 202;
            _heroAvatar.y = 73;
            this.addQuiackChild(_heroAvatar);
//            _heroAvatar.addEventListener(TouchEvent.TOUCH, onSkill); //英雄信息
            _heroAvatar.touchable = true;

//            _starBar = new StarBarRender();
//            _starBar.x = 180;
//            _starBar.y = 115;
//            addQuiackChild(_starBar);

            _deji = new HeroLevelRander();
            _deji.x = 175;
            _deji.y = 375;
            addQuiackChild(_deji);

            list_equip.visible = true;
            list_exp.visible = false;
            btn_equip.visible = true;
            cion_equip.visible = true;
        }

        private function tileListItemRendererFactory():HeroEquipRender {
            var itemRender:HeroEquipRender = new HeroEquipRender(_selectedAnimation);
            itemRender.setSize(98, 98);
            return itemRender;
        }

        private function expListItemRendererFactory():HeroExpGridRender {
            var itemRender:HeroExpGridRender = new HeroExpGridRender();
            itemRender.setSize(98, 98);
            return itemRender;
        }

//        /**查看人物信息*/
//        private function onSkill(e:TouchEvent):void {
//            var touch:Touch = e.getTouch(stage);
//            switch (touch && touch.phase) {
//                case TouchPhase.BEGAN:
//                    var heroData:HeroData = HeroData.hero.getValue(_currData.type);
//                    DialogMgr.instance.isVisibleDialogs(true);
//                    var dia:HeroInfoDialog = DialogMgr.instance.open(HeroInfoDialog, _currData) as HeroInfoDialog;
//                    dia.x = dia.x + 120;
//                    break;
//            }
//        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            this.addViewListener(zbBtn_Scale9Button, Event.TRIGGERED, onAutoEquip);
            this.addViewListener(btn_equip, Event.TRIGGERED, onEquipTitle);
            this.addViewListener(ziliao_Scale9Button, Event.TRIGGERED, onSkill);
        }

        override public function listNotificationName():Vector.<String> {
            var vect:Vector.<String> = new Vector.<String>;
            vect.push(SHeroPotion.CMD);
            return vect;
        }

        override public function handleNotification(_arg1:INotification):void {
            if (_arg1.getName() == String(SHeroPotion.CMD)) {
                var info:SHeroPotion = _arg1 as SHeroPotion;

                if (0 == info.code) {
                    addTips("USE_SUCCESS");
                    if (_currData.level < info.level) {
                        dispatch(EventType.PLAY_HERO_ANIMATION, info.level); //升级
                    } else {
                        dispatch(EventType.UPDATE_HERO_INFO); //没升级加经验
                    }
                } else if (1 == info.code) {
                    addTips("materialNotEnough"); //材料不足
                } else if (2 == info.code) {
                    addTips("maxLevel");
                } else if (127 >= info.code) {
                    addTips("codeError");
                }
            }
            list_exp.dataViewPort.dataProvider_refreshItemHandler();
            ShowLoader.remove();
        }

        private function onSkill(e:Event):void {
            var heroData:HeroData = HeroData.hero.getValue(_currData.type);
            DialogMgr.instance.isVisibleDialogs(true);
            DialogMgr.instance.open(HeroInfoDialog, _currData);
        }

        /**获取物品*/
        private function onGetMertHandler(e:Event):void {
            var goods:Goods = Goods.goods.getValue(_currData.type);
            goods.isPack = false;
            (this.parent as HeroDialog).isVisible = true;
            goods = goods.clone() as Goods;
            goods.Price = 0;
            DialogMgr.instance.open(EquipInfoDlg, goods);
        }

        /**选中更新英雄信息*/
        public function updata(heroData:HeroData):void {
            if (heroData && _currData != heroData) {
                _heroAvatar.updata(heroData);
            }
            if (heroData == null) {
                return;
            }
            _currData = heroData;
            figthNum.text = heroData.getPower.toString();
//            _starBar.updataStar(_currData.foster, 1, 4);
            _heroAvatar.updataStar(_currData.foster);

            updateHeroEquip();

            var nextLevelData:ExpData = ExpData.hash.getValue(_currData.level);
            var nextExp:int = nextLevelData ? nextLevelData.exp : 0;
            updateExp(_currData.exp / nextExp);
            _deji.updata(heroData.level);
        }

        /**
         * 更新经验
         * @param value
         */
        private function updateExp(value:Number):void {
            if (value < 0) {
                value = 0;
            }
            expBar.clipRect = new Rectangle(0, 0, value >= 1 ? 160 : value * 160, 21);
            value = (value * 100) >> 0;
            expTxt.text = value >= 100 ? "N/A" : value + "%";

            list_exp.dataProvider = new ListCollection(Goods.getExpList());
            list_exp.dataViewPort.dataProvider_refreshItemHandler();
        }

        /**
         * 自动换装
         */
        protected function onAutoEquip():void {
            EquipMessage.sendAutoEquip(_currData, _currData.getHeroCurrEquipList());
        }

        /**打开GoodsEquipOrForgeDlg窗口*/
        private function onEquipTitle():void {
            DialogMgr.instance.open(GoodsEquipOrForgeDlg, _currData);
        }

        /**
         * 更新玩家装备
         * @param heroData
         */
        private function updateHeroEquip():void {
            var tmp_arr:Vector.<WidgetData> = _currData.getHeroCurrEquipList();
            var widget_title:WidgetData = tmp_arr.pop();
            list_equip.dataProvider = new ListCollection(tmp_arr);
            showHeroSkill(_currData);

            if (_currData.seat5 > 0) {
                var equip:WidgetData = WidgetData.hash.getValue(_currData.seat5);
                cion_equip.texture = getTexture(equip.picture);
                cion_equip.filter = null;
            } else {
                cion_equip.filter = new ColorMatrixFilter(Val.filter);
            }
            tag_add.visible = widget_title.getBestEquipByHero(_currData) == null ? false : true;
        }

        /**
         * 英雄技能
         * @param heroData
         */
        private function showHeroSkill(heroData:HeroData):void {
            var skillData:SkillData;
            var image:Button = null;
            var text:TextField;
            var arr:Array = [];
            var arrTxt:Array = [];
            for (var i:int = 0; i < 3; i++) {
                skillData = SkillData.getSkill(heroData["skill" + (i + 1)]);
                image = this["skill_" + i] as Button;
                text = this["textSkill_" + i] as TextField;
                image.touchable = true;
                if (skillData) {
                    image.visible = true;
                    image.upState = AssetMgr.instance.getTexture(skillData.skillIcon);
                    text.text = skillData.name;
                    image.addEventListener(TouchEvent.TOUCH, thochHandler);
                    arr.push(image);
                    this.setChildIndex(image, this.numChildren - 1);
                    arrTxt.push(text);
                } else {
                    text.text = "";
                    image.visible = false;
                }
            }
            if (arr.length == 1) {
                image = arr[0] as Button;
                text = arrTxt[0] as TextField;
                image.y = 247;
                text.y = 254;
            } else if (arr.length == 2) {
                image = arr[0] as Button;
                text = arrTxt[0] as TextField;
                image.y = 210;
                text.y = 217;
                image = arr[1] as Button;
                text = arrTxt[1] as TextField;
                image.y = 284;
                text.y = 291;
            } else if (arr.length == 3) {
                image = arr[0] as Button;
                text = arrTxt[0] as TextField;
                image.y = 198;
                text.y = 205;
                image = arr[1] as Button;
                text = arrTxt[1] as TextField;
                image.y = 247;
                text.y = 254;
                image = arr[2] as Button;
                text = arrTxt[2] as TextField;
                image.y = 296;
                text.y = 303;
            }
        }

        private function thochHandler(e:TouchEvent):void {
            var index:uint = uint((e.currentTarget as DisplayObject).name.split("_")[1]) + 1;
            var touch:Touch = e.getTouch(this);
            if (touch == null) {
                return;
            }
            var skillData:SkillData = SkillData.getSkill(_currData["skill" + index]);
            var p:Point = touch.getLocation(this);
            p = new Point(p.x, p.y);
            switch (touch.phase) {
                case TouchPhase.BEGAN:
                    (this.parent as HeroDialog).isVisible = true;
                    DialogMgr.instance.open(SkillDesDialog, {data: skillData, point: p});
                    break;
                case TouchPhase.ENDED:
                    DialogMgr.instance.closeDialog(SkillDesDialog);
                    break;
                default:
                    break;
            }
        }

        /**销毁*/
        override public function dispose():void {
            _selectedAnimation && _selectedAnimation.removeFromParent(true)
            _heroAvatar.removeFromParent(true);
            _deji.removeFromParent(true);
            _heroAvatar = null;
            _deji = null;
            super.dispose();
        }
    }
}
