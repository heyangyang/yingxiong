
package game.view.blacksmith.view {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.view.base.event.EventType;

    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.data.Goods;
    import game.data.HeroData;
    import game.data.MagicorbsData;
    import game.data.WidgetData;
    import game.dialog.ResignDlg;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.HeroDataMgr;
    import game.net.data.vo.MagicBallVO;
    import game.net.message.EquipMessage;
    import game.view.blacksmith.render.EmbedBallItem;
    import game.view.blacksmith.render.EquipContainer;
    import game.view.blacksmith.render.EquipRender;
    import game.view.uitils.FunManager;
    import game.view.uitils.Res;
    import game.view.viewBase.InsetViewBase;

    import spriter.SpriterClip;

    import starling.events.Event;

    public class InsetView extends InsetViewBase {
        private var _selectedAnimation:SpriterClip;
        private var equipData:Goods;
        private var equipDataList:Array = [];
        private var stoneVector:Vector.<Object> = null;

        public function InsetView():void {
            super();
        }

        override protected function init():void {
            bgImage.alpha = 0.5;
            _selectedAnimation = AnimationCreator.instance.create("effect_012", AssetMgr.instance);
            strenthenScale9Button.text = Langue.getLans("blacksmith")[1];
            text_useup.text = Langue.getLangue("useup"); //消耗

            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.paddingTop = 15;
            layout.gap = 5;
            layout.useSquareTiles = false;
            layout.useVirtualLayout = true;
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_equip.layout = layout;
            list_equip.itemRendererFactory = listItemRendererFactory;

            for (var i:int = 0; i < 5; i++) {
                var button:EmbedBallItem = this["item" + i] as EmbedBallItem;
                button.name = String(i);
                button.addEventListener(Event.TRIGGERED, openBallPane);
            }
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            ballPane.addEventListener("change", selectedStone);
            ballPane.addEventListener("close", closeStonePane);
            list_equip.addEventListener(Event.CHANGE, onEquipListChange);
            strenthenScale9Button.addEventListener(Event.TRIGGERED, onEmbedHandler);
            this.addContextListener(EventType.UPDATE_EQUIP_GEM, onUnGemNotify);
        }

        override protected function show():void {
            setEquipListData();
            list_equip.visible = !(ballPane.visible = false);
            setText();
            updataEquip(equip, null);
        }

        /**
         * 装备宝珠
         * @param goods
         */
        private function onEmbedHandler(e:Event):void {
			if(stoneVector==null)
			{
				RollTips.add(Langue.getLangue("SELECED_EQUIP_TIPS"));
				return;
			}
            if (stoneVector.length > 0) {
                var ball:EmbedBallItem = null;
                var hasEmbed:Boolean;
                for (var i:int = 0; i < 5; i++) {
                    ball = this["item" + i] as EmbedBallItem;
                    if (ball.data.statue == 3 && ball.data.data && ball.data.data.id) {
                        hasEmbed = true;
                        EquipMessage.sendInputGem(equipData.id, ball.data.data.id);
                    }
                }
                if (!hasEmbed) {
                    RollTips.add("请先选择镶嵌的宝珠");
                }
            }
        }

        private function openBallPane(e:Event):void {
            if (!equipData) {
                RollTips.add(Langue.getLangue("SELECED_EQUIP_TIPS"));
                return;
            }
            var item:EmbedBallItem = e.currentTarget as EmbedBallItem;
            var vo:Object = item.data;
			if(vo==null)
			{
				RollTips.add(Langue.getLangue("SELECED_EQUIP_TIPS"));
				return;
			}
            if (vo.statue == 2) //已开启 已镶嵌
            {
                DialogMgr.instance.isVisibleDialogs(true);
                var tip:ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
                tip.text = getLangue("REPLACE_ENCHANTING_ROUND").replace("*", MagicorbsData.dic_cost[vo.data.quality]);
                tip.onResign.addOnce(isOkClick);
                function isOkClick():void {
                    EquipMessage.sendUnGem(equipData.id, vo.data.type);
                }
            } else if (vo.statue == 3) //刚刚设置的宝珠
            {
                stoneVector[stoneVector.indexOf(vo)] = {data: null, statue: 1, value: 0}
                for (var i:int = 0; i < 5; i++) {
                    var ball:EmbedBallItem = this["item" + i] as EmbedBallItem;
                    ball.data = stoneVector[i];
                }
            } else if (vo.statue == 1) {
                list_equip.visible = !(ballPane.visible = true);
            }
        }

        private function listItemRendererFactory():EquipRender {
            var itemRender:EquipRender = new EquipRender(_selectedAnimation);
            itemRender.setSize(98, 98);
            return itemRender;
        }

        private function onUnGemNotify(evt:Event):void {
            AnimationCreator.instance.createSecneEffect("effect_022", equip.x + 89 / 2, equip.y + 89 / 2, this, AssetMgr.instance);
            var index:int = list_equip.selectedIndex;
            setEquipListData();
            list_equip.selectedIndex = index;
            setText();
            updataEquip(equip, null);
            updateData(list_equip.selectedItem as WidgetData);
            ballPane.setBallListData();
        }

        private function setEquipListData():void {
            equipDataList.length = 0;
            var widgetArr:Vector.<*> = WidgetData.hash.values();
            var i:int = 0;
            for each (var widget:WidgetData in widgetArr) {
                if (widget.tab == 5 && widget.socketsNum > 0) //装备
                {
                    equipDataList[i++] = widget;
                }
            }
            equipDataList.sortOn(["quality", "level", "equip"], Array.DESCENDING | Array.NUMERIC);
            var len:int = (equipDataList.length - 12) >= 0 ? 0 : 12 - equipDataList.length;
            for (i = 0; i < len; i++) {
                equipDataList.push(new WidgetData);
            }
            list_equip.dataProvider = new ListCollection(equipDataList);
            list_equip.selectedIndex = 0;
        }

        public function set data(widgetData:WidgetData):void {
            if (widgetData && widgetData.id > 0) {
                updateData(widgetData);

                var index:int = list_equip.dataProvider.getItemIndex(widgetData);
//                list_equip.selectedIndex(index);
                list_equip.scrollToPageIndex(0, int(index / 12));
            }
        }

        private function updateData(widgetData:WidgetData):void {
			if(!widgetData)
				return;
            equipData = widgetData;
            if (widgetData && widgetData.id > 0) {
                list_equip.selectedItem = widgetData;
                updataEquip(equip, widgetData);
                updateBall(widgetData);
                setText();
            }
        }

        private function updateBall(widgetData:WidgetData):void {
            var sockets:Vector.<MagicBallVO> = widgetData.sockets;
            var socketsNum:int = widgetData.socketsNum;
            stoneVector = new Vector.<Object>;
            for (var i:int = 0; i < 5; i++) {
                var vo:Object = null;
                var ball:EmbedBallItem = this["item" + i] as EmbedBallItem;
                if (i < sockets.length) //已经镶嵌
                {
                    vo = {data: Goods.goods.getValue(sockets[i].id), statue: 2, value: sockets[i].value};
                } else {
                    if (i < socketsNum) //未镶嵌
                    {
                        vo = {data: null, statue: 1, value: 0};
                    } else //未开启
                    {
                        vo = {data: null, statue: 0, value: 0};
                    }
                }
                ball.data = vo;
                stoneVector.push(vo);
            }
        }

        private function setText():void {
            equipName.text = equipData ? equipData.name : "";
            var widget:WidgetData = equipData as WidgetData;
            if (widget && widget.equip > 0) {
                var heroData:HeroData = HeroDataMgr.instance.getHeroInfo(widget.equip);
                heroName.text = HeroData.hero.getValue(heroData.type).name;
                hero.text = Langue.getLangue("EQUIP_TO");
            } else {
                heroName.text = "";
                hero.text = Langue.getLangue("unequiped");
            }
            spend.text = "0";
        }

        private function updataEquip(container:EquipContainer, widgetData:WidgetData):void {
            if (widgetData && widgetData.id > 0) {
                container.icon.texture = AssetMgr.instance.getTexture(widgetData.picture);
                container.icon.visible = true;
                container.quality.texture = Res.instance.getQualityToolTexture(widgetData.quality);
            } else {
                container.quality.texture = Res.instance.getQualityToolTexture(0);
            }
            container.ad.visible = false;
            container.txt.text = "";
        }

        private function closeStonePane(e:Event):void {
            list_equip.visible = !(ballPane.visible = false);
        }

        private function selectedStone(e:Event):void {
            if (e.data)
                pushMagicorbs(e.data as Goods);
        }

        private function pushMagicorbs(goods:Goods):void {
            var index:int = -1;
            var i:int = 0;
            var hasStone:Boolean = false;
            var cdata:Goods = null;
            for (i = 0; i < stoneVector.length; i++) {
                cdata = stoneVector[i].data;
                if (cdata) {
                    if (cdata.name == goods.name && goods.type != 0) {
                        hasStone = true;
                        break;
                    }
                }
            }
            if (hasStone) {
                RollTips.add("一件装备不能镶嵌多颗同种宝珠");
                return;
            }

            for (i = 0; i < 5; i++) {
                if (stoneVector[i].statue == 1) //已开启 未镶嵌
                {
                    index = i;
                    var value:int = FunManager.jewelry_upgrade(goods.control2, goods.level);
                    stoneVector[i] = {data: goods, statue: 3, value: value};
                    break;
                }
            }

            if (index == -1) {
                RollTips.add("宝珠孔已填满");
                return;
            }

            for (i = 0; i < 5; i++) {
                var ball:EmbedBallItem = this["item" + i] as EmbedBallItem;
                ball.data = stoneVector[i];
            }
            updataCoin();
        }

        private function updataCoin():void {
            var count:int = 0;
            var magicorbsData:MagicorbsData;
            for (var i:int = 0; i < 5; i++) {
                if (stoneVector[i].statue == 3 && stoneVector[i].data) //已开启 未镶嵌
                {
                    magicorbsData = MagicorbsData.hash.getValue(stoneVector[i].data.quality);
                    if (magicorbsData)
                        count += magicorbsData.coinCount1;
                }
            }
            spend.text = count.toString();
        }

        private function onEquipListChange(e:Event):void {
            updateData(list_equip.selectedItem as WidgetData);
        }

        override public function dispose():void {
            _selectedAnimation && _selectedAnimation.dispose();
            super.dispose();
        }
    }
}
