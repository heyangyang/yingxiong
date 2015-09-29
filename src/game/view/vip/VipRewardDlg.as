package game.view.vip {
    import com.langue.Langue;
    import com.view.base.event.EventType;

    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledColumnsLayout;

    import game.data.VipData;
    import game.manager.GameMgr;
    import game.net.message.RoleInfomationMessage;
    import game.view.viewBase.VipRewardDlgBase;

    import starling.events.Event;

    /**
     * vip特权礼包
     * @author hyy
     *
     */
    public class VipRewardDlg extends VipRewardDlgBase {
        public function VipRewardDlg() {
            super();
        }

        override protected function init():void {
            enableTween = true;
            clickBackroundClose();
            var vipId:int = seatVipId(GameMgr.instance.vip);
            var list_goods:Array = VipData.list_dayReward[vipId == 0 ? 5 : vipId];
            list_reward.dataProvider = new ListCollection(list_goods);
            updateVip(null, GameMgr.instance.vipData);

            const listLayout:TiledColumnsLayout = new TiledColumnsLayout();
            listLayout.gap = 15;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.verticalAlign = TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
            listLayout.horizontalAlign = TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
            list_reward.layout = listLayout;
            list_reward.itemRendererFactory = itemRendererFactory;
        }

        private function itemRendererFactory():IListItemRenderer {
            const renderer:VipRewardRender = new VipRewardRender();
            return renderer;
        }

        /**当前的VIP礼包*/
        public function seatVipId(vipLv:int):int {
            if (vipLv > 0) {
                if (vipLv < 5) {
                    return 1;
                } else if (vipLv < 7) {
                    return 2;
                } else if (vipLv < 11) {
                    return 3;
                } else if (vipLv < 14) {
                    return 4;
                }
                return 5;
            }
            return 0;
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            addViewListener(get_Scale9Button, Event.TRIGGERED, onClick);
            addContextListener(EventType.UPDATE_VIP, updateVip);
        }

        override protected function show():void {
            setToCenter();
            updateVip(null, GameMgr.instance.vipData);
        }

        /**
         * 更新VIP等级
         * @param vipLevel
         */
        private function updateVip(evt:Event, vipData:VipData):void {
            var isGet:Boolean = vipData.dayPrize > 0;
            var vipId:int = seatVipId(GameMgr.instance.vip);
            if (vipData.baseVip.dayPrize != vipId && vipId > 0) {
                isGet = true;
            }

            if (vipId == 0) {
                get_Scale9Button.disable = !isGet;
                get_Scale9Button.text = "你还不是Vip";
                return
            } else {
                get_Scale9Button.disable = isGet;
            }

            if (isGet) {
                get_Scale9Button.text = Langue.getLangue("alreadyUse"); //已经领取
            } else {
                get_Scale9Button.text = Langue.getLangue("okUse"); //可领取
            }
        }

        /**
         * 领取奖励
         */
        private function onClick():void {
            RoleInfomationMessage.sendGetVipReward();
        }
    }
}
