package game.view.blacksmith.view {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.view.base.event.EventType;

    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.data.ConfigData;
    import game.data.Goods;
    import game.data.HeroData;
    import game.data.StrengthenData;
    import game.data.StrenthenRateData;
    import game.data.WidgetData;
    import game.dialog.ShowLoader;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.HeroDataMgr;
    import game.net.data.c.CStrengthen;
    import game.net.message.EquipMessage;
    import game.view.blacksmith.render.EquipContainer;
    import game.view.blacksmith.render.EquipRender;
    import game.view.goodsGuide.EquipInfoDlg;
    import game.view.uitils.Res;
    import game.view.viewBase.StrengthenBase;

    import spriter.SpriterClip;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.events.Event;

    public class StrengthenView extends StrengthenBase {
        private var _selectedAnimation:SpriterClip;
        private var equipData:Goods;
        private var stoneList:Array = [];
        private var equipDataList:Array = [];
        private var cdTime:int;
        private var delayedCall:IAnimatable;
        private var cost_diamond:int;
        private var cost_moeny:int;


        public function StrengthenView() {
            super();
        }

        override protected function init():void {
            bgImage0.alpha = bgImage1.alpha = 0.5
            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.paddingTop = 15;
            layout.gap = 5;
            layout.useSquareTiles = false;
            layout.useVirtualLayout = true;
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_bag.layout = layout;
            list_bag.itemRendererFactory = listItemRendererFactory;

            strenthenScale9Button.text = Langue.getLans("blacksmith")[0];
            text_useup.text = Langue.getLangue("useup"); //消耗
            stonePane.visible = false;

            _selectedAnimation = AnimationCreator.instance.create("effect_012", AssetMgr.instance);
            updateDataToDisplay();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            list_bag.addEventListener(Event.CHANGE, onListChange);
            this.addViewListener(strenthenScale9Button, Event.TRIGGERED, okButtonHdr);
            this.addContextListener(EventType.NOTIFY_STRENGTHEN, onStrengthenNotify);
            this.addContextListener(EventType.NOTIFY_STRENGTHEN_CD, onStrengthenCDNotify);
            stonePane.addEventListener(Event.SELECT, selectedStone);
            stonePane.addEventListener("closeStonePane", closeStonePane);

            for (var i:int = 0; i < 3; i++) {
                var button:EquipContainer = this["stone" + i] as EquipContainer;
                button.name = String(i);
                button.txt.text = "";
                button.icon.visible = false;
                button.addEventListener(Event.TRIGGERED, openStonePane);
            }
        }

        private function listItemRendererFactory():EquipRender {
            var itemRender:EquipRender = new EquipRender(_selectedAnimation);
            itemRender.setSize(98, 98);
            return itemRender;
        }

        private function okButtonHdr(e:Event):void {
            if (!equipData) {
                RollTips.add(Langue.getLangue("SELECED_EQUIP_TIPS"));
                return;
            }
            var cmd:CStrengthen = new CStrengthen();
            var hasStone:Boolean = false;
            for (var i:int = 0; i < 3; i++) {
                var goods:Goods = stoneList[i] as Goods;
                if (goods) {
                    cmd["enId" + (i + 1)] = goods.type;
                    hasStone = true;
                } else {
                    cmd["enId" + (i + 1)] = 0;
                }
            }

            if (!hasStone) {
                RollTips.add(Langue.getLangue("inputStrengthenStone")); //  没有强化石
                return;
            }
            cmd.equid = equipData.id;
            cmd.pay = cdTime > 0 ? 1 : 0;
            ShowLoader.add();
            sendMessage(cmd);
        }

        override protected function show():void {
            setListData();
            updataEquip(equip, null);
        }

        private function setListData():void {
            equipDataList = [];
            var widgetArr:Vector.<*> = WidgetData.hash.values();
            var i:int = 0;
            for each (var widget:WidgetData in widgetArr) {
                if (widget.tab == 5 && widget.enhance_limit > 0 && widget.sort != 21) //21装备是称号装备
                {
                    equipDataList[i] = widget;
                    i++;
                }
            }
            equipDataList.sortOn(["quality", "level", "equip"], Array.DESCENDING | Array.NUMERIC);
            var len:int = (equipDataList.length - 12) >= 0 ? 0 : 12 - equipDataList.length;
            for (i = 0; i < len; i++) {
                equipDataList.push(new WidgetData);
            }
            list_bag.dataProvider = new ListCollection(equipDataList);
            list_bag.selectedIndex = 0;
        }

        private function closeStonePane(e:Event):void {
            stonePane.visible = false;
            list_bag.visible = true;
        }

        private function selectedStone(e:Event):void {
            var goods:Goods = e.data as Goods;
            if (goods.pile > 0) {
                if (equipData.level >= equipData.enhance_limit) {
                    RollTips.add(Langue.getLangue("strengthenMax"));
                    return;
                }
                if (updateRate(equipData as WidgetData, stoneList) < 100) {
                    setStone(goods);
                } else {
                    RollTips.add(Langue.getLangue("Str_success_reached") + "100%");
                }
            } else {
                var tmp_goods:Goods = goods.clone() as Goods;
                tmp_goods.Price = 0;
                tmp_goods.isPack = false;
                DialogMgr.instance.isVisibleDialogs(true);
                DialogMgr.instance.open(EquipInfoDlg, tmp_goods);
            }
        }

        private function onStrengthenNotify(evt:Event, returnObj:Object):void {
            stonePane.updata();
            stoneList = [];
            updata();
            heroTime.text = Langue.getLans("blacksmith")[0] + "CD " + returnObj.time;
            if (returnObj.isSuccess) {
                AnimationCreator.instance.createSecneEffect("effect_009", equip.x + 89 / 2, equip.y + 89 / 2, this, AssetMgr.instance,
                                                            function():void {
                                                                updateData(equipData);
                                                                list_bag.dataProvider.updateItem(equipData);
                                                                ShowLoader.remove();
                                                            });
            } else {
                updateData(equipData);
                list_bag.dataProvider.updateItem(equipData);
                ShowLoader.remove();
            }
        }

        private function onListChange(e:Event):void {
            var goods:Goods = list_bag.selectedItem as Goods;
            if (goods.id > 0) {
                updateData(goods);
            }
        }

        private function openStonePane(e:Event):void {
            if (!equipData) {
                RollTips.add(Langue.getLangue("SELECED_EQUIP_TIPS"));
                return;
            }

            var index:int = int((e.currentTarget as EquipContainer).name);
            if (stoneList[index]) {
                stoneList[index] = null;
                updata();
            }
            stonePane.visible = true;
            list_bag.visible = false;
        }

        private function setStone(stone:Goods):void {
            var index:int = -1;
            var i:int = 0;
            var hasNum:int = 0;
            for (i = 0; i < stoneList.length; i++) {
                if (stoneList[i] && stoneList[i].type == stone.type) {
                    hasNum++;
                }
            }
            if (hasNum >= stone.pile) {
                RollTips.add(Langue.getLangue("NOT_ENOUGH_STONE"));
                return;
            }

            for (i = 0; i < 3; i++) {
                if (!stoneList[i]) {
                    index = i;
                    stoneList[i] = stone;
                    break;
                }
            }

            if (index == -1) {
                RollTips.add(Langue.getLangue("STRENTHEN_STONE_FULL"));
                return;
            }
            updata();
        }

        private function updataEquip(container:EquipContainer, goods:Goods):void {
            if (goods) {
                container.icon.texture = AssetMgr.instance.getTexture(goods.picture);
                container.icon.visible = true;
                container.quality.texture = Res.instance.getQualityToolTexture(goods.quality);
                container.txt.text = "+" + equipData.level;
                if (equipData.level == 0) {
                    container.txt.text = "";
                }

            } else {
                container.quality.texture = Res.instance.getQualityToolTexture(0);
            }
            container.ad.visible = false;
            updateDataToDisplay();
        }

        public function set data(goods:Goods):void {
            updateData(goods);
            if (goods) {
                var index:int = list_bag.dataProvider.getItemIndex(goods);
                list_bag.scrollToPageIndex(0, int(index / 12));
            }
        }

        private function updateData(goods:Goods):void {
            equipData = goods;
            if (goods) {
                list_bag.selectedItem = equipData;
                updataEquip(equip, goods);
            }
        }

        private function updata():void {
            for (var i:int = 0; i < 3; i++) {
                var container:EquipContainer = this["stone" + i] as EquipContainer;
                var goods:Goods = stoneList[i] as Goods;
                if (goods) {
                    container.icon.texture = AssetMgr.instance.getTexture(goods.picture);
                    container.quality.texture = Res.instance.getQualityToolTexture(goods.quality);
                } else {
                    container.quality.texture = Res.instance.getQualityToolTexture(0);
                }
                container.txt.text = "";
                container.ad.visible = !(container.icon.visible = Boolean(goods));
            }
            updateDataToDisplay();
        }

        /**
         * 更新强化几率
         *
         */
        private function updateRate(equipData:WidgetData, stoneList:Array):Number {
            var rate:int = 0;
            if (equipData) {
                var curr_equip_level:int = equipData ? equipData.level + 1 : 0;
                var strengthenData:StrenthenRateData;
                var goods:Goods;
                for (var i:int = 0, len:int = stoneList.length; i < len; i++) {
                    goods = stoneList[i];
                    if (goods) {
                        strengthenData = StrenthenRateData.hash.getValue(curr_equip_level + "" + goods.type);
                        if (strengthenData == null) {
                            trace("找不到强化等级几率", curr_equip_level);
                            continue;
                        }
                        rate += strengthenData.rate;
                    }
                }
                rate *= equipData ? equipData.strenthenSuccessFactor : 0;
                rate = rate / 10;
            }
            return (rate > 100 ? 100 : rate);
        }

        private function updateDataToDisplay():void {
            var widget:WidgetData = equipData as WidgetData;
            if (equipData) {
                nameLabel.text = equipData.name;
                attack.text = equipData.attack + "";
                hp.text = equipData.hp + "";
                addAttack.text = "";
                addHp.text = "";
                successRatioLabel.text = Langue.getLans("upStrengthenSuccessRate")[1] + " " + updateRate(equipData as WidgetData,
                                                                                                         stoneList) + "%";
                if (equipData.level >= equipData.enhance_limit) {
                    cdTime = 0;
                    heroTime.text = "";
                    successRatioLabel.text = "";
                    addAttack.text = "";
                    addHp.text = "";
                    spend1.text = spend2.text = "0";
                    strenthenScale9Button.disable = true;
                    strenthenScale9Button.text = Langue.getLangue("Strengthening_full"); //强化已满
                    return;
                } else {
                    strenthenScale9Button.disable = false;
                    strenthenScale9Button.text = Langue.getLans("blacksmith")[0]; //强化
                }
                EquipMessage.sendStrengthenCD(widget.id); //请求CD
            } else {
                nameLabel.text = "";
                attack.text = "0";
                hp.text = "0";
                addAttack.text = "";
                addHp.text = "";
                successRatioLabel.text = "";
            }

            if (widget && widget.equip > 0) {
                var heroData:HeroData = HeroDataMgr.instance.getHeroInfo(widget.equip);
                heroName.text = HeroData.hero.getValue(heroData.type).name;
                hero.text = Langue.getLangue("EQUIP_TO");
            } else {
                heroName.text = "";
                hero.text = "";
            }


            var strengthenData:StrengthenData;
            if (widget) {
                strengthenData = StrengthenData.hash.getValue(widget.sort + "" + (widget.level + 1));
            }
            if (strengthenData) {
                addAttack.text = "+" + widget.getStrengthenValue("attack", strengthenData.rise);
                addHp.text = "+" + widget.getStrengthenValue("hp", strengthenData.rise);
                spend1.text = int(widget.strenthenCoinFactor * strengthenData.coin).toString();
            } else {
                addAttack.text = addHp.text = "";
                spend1.text = spend2.text = "0";
            }
        }

        private function onStrengthenCDNotify(evt:Event, time:int):void {
            cdTime = time;
            if (delayedCall)
                Starling.juggler.remove(delayedCall);
            delayedCall = null;
            updateTime()
        }

        private function updateTime():void {
            if (parent == null)
                return;
            heroTime.text = Langue.getLans("blacksmith")[0] + "CD: " + (cdTime <= 0 ? "00:00" : (cdTime / 60 >> 0) + ":" + (cdTime % 60));
            cost_diamond = int(Math.ceil(ConfigData.instance.diamond_per_min * (cdTime / 60)));
            spend2.text = cost_diamond.toString();
            cdTime--;
            if (cdTime > 0 && parent) {
                delayedCall = Starling.juggler.delayCall(updateTime, 1);
            } else {
                if (cdTime <= 0 || equipData == null || equipData.level >= equipData.enhance_limit) {
                    heroTime.text = "";
                } else {
                    heroTime.text = Langue.getLans("blacksmith")[0] + "CD:00:00";
                }
            }
        }

        public function refresh():void {
            if (stonePane.visible) {
                stonePane.updata();
            }
        }

        override public function dispose():void {
            _selectedAnimation && _selectedAnimation.dispose();
            super.dispose();
        }
    }
}
