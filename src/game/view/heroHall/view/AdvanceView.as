package game.view.heroHall.view {
    import com.dialog.DialogMgr;
    import com.langue.Langue;

    import game.data.Goods;
    import game.data.HeroData;
    import game.data.PurgeData;
    import game.data.Val;
    import game.data.WidgetData;
    import game.dialog.ResignDlg;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.net.message.EquipMessage;
    import game.view.goodsGuide.EquipInfoDlg;
    import game.view.heroHall.HeroDialog;
    import game.view.heroHall.render.HeroCardShow;
    import game.view.heroHall.render.HeroIconRender;
    import game.view.uitils.Res;
    import game.view.viewBase.AdvanceViewBase;

    import starling.events.Event;
    import starling.text.TextField;

    /**
     * 进阶功能版面
     * @author Samuel
     *
     */
    public class AdvanceView extends AdvanceViewBase {
        /**当前英雄数据*/
        private var _currData:HeroData = null;
        /**当前英雄*/
        private var _currHeroRender:HeroIconRender;
        /**下阶级英雄*/
        private var _nextHeroRender:HeroIconRender;

        public function AdvanceView() {
            super();
        }

        /**当前英雄icon*/
        public function get currHeroRender():HeroIconRender {
            return _currHeroRender;
        }

        /**初始化*/
        override protected function init():void {
            bgImage0.alpha = bgImage1.alpha = bgImage2.alpha = 0.5;
            bg_but.container.addChild(icon);
            bg_but.container.addChild(quality);
            quality.x = quality.y = 0;
            icon.x = (quality.width - icon.width) >> 1;
            icon.y = (quality.height - icon.height) >> 1;

            var arr:Array = Langue.getLans("heroLableName");
            advanceBtn_Scale9Button.text = arr[1];
            maxTis2.text = arr[4];
            advanceNumTitle.text = arr[5];
            advanceGlodTitle.text = arr[6];

            _currHeroRender = new HeroIconRender(null, false, true);
            _currHeroRender.x = 219;
            _currHeroRender.y = 110;
            _currHeroRender.touchable = false;
            addQuiackChild(_currHeroRender);

            _nextHeroRender = new HeroIconRender(null, false, true);
            _nextHeroRender.x = 433;
            _nextHeroRender.y = 110;
            _nextHeroRender.touchable = false;
            addQuiackChild(_nextHeroRender);

            addQuiackChild(lock);
            lock.visible = false;

            var tmpArray:Array = Val.MAGICBALL;
            var tmplang:Array = Langue.getLans("ENCHANTING_TYPE");
            var len:int = tmpArray.length;
            var title:TextField;
            var key:String;
            for (var i:int = 2; i < len; i++) {
                key = tmpArray[i];
                title = this[key] as TextField;
                title.text = tmplang[i];
            }
        }

        /**初始化监听*/
        override protected function addListenerHandler():void {
            super.addListenerHandler();
            this.addViewListener(advanceBtn_Scale9Button, Event.TRIGGERED, onHeroJinjie);
            this.addViewListener(bg_but, Event.TRIGGERED, onLookGoods);
        }

        /**选中更新英雄信息*/
        public function updata(heroData:HeroData):void {
            if (heroData == null) {
                return;
            }
            _currData = heroData;
            var colneData:HeroData = _currData.clone() as HeroData;
            colneData.seat = 0;
            _currHeroRender.data = colneData;

            if (_currData.isUpQuality()) {
                maxTis2.visible = lock.visible = false;
                gold.visible = bg_but.visible = advanceNumTitle.visible = icon.visible = quality.visible = advanceBtn_Scale9Button.visible = advanceNum.visible = advanceGlodTitle.visible = advanceGlod.visible = true;

                var cData:HeroData = _currData.clone() as HeroData;
                cData.seat = 0;
                cData.quality = _currData.quality + 1;
                _nextHeroRender.data = cData;

                var purgeData:PurgeData = PurgeData.hash.getValue(_currData.quality); //净化数据
                var goods_id:int = purgeData.materials[0][0];
                var count:int = purgeData.materials[0][1];
                var tmp_goods:Goods = Goods.goods.getValue(goods_id) as Goods;
                if (purgeData.type == 1) {
                    gold.texture = AssetMgr.instance.getTexture("ui_jinbi01_tubiao");
                } else {
                    gold.texture = AssetMgr.instance.getTexture("ui_zuanshi01_tubiao");
                }

                icon.texture = AssetMgr.instance.getTexture(tmp_goods.picture);
                quality.texture = Res.instance.getQualityToolTexture(tmp_goods.quality);
                advanceNum.text = WidgetData.pileByType(goods_id) + "/" + count.toString();
                advanceNum.color = WidgetData.pileByType(goods_id) >= count ? 0x00ff00 : 0xff0000;
                advanceGlod.text = purgeData.num.toString();
            } else {
                _nextHeroRender.data = colneData;
                maxTis2.visible = lock.visible = true;
                gold.visible = bg_but.visible = advanceNumTitle.visible = icon.visible = quality.visible = advanceBtn_Scale9Button.visible = advanceNum.visible = advanceGlodTitle.visible = advanceGlod.visible = false;
            }
            hero_name0.text = hero_name1.text = _currData.name;
            var jie:int = HeroCardShow.getCardjie(_currData);
            if (jie > 0) {
                hero_jie0.text = "+" + jie;
                var hData:HeroData = _currData.clone() as HeroData;
                hData.quality = _currData.quality + 1;
                var jie1:int = HeroCardShow.getCardjie(hData);
                if (jie1 > 0) {
                    hero_jie1.text = "+" + jie1;
                }
            }

            showHeroInfomation();
        }

        /**
         * 英雄进阶
         *
         */
        private function onHeroJinjie():void {
            DialogMgr.instance.isVisibleDialogs(true); //是否在当前页打开三级窗口
            var purgeData:PurgeData = PurgeData.hash.getValue(_currData.quality); //净化数据
            if (purgeData == null) {
                return;
            }
            var goods_id:int = purgeData.materials[0][0];
            var count:int = purgeData.materials[0][1];

            //英雄已经是最高品质
            if (_currData.quality == 7) {
                addTips("MAXQUALITY");
                return;
            }

            if (WidgetData.pileByType(goods_id) < count) {
                var tmp_goods:Goods = Goods.goods.getValue(goods_id) as Goods;
                tmp_goods = tmp_goods.clone() as Goods;
                tmp_goods.Price = 0;
                tmp_goods.isPack = false;
                (this.parent as HeroDialog).isVisible = true;
                DialogMgr.instance.open(EquipInfoDlg, tmp_goods);
                //addTips("materialNotEnough"); //材料不足
                return;
            }

            var tip:ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
            tip.text = Langue.getLans("herojinjie")[purgeData.type - 1].replace("*", purgeData.num);
            tip.onResign.addOnce(sendJinjieMsg);
            function sendJinjieMsg():void {
                //金币不足
                if (purgeData.type == 1 && GameMgr.instance.coin < purgeData.num) {
                    addTips("notEnoughCoin");
                    return;
                }

                //钻石不足
                if (purgeData.type == 2 && GameMgr.instance.diamond < purgeData.num) {
                    addTips("diamendNotEnough");
                    return;
                }
                EquipMessage.sendJinjieMessage(_currData);
            }
        }

        private function onLookGoods(e:Event):void {
            if (_currData) {
                var purgeData:PurgeData = PurgeData.hash.getValue(_currData.quality); //净化数据
                var goods_id:int = purgeData.materials[0][0];
                var data:Goods = Goods.goods.getValue(goods_id) as Goods;
                data = data.clone() as Goods;
                data.Price = 0;
                data.isPack = false;
                DialogMgr.instance.isVisibleDialogs(true);
                DialogMgr.instance.open(EquipInfoDlg, data);
            }
        }

        /**
         * 英雄属性
         */
        private function showHeroInfomation():void {
            var tmpArray:Array = _currData.getAttributes();
            //下一品质属性值
            var nextArray:Array = _currData.getNextPurgePropertys(_currData.getUpQuality());
            var len:int = tmpArray.length;
            var txt:TextField;
            var key:String;
            var currValue:uint = 0;
            var nextValue:uint = 0;
            var isUpQuality:Boolean = _currData.isUpQuality();

            for (var i:int = 0; i < len; i++) {
                key = tmpArray[i];
                //当前品质属性值
                currValue = _currData[key];
                nextValue = nextArray[i];
                txt = this[key + "Value"] as TextField;
                txt.text = currValue.toString();
                txt = this[key + "AddValue"] as TextField;

                if (isUpQuality) {
                    //变化值
                    txt.text = "" + nextValue;
                    (this["add_" + i] as TextField).visible = true;
                } else {
                    txt.text = "";
                    (this["add_" + i] as TextField).visible = false;
                }
            }
        }

        /**销毁*/
        override public function dispose():void {
            _currHeroRender.removeFromParent(true);
            _nextHeroRender.removeFromParent(true);
            _currHeroRender = _nextHeroRender = null;
            super.dispose();
        }
    }
}
