package game.view.magicShop.view {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.mvc.interfaces.INotification;
    import com.view.base.event.EventType;

    import flash.geom.Rectangle;

    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.data.Goods;
    import game.data.IconData;
    import game.data.JewelLevData;
    import game.data.WidgetData;
    import game.dialog.ResignDlg;
    import game.dialog.ShowLoader;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.net.GameSocket;
    import game.net.data.c.CJewelry;
    import game.net.data.s.SJewelry;
    import game.net.data.s.SStrengthen;
    import game.view.comm.GetGoodsAwardEffectDia;
    import game.view.magicShop.MagicOrbDia;
    import game.view.magicShop.data.GetMagicOrbs;
    import game.view.magicShop.data.MagicData;
    import game.view.magicShop.render.SwallowRender;
    import game.view.uitils.FunManager;
    import game.view.uitils.Res;
    import game.view.viewBase.MagicSwallowViewBase;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.events.Event;

    /**
     *宝珠吞噬
     * @author lfr
     */
    public class MagicSwallowView extends MagicSwallowViewBase {
        private var dataVector:Vector.<IconData> = null;
        private var _totalExp:int;
        private var _totalCoin:int;
        private var _nextProperty:int = 0;
        private var selectIco:SpriterClip = null;
        private var _isTop:Boolean = false
        private var magicArray:Array = [];

        public function MagicSwallowView() {
            super();
        }

        /**初始化*/
        override protected function init():void {
            bgImage0.alpha = bgImage1.alpha = bgImage2.alpha = 0.5;
            selectIcon.visible = selectIcon1.visible = false;
            text_useup.text = Langue.getLangue("useup"); //消耗 
            cancel_Scale9Button.text = Langue.getLangue("CANCEL");
            Select_Scale9Button.text = Langue.getLangue("selectMagic"); //选择宝珠
            ok_Scale9Button.text = Langue.getLangue("fixEngulfMagic") //确认吞噬;
            setCancel();

            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.gap = 10;
            layout.useSquareTiles = false; //是否正方形显示
            layout.useVirtualLayout = true; //是否重用
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
            list_Swall.layout = layout;
            list_Swall.itemRendererFactory = itemRendererFactory;

            nextExpBar.clipRect = new Rectangle(0, 0, 0, 38);
            currentExpBar.clipRect = new Rectangle(0, 0, 0, 38);
        }

        private function setCancel(boo:Boolean = true):void {
            if (boo) {
                cancel_Scale9Button.visible = !boo;
                ok_Scale9Button.visible = !boo;
                Select_Scale9Button.visible = boo;
            } else {
                cancel_Scale9Button.visible = !boo;
                ok_Scale9Button.visible = !boo;
                Select_Scale9Button.visible = boo;
            }
        }

        /**更新*/
        public function updata():void {
            onSwallow(null);
            var goodsList:Vector.<Goods> = WidgetData.getMagicBalls(4, 2); //获取背包里现有的宝珠
            var orgLen:int = goodsList.length;
            magicArray = [];
            for (var i:int = 0; i < orgLen; i++) {
                var magicOrbs:GetMagicOrbs = new GetMagicOrbs();
                if (i < orgLen) {
                    var widget:Goods = goodsList[i];
                    magicOrbs.id = widget.id;
                    magicOrbs.level = widget.level;
                    magicOrbs.type = widget.type;
                    magicOrbs.pile = widget.pile;
                    magicOrbs.quality = widget.quality;
                    magicOrbs.exp = widget.exp;
                }
                magicArray[i] = magicOrbs;
            }
            magicArray.sortOn(["quality", "level", "type", "exp"], Array.DESCENDING);

            var len:int = (magicArray.length - 12) >= 0 ? 0 : 12 - magicArray.length;
            for (i = 0; i < len; i++) {
                magicArray.push(new GetMagicOrbs());
            }
            list_Swall.dataProvider = new ListCollection(magicArray);
        }

        /**渲染器*/
        private function itemRendererFactory():SwallowRender {
            const renderer:SwallowRender = new SwallowRender();
            renderer.setSize(98, 98);
            return renderer;
        }

        /**初始化监听*/
        override protected function addListenerHandler():void {
            super.addListenerHandler();
            addViewListener(list_Swall, EventType.SELECTED_DEFAULT, onSelected);
            addViewListener(Select_Scale9Button, Event.TRIGGERED, onBtnSelect); //选择材料
            addViewListener(ok_Scale9Button, Event.TRIGGERED, onSwallowFix); //确定吞噬
            addViewListener(cancel_Scale9Button, Event.TRIGGERED, onSwallow); //取消
            list_Swall.selectedIndex = 0;
        }

        override public function listNotificationName():Vector.<String> {
            var vect:Vector.<String> = new Vector.<String>;
            vect.push(SJewelry.CMD, SStrengthen.CMD);
            return vect;
        }

        /**监听协议*/
        override public function handleNotification(_arg1:INotification):void {
            var effectData:Object = null;
            if (_arg1.getName() == String(SJewelry.CMD)) {
                var jewelry:SJewelry = _arg1 as SJewelry;
                var wi:WidgetData = WidgetData.hash.getValue(MagicData.magicData.id);
                var iconData:IconData = null;
                dataVector = new Vector.<IconData>;
                if (0 == jewelry.code) {
                    (this.parent as MagicOrbDia).isVisible = true;
                    iconData = new IconData();
                    iconData.IconId = wi.id;
                    iconData.QualityTrue = Res.instance.getQualityToolTextures(wi.quality);
                    iconData.IconTrue = wi.picture;
                    iconData.Num = "Lv " + jewelry.level;
                    iconData.IconType = wi.type;
                    iconData.Name = wi.name;
                    dataVector.push(iconData);
                    effectData = {vector: dataVector, effectPoint: null, effectName: "effect_036", effectSound: "baoxiangkaiqihuode",
                            effectFrame: 299};
                    DialogMgr.instance.open(GetGoodsAwardEffectDia, effectData, null, null, "translucence", 0x000000, 0.5);
                } else if (1 == jewelry.code) {
                    RollTips.add(Langue.getLangue("noGoEngulf")); //失败
                } else if (2 == jewelry.code) {
                    RollTips.add(Langue.getLangue("NOT_ENOUGH_MAG")); //宝珠不足
                } else if (4 == jewelry.code) {
                    RollTips.add(Langue.getLangue("notEnoughCoin")); //金币不足
                } else if (5 == jewelry.code) {
                    RollTips.add(Langue.getLangue("diamendNotEnough")); //钻石不足
                } else if (127 <= jewelry.code) {
                    RollTips.add(Langue.getLangue("activityCode127")); //程序异常
                }
                wi.exp = jewelry.exp;
                wi.level = jewelry.level;
            }
            onSwallow();
            updata();
            ShowLoader.remove();
        }

        /**
         * 选择要吞噬的宝珠材料
         */
        private function onBtnSelect(e:Event):void {
            if (MagicData.magicData == null) {
                RollTips.add(Langue.getLangue("Orb_please_select")); //请先选择要升级的宝珠
                return;
            }

            var selectedWidget:WidgetData = WidgetData.hash.getValue(MagicData.magicData.id); // 获取当前升级的宝珠
            if (selectedWidget == null) {
                RollTips.add("你确定有宝珠吗"); //请先选择要升级的宝珠
                return;
            }
            var arrayJew:JewelLevData = JewelLevData.JewelLevHash.getValue(selectedWidget.level + "" + selectedWidget.quality);
            if (arrayJew.exp == 0) {
                topTextValue();
                RollTips.add(Langue.getLangue("Orb_Level_top")); //已经是最高等级的宝珠,不能升级
            } else {
                if (!MagicData.magicData.state) {
                    MagicData.magicData.state = true;
                    setCancel(false);

                    var len:int = magicArray.length;
                    var swallow:GetMagicOrbs = null;
                    for (var i:int = 0; i < len; i++) {
                        swallow = magicArray[i] as GetMagicOrbs;
                        if (swallow.id > 0)
                            swallow.rock = true;
                    }
                    list_Swall.dataViewPort.dataProvider_refreshItemHandler();
                } else {
                    onSwallowFix();
                }
            }
        }

        /**选择确定珠或者勾选宝珠*/
        private function onSelected(e:Event, info:Object):void {
            var type:int = info.type; //1选择宝珠   2勾选宝珠
            var magicRender:SwallowRender = info.data as SwallowRender;
            if (magicRender.data.id == 0) {
                return;
            }
            if (type == 1) //选择宝珠
            {
                if (MagicData.magicData != null && MagicData.magicData.state) {
                    return;
                }

                MagicData.magicData = magicRender.data as GetMagicOrbs;
                selectIco && selectIco.removeFromParent(true);
                selectIco = AnimationCreator.instance.create("effect_012", AssetMgr.instance);
                selectIco.play("effect_012");
                selectIco.animation.looping = true;
                selectIco.name = "selectIco";
                Starling.juggler.add(selectIco);
                selectIco.x = magicRender.width >> 1;
                selectIco.y = magicRender.height >> 1;
                selectIco.touchable = false;
                magicRender.addChild(selectIco);
            }
            updateMagic(magicRender, type);
        }

        /**更新宝珠数据*/
        private function updateMagic(magicRender:SwallowRender, type:int):void {
            var id:int = magicRender.data.id;
            var selectedWidget:WidgetData = WidgetData.hash.getValue(id); // 获取当前升级的宝珠
            if (type == 1) //选择宝珠
            {
                var goods:Goods = WidgetData.hash.getValue(id);
                if (goods && goods.type > 0) {
                    SelectQuality.texture = SelectQuality1.texture = AssetMgr.instance.getTexture("ui_daojukuang0" + goods.quality);
                    selectIcon.texture = selectIcon1.texture = AssetMgr.instance.getTexture(goods.picture);
                    selectIcon.visible = selectIcon1.visible = true;
                } else {
                    selectIcon.visible = selectIcon1.visible = false;
                }
                // goods.magicIndex代表的是  1攻击,  2血量 , 3防御 , 4穿刺,  5命中 , 6闪避,  7暴击 , 8暴强 , 9免爆 , 10韧性
                var textArray:Array = Langue.getLans("ENCHANTING_TYPE");
                if (goods.tab == 2 && goods.sort == 4) {
                    text_attack1.text = text_attack2.text = textArray[goods.magicIndex - 1];
                }
            } else if (type == 2) {
                //do nothing
            }
            updateExpBar(magicRender, type);
        }

        /**计算使用金币*/
        private function updateCoin(magicRender:SwallowRender, type:int):void {
            if (type == 2) {
                var getMagicOrbs:GetMagicOrbs = magicRender.data as GetMagicOrbs;
                var widget:WidgetData = WidgetData.hash.getValue(getMagicOrbs.id);
                var arrayJew:JewelLevData = JewelLevData.JewelLevHash.getValue(widget.level + "" + widget.quality);
                if (getMagicOrbs.selected) {
                    _totalCoin += arrayJew.coin;
                } else {
                    _totalCoin -= arrayJew.coin;
                }
                text_money.text = _totalCoin.toString();
            } else if (type == 1) {
                _totalCoin = 0;
                text_money.text = "";
            }
            text_money.color = (_totalCoin < GameMgr.instance.coin) ? 0xFFFFCC : 0xFF0000;
        }

        /**更新经验条*/
        private function updateExpBar(magicRender:SwallowRender, type:int):void {
            var getMagicOrbs:GetMagicOrbs = magicRender.data as GetMagicOrbs;
            var selectedWidget:WidgetData = WidgetData.hash.getValue(getMagicOrbs.id) as WidgetData; // 获取当前升级的宝珠
            var jewelId:String = selectedWidget.level + "" + selectedWidget.quality;
            var arrayJew:JewelLevData = JewelLevData.JewelLevHash.getValue(jewelId) as JewelLevData;

            /**------------------------满级------------------------------*/
            if (arrayJew.exp == 0 && type == 1) {
                text_Lv2.fontSize = 18;
                topTextValue(); //满级
                return;
            } else {
                text_Lv2.fontSize = 21;
            }

            if (type == 2) {
                if (_isTop) //提示升级到最高级
                {
                    if (getMagicOrbs.selected) {
                        magicRender.selectedItem = false;
                        _totalExp -= arrayJew.provide; //累减总经验
                        RollTips.add("提供的经验已经可以升级到最高级");
                    } else {
                        updataBar(magicRender, type);
                    }
                    return;
                }

                var curWidget:WidgetData = WidgetData.hash.getValue(MagicData.magicData.id) as WidgetData;
                if (magicRender.data.selected && selectedWidget.quality > curWidget.quality) {
                    (this.parent as MagicOrbDia).isVisible = true;
                    var tips:ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
                    tips.text = Langue.getLangue("swallow_quality_Upgrading_Sarah"); //你要吞噬掉比升级宝珠高的品质宝珠吗
                    tips.onResign.addOnce(function():void {
                        updataBar(magicRender, type);
                    });
                    tips.onClose.addOnce(function():void {
                        magicRender.selectedItem = false;
                    });
                    return;
                }
            }
            updataBar(magicRender, type);
        }

        private function updataBar(magicRender:SwallowRender, type:int):void {
            var getMagicOrbs:GetMagicOrbs = magicRender.data as GetMagicOrbs;
            var selectedWidget:WidgetData = WidgetData.hash.getValue(getMagicOrbs.id) as WidgetData; // 获取当前升级的宝珠
            var jewelId:String = selectedWidget.level + "" + selectedWidget.quality;
            var arrayJew:JewelLevData = JewelLevData.JewelLevHash.getValue(jewelId) as JewelLevData;

            if (type == 1) //选择要升级宝珠
            {
                _totalExp = 0;
                _isTop = false;
            } else if (type == 2) //选择被吞噬宝珠
            {
                if (getMagicOrbs.selected) {
                    _totalExp += arrayJew.provide; //累加总经验
                } else {
                    _totalExp -= arrayJew.provide; //累减总经验
                    if (_totalExp <= 0) {
                        _totalExp = 0;
                    }
                    _isTop = false;
                }
            }
            if (_isTop) //提示升级到最高级
            {
                if (getMagicOrbs.selected) {
                    magicRender.selectedItem = false;
                    _totalExp -= arrayJew.provide; //累减总经验
                    RollTips.add("提供的经验已经可以升级到最高级");
                }
                return;
            }

            var nextLevData:Object = getJewelLevData();
            if (_totalExp >= nextLevData.tExp) {
                if (getMagicOrbs.selected) {
                    _isTop = true;
                    RollTips.add(Langue.getLangue("Orb_Exp_top"));
                }
            }

            var curEXp:int = MagicData.magicData.exp;
            var add:int = 0;
            var percent:Number = 0;
            var bgW:int = 273;
            if (type == 1) {
                text_currentExp.text = getMagicOrbs.exp + " ( + " + add + " ) " + " / " + arrayJew.exp;
                percent = getMagicOrbs.exp / arrayJew.exp;
                nextExpBar.clipRect = new Rectangle(0, 0, 0, 38);
                currentExpBar.clipRect = new Rectangle(0, 0, bgW * percent, 38);
                text_Lv1.text = selectedWidget.name + " " + Langue.getLangue("magicLevel") + (selectedWidget.level); // 当前等级
                text_currentProperty.text = selectedWidget.propertyValue.toString();
                text_currentExp.text = curEXp + " ( + " + add + " ) " + " / " + nextLevData.nextJewelLevData.exp;
            } else if (type == 2) {
                add = _totalExp - nextLevData.frontExp; //经验
                var d:int = curEXp + add - nextLevData.nextJewelLevData.exp;
                if (d < 0) { //基础级
                    percent = MagicData.magicData.exp / nextLevData.nextJewelLevData.exp;
                    text_currentExp.text = curEXp + " ( + " + add + " ) " + " / " + nextLevData.nextJewelLevData.exp;
                } else {
                    var levData:JewelLevData = JewelLevData.JewelLevHash.getValue((nextLevData.nextJewelLevData.level + 1) + "" + MagicData.magicData.quality) as JewelLevData;
                    if (levData && levData.exp > 0) { //可升级
                        percent = nextLevData.nextJewelLevData.exp / levData.exp;
                        text_currentExp.text = curEXp + " ( + " + add + " ) " + " / " + levData.exp;
                    } else { //顶级
                        levData = JewelLevData.JewelLevHash.getValue(nextLevData.nextJewelLevData.level + "" + MagicData.magicData.quality) as JewelLevData;
                        percent = 1;
                        text_currentExp.text = curEXp + " ( + " + add + " ) " + " / " + levData.exp;
                    }
                }
                currentExpBar.clipRect = new Rectangle(0, 0, percent * bgW, 38);
                percent = add / nextLevData.nextJewelLevData.exp
                nextExpBar.clipRect = new Rectangle(0, 0, percent * bgW, 38);
            }

            text_Lv2.text = Goods.goods.getValue(MagicData.magicData.type).name + " " + Langue.getLangue("magicLevel") + (nextLevData.nextJewelLevData.level + 1); // 下个等级
            var nextSumProperty:int = 0;
            if (type == 1) {
                nextSumProperty = FunManager.jewelry_upgrade(selectedWidget.control2, nextLevData.nextJewelLevData.level + 1); //下一个宝珠属性总值
                _nextProperty = nextSumProperty - selectedWidget.propertyValue; //下一个宝珠等级要加的属性值
                text_nextProperty.text = selectedWidget.propertyValue + " + " + _nextProperty + "";
            } else if (type == 2 && MagicData.magicData) {
                var cdWidget:WidgetData = WidgetData.hash.getValue(MagicData.magicData.id) as WidgetData;
                nextSumProperty = FunManager.jewelry_upgrade(cdWidget.control2, nextLevData.nextJewelLevData.level + 1);
                var propertyValue:int = FunManager.jewelry_upgrade(cdWidget.control2, cdWidget.level);
                _nextProperty = nextSumProperty - propertyValue;
                text_nextProperty.text = cdWidget.propertyValue + " + " + _nextProperty + "";
            }
            updateCoin(magicRender, type);
        }

        private function getJewelLevData():Object {
            var getMagicOrbs:GetMagicOrbs = MagicData.magicData as GetMagicOrbs;
            var selectedWidget:WidgetData = WidgetData.hash.getValue(getMagicOrbs.id) as WidgetData; // 获取当前升级的宝珠
            var obj:Object = null;
            var arr:Vector.<*> = JewelLevData.JewelLevHash.values();
            var len:int = arr.length;
            var tArr:Array = [];
            var g:int = 0;
            //  筛选宝珠吞噬表里适合的宝珠升级数据，相同品级、弃用等级无用数据，并进行排序
            var tData:JewelLevData = null;
            for (var i:int = 0; i < len; i++) {
                tData = arr[i] as JewelLevData;
                if (tData.quality == selectedWidget.quality) {
                    if (tData.exp != 0 && tData.level >= selectedWidget.level) {
                        tArr[g++] = tData;
                    }
                }
            }
            tArr.sortOn(["quality", "level", "type", "exp"], Array.NUMERIC); //数组默认是按照字符串排序
            len = tArr.length; //递增等级宝珠1 2 3 4....
            var frontExp:int = 0;
            var nextJewelLevData:JewelLevData;
            var tExp:int = 0; //下一级经验
            for (i = 0; i < len; i++) {
                tData = tArr[i] as JewelLevData;
                nextJewelLevData = tData;
                frontExp = tExp;
                tExp += tData.exp;
                if (_totalExp < tExp) {
                    nextJewelLevData = tData;
                    break;
                }
            }
            return obj = {nextJewelLevData: nextJewelLevData, tExp: tExp, frontExp: frontExp};
        }

        /**顶级时设置*/
        private function topTextValue():void {
            var selectedWidget:WidgetData = WidgetData.hash.getValue(MagicData.magicData.id) as WidgetData; // 获取当前升级的宝珠
            var arrayJew:JewelLevData = JewelLevData.JewelLevHash.getValue(selectedWidget.level + "" + selectedWidget.quality) as JewelLevData;
            text_Lv1.text = selectedWidget.name + " " + Langue.getLangue("magicLevel") + selectedWidget.level + "";
            text_Lv2.text = selectedWidget.name + " " + Langue.getLangue("magicLevel") + Langue.getLangue("Orb_Top_Level");
            text_currentProperty.text = "+ " + selectedWidget.propertyValue;
            text_nextProperty.text = "+ " + selectedWidget.propertyValue;
            text_currentExp.text = "" + Langue.getLangue("Orb_Top_Level");
            text_money.text = "";
            nextExpBar.clipRect = new Rectangle(0, 0, 0, 38);
            currentExpBar.clipRect = new Rectangle(0, 0, 273, 38);
        }

        /** 确定吞噬宝珠*/
        private function onSwallowFix():void {
            var _jwselectList:Vector.<int> = new Vector.<int>;
            var oldArr:Array = list_Swall.dataProvider.data as Array;
            var len:int = oldArr.length;
            var isExist:Boolean = false;
            for (var i:int = 0; i < len; i++) {
                var oldData:GetMagicOrbs = oldArr[i];
                if (oldData.type == 0) {
                    break;
                }
                isExist = true;
                if (oldData.selected) {
                    _jwselectList.push(oldData.id);
                }
            }

            if (MagicData.magicData.state) {
                if (0 == _jwselectList.length) {
                    RollTips.add(Langue.getLangue("noSelectfixEngulfMagic")); //没有选中被吞噬的材料
                } else {
                    if (_totalCoin > GameMgr.instance.coin) {
                        RollTips.add(Langue.getLangue("notEnoughCoin")); //金币不足
                        return;
                    } else {
                        var cmd:CJewelry = new CJewelry();
                        var ids:Vector.<int> = new Vector.<int>();
                        cmd.id = MagicData.magicData.id;
                        cmd.ids = _jwselectList;
                        ids.push(cmd);
                        GameSocket.instance.sendData(cmd);
                        ShowLoader.add();
                    }
                }
            }
        }

        /**取消选择要吞噬的宝珠*/
        private function onSwallow(e:Event = null):void {
            setCancel();
            _totalCoin = 0;
            _totalExp = 0;
            _isTop = false;
            text_currentExp.text = "";
            text_money.text = "";
            text_money.color = (_totalCoin < GameMgr.instance.coin) ? 0xFFFFCC : 0xFF0000;

            if (MagicData.magicData) {
                MagicData.magicData.state = false;
                Select_Scale9Button.text = Langue.getLangue("selectMagic"); //选择宝珠;
                if (e) {
                    var index:int = list_Swall.dataProvider.getItemIndex(MagicData.magicData);
                    var rend:SwallowRender = list_Swall.dataViewPort.getChildAt(index) as SwallowRender;
                    onSelected(null, {type: 1, data: rend});
                }
            }

            for each (var md:GetMagicOrbs in magicArray) {
                md.rock = false;
                md.selected = false;
            }
            list_Swall.dataViewPort.dataProvider_refreshItemHandler();
        }

        /**销毁*/
        override public function dispose():void {
            dataVector = null;
            _totalCoin = 0;
            _totalExp = 0;
            selectIco && selectIco.removeFromParent(true);
            MagicData.magicData = null;
            super.dispose();
        }
    }
}


