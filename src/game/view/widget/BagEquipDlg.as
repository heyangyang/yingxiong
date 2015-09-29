package game.view.widget {
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.view.base.event.EventType;
    
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;
    
    import game.data.HeroData;
    import game.data.Val;
    import game.data.WidgetData;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.net.message.EquipMessage;
    import game.view.goodsGuide.GetBestEquipDlg;
    import game.view.heroHall.render.HeroEquipBagRender;
    import game.view.uitils.Res;
    import game.view.viewBase.BagEquipDlgBase;
    
    import spriter.SpriterClip;
    
    import starling.events.Event;
    import starling.text.TextField;

    /**
     *
     * @author Samuel
     *
     */
    public class BagEquipDlg extends BagEquipDlgBase {
        private var _herowidgetData:WidgetData;
        private var _widgetData:WidgetData;
        private var _heroData:HeroData;
        private var equipDataList:Array = [];
        private var _selectedAnimation:SpriterClip;
        private var _equipBallBar:EquipBallBarRendler;
        private var _statue:int = 0;

        public function BagEquipDlg() {
            super();
        }

        override protected function init():void {
            _closeButton = btn_close;
            bgImage0.alpha = bgImage1.alpha = bgImage2.alpha = bgImage3.alpha = bgImage4.alpha = 0.5;
            title.text = Langue.getLangue("goods_Inlaid_groove"); //镶嵌凹槽
            //useTitle.text = Langue.getLangue("EQUIP_TO"); //装备于
            enableTween = true;
            icon.visible = false;
            icon_hero.visible = false;
            replace_Scale9Button.text = Langue.getLangue("EQUIP");
            _selectedAnimation = AnimationCreator.instance.create("effect_012", AssetMgr.instance);
            _selectedAnimation.play("effect_012");
            _selectedAnimation.animation.looping = true;

            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.paddingTop = 5;
            layout.useSquareTiles = false;
            layout.useVirtualLayout = true;
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_eq.layout = layout;
            list_eq.itemRendererFactory = listItemRendererFactory;

            replace_Scale9Button.disable = true;

            _equipBallBar = new EquipBallBarRendler();
            _equipBallBar.x = 432;
            _equipBallBar.y = 190;
            addQuiackChild(_equipBallBar);

            var tmpArray:Array = Val.MAGICBALL;
            var len:int = tmpArray.length;
            var goods_title:TextField;
            var langue:Array = Langue.getLans("ENCHANTING_TYPE");
            for (var i:int = 0; i < len; i++) {
                var nameStr:String = tmpArray[i];
                if (i >= 2) {
                    goods_title = this[nameStr + "Name"] as TextField;
                    goods_title.text = langue[i];
                }
            }
        }

        private function listItemRendererFactory():HeroEquipBagRender {
            var itemRender:HeroEquipBagRender = new HeroEquipBagRender(_selectedAnimation);
            itemRender.setSize(100, 100);
            return itemRender;
        }

        /**初始化监听*/
        override protected function addListenerHandler():void {
            super.addListenerHandler();
            replace_Scale9Button.addEventListener(Event.TRIGGERED, replaceHandler);
            this.addContextListener(EventType.NOTIFY_HERO_EQUIP, notifyHeroEquip);
            this.addContextListener(EventType.SELECT_HERO_EQUIP, onEquipListChange);
        }


        /**装备信息更新*/
        private function notifyHeroEquip(e:Event, info:Object):void {
            _heroData = info as HeroData;
            if (_statue == 0) //装备
            {
                _herowidgetData.equip = _widgetData.equip = _heroData.id;
                _herowidgetData.id = _widgetData.id;
                this.close();
            } else if (_statue == 1) //卸下
            {
                _herowidgetData.equip = _widgetData.equip = 0;
                _herowidgetData.id = 0;
            } else if (_statue == 2) //替换
            {
                _herowidgetData = _widgetData.clone() as WidgetData;
                _herowidgetData.equip = _widgetData.equip = _heroData.id;
                _herowidgetData.id = _widgetData.id;
            }
            update();
        }

        /**操作功能 装备 卸下 替换*/
        private function replaceHandler(e:Event):void {
            if (_statue == 0) //装备
            {
                EquipMessage.sendReplaceEquip(_herowidgetData.seat, _heroData, _widgetData.id);
                close();
            } else if (_statue == 1) //卸下
            {
                EquipMessage.sendReplaceEquip(_herowidgetData.seat, _heroData, 0);
            } else if (_statue == 2) //替换
            {
                EquipMessage.sendReplaceEquip(_herowidgetData.seat, _heroData, _widgetData.id);
            }
        }

        /**选中格子*/
        private function onEquipListChange(e:Event, info:WidgetData):void {
            _widgetData = info as WidgetData;
            if (_widgetData && _widgetData.id > 0) {
                replace_Scale9Button.disable = false;
                update();
            } else if (!_widgetData.isPack) {
                var data:Object = {data: Langue.getLangue("get_goods"), level: _heroData.level, type: _herowidgetData.sort};
                DialogMgr.instance.open(GetBestEquipDlg, data);
            }

        }

        /**显示*/
        override protected function show():void {
            setToCenter();
            _herowidgetData = _parameter.wid;
            _heroData = _parameter.hero;
            initEquipDataList();
            list_eq.dataProvider = new ListCollection(equipDataList);
            list_eq.selectedIndex = 0;
            _widgetData = list_eq.selectedItem as WidgetData;
            if (_widgetData && _widgetData.id > 0) {
                replace_Scale9Button.disable = false;
                update();
            }
        }
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			if(value)
			{
				initEquipDataList();
				list_eq.dataProvider = new ListCollection(equipDataList);
				
			}
		}

        /**更新*/
        private function update():void {
			
            text_Item.text = _widgetData.name;
            if (_widgetData.picture) {
                icon.texture = AssetMgr.instance.getTexture(_widgetData.picture);
                icon.visible = true;
            } else {
                icon.visible = false;
            }
            quality.texture = Res.instance.getQualityToolTexture(_widgetData.quality);
            useleve.text = Langue.getLangue("useLevel") + " Lv" + _widgetData.limitLevel;
			
			if(_widgetData.equip>0){
				var eqHero:HeroData = HeroData.hero.getValue(_widgetData.equip) as HeroData;
				//heroName.text = eqHero.name;
				icon_hero.texture = Res.instance.getHeroIconTexture(_heroData.show);
				quality_hero.texture = Res.instance.getQualityHeroTexture(_heroData.quality);
				quality_hero.visible = icon_hero.visible = true;
			}else{
				//heroName.text = "无"; 
				quality_hero.visible = icon_hero.visible = false;
			}
			
            if (_herowidgetData.id == 0 && _herowidgetData.equip == 0) //装备
            {
                replace_Scale9Button.text = Langue.getLangue("EQUIP");
                _statue = 0;
            } else {
                if (_widgetData.id == _herowidgetData.id && _herowidgetData.equip > 0) //卸下
                {
                    replace_Scale9Button.text = Langue.getLangue("noreplceNull");
                    _statue = 1;
                } else //替换
                {
                    replace_Scale9Button.text = Langue.getLangue("replace");
                    _statue = 2;
                }
            }

            /**---------------------------------------------------------*/
            var tmpArray:Array = Val.MAGICBALL;
            var len:int = tmpArray.length;
            var goods_title:TextField;
            var langue:Array = Langue.getLans("ENCHANTING_TYPE");
            for (var i:int = 0; i < len; i++) {
                var nameStr:String = tmpArray[i];
//                if (i >= 2) {
//                    goods_title = this[nameStr + "Name"] as TextField;
//                    goods_title.text = langue[i];
//                }
                var vTxt:TextField = this[nameStr];
                vTxt.text = _heroData[nameStr];
                var addTxt:TextField = this["add" + nameStr];
                var addValueTxt:TextField = this["add" + nameStr + "Value"];
                addValueTxt.text = "";
                if (_statue == 0) //装备
                {
                    addTxt.text = "+";
                    addValueTxt.text = _widgetData[nameStr];
                    addTxt.color = addValueTxt.color = 0x00ff00;
                } else if (_statue == 1) //卸下
                {
                    addTxt.text = "+";
                    addTxt.color = addValueTxt.color = 0x00ff00;
                    addValueTxt.text = "0";
                } else if (_statue == 2) //替换
                {
                    var nVule:int = _widgetData[nameStr] - _herowidgetData[nameStr];
                    if (nVule >= 0) {
                        addTxt.text = "+";
                        addTxt.color = addValueTxt.color = 0x00ff00;
                    } else {
                        addTxt.text = "0";
                        addTxt.color = addValueTxt.color = 0xff0000;
                    }
                    addValueTxt.text = nVule.toString();
                }
            }
            _equipBallBar.updata(_widgetData);
        }

        /**初始化数据*/
        private function initEquipDataList():void {
			equipDataList.length = 0;
            var widgetArr:Vector.<*> = WidgetData.hash.values();
            var widget:WidgetData;
            var equip:int = GameMgr.instance.bagequ;
            var i:int = 0;
            for each (widget in widgetArr) {
                //装备
                if (widget.tab == 5 && i < equip && widget.seat == _herowidgetData.seat && widget.sort == _herowidgetData.sort) {
                    if (widget.equip == 0 || widget.equip == _heroData.id) // 别人英雄身上的装备不在背包里显示
                    {
                        equipDataList.push(widget);
                        i++;
                    }
                }
            }
			equipDataList.sortOn("limitLevel",Array.DESCENDING);
            widget = new WidgetData();
            widget.isPack = false;
            equipDataList.push(widget);
            if (equipDataList.length < 12) {
                var len:int = 12 - equipDataList.length;
                for (i = 0; i < len; i++) {
                    widget = new WidgetData();
                    widget.seat = _herowidgetData.seat;
                    widget.sort = _herowidgetData.sort;
                    equipDataList.push(widget);
                }
            }
        }

        override public function dispose():void {
            _herowidgetData = null;
            _widgetData = null;
            equipDataList = null;
            _equipBallBar.removeFromParent(true);
            _selectedAnimation.removeFromParent(true);
            list_eq.removeFromParent(true);
            replace_Scale9Button.removeFromParent(true);
            super.dispose();
        }

    }
}
