package game.view.goodsGuide {
    import com.dialog.Dialog;
    import com.dialog.DialogMgr;
    import com.scene.SceneMgr;
    import com.utils.ArrayUtil;
    import com.utils.Constants;
    import com.view.View;
    import com.view.base.event.EventType;

    import game.data.ForgeData;
    import game.data.Goods;
    import game.net.message.GameMessage;
    import game.scene.BattleScene;
    import game.view.city.CityFace;
    import game.view.gameover.LostView;
    import game.view.goodsGuide.view.GoodsDropList;
    import game.view.goodsGuide.view.GoodsGuideForgeView;
    import game.view.goodsGuide.view.GoodsGuideList;

    import starling.animation.Transitions;
    import starling.core.Starling;
    import starling.events.Event;

    /**
     * 获得最好的装备
     * @author hyy
     *
     */
    public class GetBestEquipDlg extends Dialog {
        private var list_goods:GoodsGuideList;
        private var view_drop:GoodsDropList;
        private var view_forge:GoodsGuideForgeView;

        public function GetBestEquipDlg() {
            super(true);
        }

        override protected function init():void {
            list_goods = new GoodsGuideList();
            addChild(list_goods);
            clickBackroundClose();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            this.addContextListener(EventType.SELECTED_TITLE_GOODS_GUIDE, onSelectedGOodsGuide);
            this.addContextListener(EventType.CHANGE_BATTLE, onChangeBattle);
        }

        private function onChangeBattle(event:Event, id:int):void {
            var currScene:Class = DialogMgr.instance.currScene;
            if (currScene == BattleScene) {
                currScene = CityFace;
            }
            DialogMgr.instance.deleteDlg(LostView);
            GameMessage.removeBackDialog(LostView);
            GameMessage.gotoTollgateData(id, currScene, DialogMgr.instance.currDialogs, DialogMgr.instance.currDialogParams);
        }

        override protected function show():void {
            var tmp_goods:Object = _parameter;
            var type:int = int(tmp_goods.type);
            var level:int = int(tmp_goods.level);
            var tmp_list:Array = ArrayUtil.change2Array(Goods.goods.values());
            var tmp_guide_list:Array = [];
            var list:Array = [];
            var goods:Goods;
            for each (goods in tmp_list) {
                if (goods.sort == type && goods.tab == 5) {
                    if (goods.isGuide == 2 && goods.isPvp == 2) {
                        list.push(goods);
                    }
                }
            }
            list.sortOn("limitLevel", Array.NUMERIC);
            var isBest:Boolean;
            var len:int = list.length;
            for (var i:int = 0; i < len; i++) {
                goods = list[i];
                if (goods.limitLevel > level) {
                    if (!isBest) {
                        isBest = true;
                    } else {
                        continue;
                    }

                }

                tmp_guide_list.push(goods);
            }
            tmp_guide_list.sort(function(a:Goods, b:Goods):int {
                if (a.limitLevel > b.limitLevel) {
                    return -1;
                } else if (a.limitLevel < b.limitLevel) {
                    return 1;
                }
                return 0;
            });

            for each (goods in tmp_guide_list) {
                goods.isPack = false
            }
            list_goods.list = tmp_guide_list;
            list_goods.easingIn();
        }

        private function onSelectedGOodsGuide(evt:Event, goods:Goods):void {
            var forgeData:ForgeData = ForgeData.hash.getValue(goods.type);
            var tmp_view:View;

            if (forgeData) {
                if (view_forge == null) {
                    view_forge = new GoodsGuideForgeView();
                    view_forge.x = list_goods.width - 30;
                    view_forge.y = list_goods.y;
                }
                view_forge.data = forgeData;
                tmp_view = view_forge;
            } else if (goods.drop_location) {
                if (view_drop == null) {
                    view_drop = new GoodsDropList();
                    view_drop.x = list_goods.width - 30;
                    view_drop.y = list_goods.y;
                }
                view_drop.data = goods;
                tmp_view = view_drop;
            }
            view_drop && view_drop.removeFromParent();
            view_forge && view_forge.removeFromParent();

            var left_width:int = list_goods.width - 30;
            var right_width:int = tmp_view ? tmp_view.width - 30 : 0;
            var left_x:int = (Constants.virtualWidth - left_width - right_width) * .5;
            var right_x:int = left_x + left_width + 4;
            tmp_view && addChildAt(tmp_view, 0);
            Starling.juggler.tween(list_goods, 0.3, {x: left_x, transition: Transitions.EASE_OUT});
            tmp_view && Starling.juggler.tween(tmp_view, 0.3, {x: right_x, transition: Transitions.EASE_OUT});
        }

        override public function close():void {
            if (SceneMgr.instance.isScene(CityFace)) {
                GameMessage.removeBackAllDialog();
            }
            super.close();
        }

        override public function dispose():void {
            view_drop && view_drop.removeFromParent(true);
            view_forge && view_forge.removeFromParent(true);
            super.dispose();
        }
    }
}
