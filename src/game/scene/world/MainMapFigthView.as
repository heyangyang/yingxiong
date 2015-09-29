package game.scene.world {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.view.base.event.EventType;

    import feathers.controls.Scroller;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledColumnsLayout;
    import feathers.layout.TiledRowsLayout;

    import game.common.JTFastBuyComponent;
    import game.data.MainLineData;
    import game.dialog.ShowLoader;
    import game.manager.GameMgr;
    import game.net.GameSocket;
    import game.net.data.c.CSweep;
    import game.net.data.s.SSweep;
    import game.net.message.GameMessage;
    import game.net.message.GoodsMessage;
    import game.view.sweep.SweepDia;
    import game.view.viewBase.MainMapFigthViewBase;

    import starling.display.Image;
    import starling.events.Event;

    public class MainMapFigthView extends MainMapFigthViewBase {
        private var _data:MainLineData = null;
        public var _isNigth:Boolean = false;

        public function MainMapFigthView() {
            super();
        }

        override protected function init():void {
            bgImage3.visible = bgImage1.alpha = 0.25;
            noamBtn_Scale9Button.text = Langue.getLans("Pvp_nightmare_mode")[0]; //
            emBtn_Scale9Button.text = Langue.getLans("Pvp_nightmare_mode")[2];
            sdBtns_Scale9Button.text = Langue.getLangue("sweep_shi_raids"); //扫荡10次
            sdBtn_Scale9Button.text = Langue.getLangue("game_Sweep"); //扫荡
            figthBtn_Scale9Button.text = Langue.getLangue("Start_a_fight"); //开始战斗
            txt_power.text = Langue.getLangue("sweep_Physical_exertion"); //体力消耗
            txt_zheng.text = Langue.getLangue("Enemy_lineup"); //对敌阵容
            txt_goods.text = Langue.getLangue("sweep_Loot_goods"); //掉落物品
//            txt_quang.text = Langue.getLangue("sweep_Fu_raids"); //扫荡券
            emBtn_Scale9Button.visible = noamBtn_Scale9Button.visible = false;
//            sdBtns_Scale9Button.filter = sdBtn_Scale9Button.filter = new ColorMatrixFilter(Val.filter);

            const listLayout:TiledColumnsLayout = new TiledColumnsLayout();
            listLayout.horizontalGap = 10;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            listLayout.paging = TiledColumnsLayout.PAGING_HORIZONTAL; //自动排列
            list_goods.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_goods.layout = listLayout;
            list_goods.itemRendererFactory = itemEquipRendererFactory;

            const Layout:TiledColumnsLayout = new TiledColumnsLayout();
            Layout.useSquareTiles = false;
            Layout.useVirtualLayout = true;
            Layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            Layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            Layout.paging = TiledColumnsLayout.PAGING_HORIZONTAL; //自动排列
            list_monster.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_monster.layout = Layout;
            list_monster.itemRendererFactory = itemMonsterRendererFactory;
        }

        private function itemEquipRendererFactory():IListItemRenderer {
            const renderer:MainRewardRender = new MainRewardRender();
            renderer.setSize(98, 105);
            return renderer;
        }

        private function itemMonsterRendererFactory():IListItemRenderer {
            const renderer:MonsterItemRender = new MonsterItemRender();
            renderer.setSize(110, 95);
            return renderer;
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            addViewListener(emBtn_Scale9Button, Event.TRIGGERED, onTriggeredHandler);
            addViewListener(noamBtn_Scale9Button, Event.TRIGGERED, onTriggeredHandler);
            addViewListener(sdBtns_Scale9Button, Event.TRIGGERED, onTriggeredHandler);
            addViewListener(sdBtn_Scale9Button, Event.TRIGGERED, onTriggeredHandler);
            addViewListener(figthBtn_Scale9Button, Event.TRIGGERED, onTriggeredHandler);
            addContextListener(SSweep.CMD + "", messageNotification);
        }

        private function onTriggeredHandler(e:Event):void {
            switch (e.currentTarget) {
                case noamBtn_Scale9Button:
                case emBtn_Scale9Button:
                    if (_isNigth) {
                        _isNigth = false;
                        if (_data.isFb) {
                            noamBtn_Scale9Button.text = Langue.getLans("Pvp_nightmare_mode")[1]; //噩梦模式|困难模式|普通模式
                        } else {
                            noamBtn_Scale9Button.text = Langue.getLans("Pvp_nightmare_mode")[0];
                        }
                        emBtn_Scale9Button.visible = false;
                        noamBtn_Scale9Button.visible = true;
                        txt_pointName.text = _data.pointName;
                        txt_powerNum.text = _data.tollgateData.tired.toString();
                        list_goods.dataProvider = new ListCollection(_data.tollgateData.rewardList);
                    } else {
                        _isNigth = true;
                        if (_data.isFb) {
                            txt_pointName.text = _data.pointName;
                        } else {
                            txt_pointName.text = _data.pointName + "_" + Langue.getLangue("sweep_Nightmare"); //_噩梦;
                        }
                        emBtn_Scale9Button.visible = true;
                        noamBtn_Scale9Button.visible = false;
                        txt_powerNum.text = _data.tollgateData.nightmareData.tired.toString();
                        list_goods.dataProvider = new ListCollection(_data.tollgateData.nightmareData.rewardList);
                    }
                    break;

                case sdBtn_Scale9Button: //扫荡一次
                case sdBtns_Scale9Button: //扫荡10次
                    if (GameMgr.instance.vip <= 0) {
                        RollTips.add(Langue.getLangue("upgrade_no_vip")); //不是Vip
                        return;
                    } else if (_data) {
                        GameMgr.instance.game_type = _data.isFb ? GameMgr.FB : GameMgr.MAIN_LINE;
                        var _tollgateId:int = 0;
                        var isPass:Boolean = (GameMgr.instance.tollgateID > _data.pointID);
                        if (!isPass) //主线或者副本未开启
                        {
                            RollTips.addLangue(Langue.getLangue("onOpen") + (_data ? _data.pointName : ""));
                            return;
                        }
                        if (!_data.isFb && _data.boss_type < 2) {
                            RollTips.addLangue("onPass"); //主线已经通关不能再打小关卡
                            return;
                        }

                        if (_isNigth) {
                            if (_data.isFb) {
                                if (GameMgr.instance.tollgateID < data.pointID) {
                                    var _lastPoint:MainLineData = MainLineData.getPoint(data.pointID - 1);
                                    RollTips.add(Langue.getLangue("onOpen") + "  " + (_lastPoint ? _lastPoint.pointName : "") + "," + Langue.getLangue("Enter_difficulty_mode_raids")); //即可进入困难模式扫荡
                                    return;
                                }
                            } else {
                                if (_data.tollgateData.nightmare_star < 7) {
                                    RollTips.add(Langue.getLangue("enter_nightmare_mode_raids")); //要通过3星评星，即可进入噩梦模式扫荡
                                    return;
                                }
                            }
                            _tollgateId = _data.tollgateData.nightmareData.id;
                        } else {
                            _tollgateId = _data.isFb ? _data.id : _data.pointID;
                        }

                        var csweep:CSweep = new CSweep();
                        if (_tollgateId) {
                            switch (GameMgr.instance.game_type) {
                                case 0: //主线
                                    csweep.type = 1;
                                    break;
                                case 1: //副本
                                    csweep.type = 2;
                                    break;
                            }

                            if (_tollgateId > 20000) { //噩梦
                                csweep.type = 5;
                            }
                        } else if (GameMgr.instance.game_type == 3) {
                            csweep.type = 3;
                        }
                        csweep.gate = _tollgateId;
                        if (e.currentTarget == sdBtn_Scale9Button) {
                            csweep.num = 1;
                            if (GameMgr.instance.tired < _data.tollgateData.tired) {
                                DialogMgr.instance.isVisibleDialogs(true);
                                GoodsMessage.onBuyTiredClick();
                            }
                        } else if (e.currentTarget == sdBtns_Scale9Button) {
                            csweep.num = 10;
                            if (GameMgr.instance.tired < (_data.tollgateData.nightmareData.tired * 10)) {
                                DialogMgr.instance.isVisibleDialogs(true);
                                GoodsMessage.onBuyTiredClick();
                            }
                        }
                        GameSocket.instance.sendData(csweep);
                        ShowLoader.add();
                    }
                    break;

                case figthBtn_Scale9Button:
                    if (_data) {
                        GameMgr.instance.game_type = _data.isFb ? GameMgr.FB : GameMgr.MAIN_LINE;
                        var tollgateId:int = 0;
                        if (_isNigth) {
                            if (_data.isFb) {
                                if (GameMgr.instance.tollgateID < data.pointID) {
                                    var lastPoint:MainLineData = MainLineData.getPoint(data.pointID - 1);
                                    RollTips.add(Langue.getLangue("onOpen") + "  " + (lastPoint ? lastPoint.pointName : "") + "," + Langue.getLangue("Enter_difficulty_modes")); //即可进入困难模式
                                    return;
                                }
                            } else {
                                if (_data.tollgateData.nightmare_star < 7) {
                                    RollTips.add(Langue.getLangue("star_rating_star_can_nightmareMode")); //要通过3星评星，即可进入噩梦模式
                                    return;
                                }
                            }
                            tollgateId = _data.tollgateData.nightmareData.id;
                        } else {
                            tollgateId = _data.isFb ? _data.id : _data.pointID;
                        }
                        GameMessage.gotoTollgateData(tollgateId);
                    }
                    break;
            }
        }

        protected function messageNotification(evt:Event, sSweep:SSweep):void {
            if (0 == sSweep.code) {
//                RollTips.add(Langue.getLangue("sweep_ok")); //成功
                DialogMgr.instance.isVisibleDialogs(true);
                DialogMgr.instance.open(SweepDia, {data: _data, sweep: sSweep});
                GameMgr.instance.tired = sSweep.tried;
                this.dispatch(EventType.UPDATE_TIRED);
            } else if (1 == sSweep.code) {
                RollTips.add(Langue.getLangue("sweep_star_Appraisal")); //评星不够
            } else if (2 == sSweep.code) {
                RollTips.add(Langue.getLangue("sweep_Inadequate_tired")); //疲劳值不足
                DialogMgr.instance.isVisibleDialogs(true);
                GoodsMessage.onBuyTiredClick();
            } else if (3 == sSweep.code) {
                RollTips.add(Langue.getLangue("sweep_Inadequate")); //扫荡卡不足
                DialogMgr.instance.isVisibleDialogs(true);
                DialogMgr.instance.open(JTFastBuyComponent, JTFastBuyComponent.FAST_BUY_SWEEP);
            } else if (4 == sSweep.code) {
                RollTips.add(Langue.getLangue("Clearance_once_current_level")); //通关一下当前关卡
            } else if (127 <= sSweep.code) {
                RollTips.add(Langue.getLangue("codeError")); //程序异常
            }
            ShowLoader.remove();
        }

        public function set data(value:MainLineData):void {
            if (value == null) {
                return;
            }
            _isNigth = false;
            noamBtn_Scale9Button.text = Langue.getLans("Pvp_nightmare_mode")[0]; //噩梦模式|困难模式|普通模式
            emBtn_Scale9Button.text = Langue.getLans("Pvp_nightmare_mode")[2]; //噩梦模式|困难模式|普通模式
            emBtn_Scale9Button.visible = noamBtn_Scale9Button.visible = false;
            _data = value;
            txt_powerNum.text = _data.tollgateData.tired.toString();
            txt_pointName.text = _data.pointName;
            if (!_data.isFb) //主线关卡
            {
                noamBtn_Scale9Button.text = Langue.getLans("Pvp_nightmare_mode")[0]; //噩梦模式|困难模式|普通模式
                noamBtn_Scale9Button.visible = _data.boss_type > 1;
            } else {
                noamBtn_Scale9Button.text = Langue.getLans("Pvp_nightmare_mode")[1]; //噩梦模式|困难模式|普通模式
                noamBtn_Scale9Button.visible = true;
            }
            var star:Image = null;
            for (var j:int = 0; j < 3; j++) {
                star = this["star_" + j] as Image;
                if (!_data.isFb) {
                    star.visible = (_data.tollgateData.nightmare_star & Math.pow(2, j)) == 0 ? false : true;
                } else {
                    star.visible = false;
                }
            }
            list_monster.dataProvider = new ListCollection(filterArray());
            list_goods.dataProvider = new ListCollection(_data.tollgateData.rewardList);
        }

        private function filterArray():Array {
            var monsters:Array = _data.tollgateData.monsters;
            var arr:Array = [];
            var len:uint = monsters.length;
            var i:int = 0;
            for (i = 0; i < len; i++) {
                arr.push(monsters[i][0]);
            }

            var tempArr:Array = [];
            len = arr.length;
            for (i = 0; i < len; i++) {
                if (tempArr.indexOf(arr[i]) == -1) {
                    //在新的数组里搜索是否存在相同元素,如果不存在加进新的数组里
                    tempArr.push(arr[i]);
                }
            }

            var dataArr:Array = [];
            for (i = 0; i < tempArr.length; i++) {
                if (tempArr[i] == _data.boss_id) {
                    dataArr.push({id: tempArr[i], type: 1})
                } else {
                    dataArr.push({id: tempArr[i], type: 0})
                }
            }
            return dataArr;
        }

        public function get data():MainLineData {
            return _data;
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
