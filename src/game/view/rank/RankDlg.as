/**
 * Created by Administrator on 2014/10/1.
 */
package game.view.rank {
    import com.langue.Langue;
    import com.mvc.interfaces.INotification;
    import com.utils.FilterUtils;
    import com.view.base.event.EventType;

    import feathers.controls.renderers.DefaultListItemRenderer;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.manager.GameMgr;
    import game.net.GameSocket;
    import game.net.data.IData;
    import game.net.data.c.CRankList;
    import game.net.data.s.SRankHero;
    import game.net.data.s.SRankList;
    import game.net.data.vo.RankInfo;
    import game.view.viewBase.RankDlgBase;

    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    public class RankDlg extends RankDlgBase {
        public static const RANK_STAR:int = 1;
        public static const RANK_MONEY:int = 2;
        public static const RANK_FIGHT:int = 3;
        public static const RANK_PVP:int = 4;
        private static const hash:Object = {0: RANK_PVP, 1: RANK_MONEY};
        private static const hashRender:Object = {4: RankPVPRender, 2: RankRichRender};
        private var _rankListDataCache:Object = {};
        private var _selfRank:Object = [];

        override protected function init():void {
            _closeButton = btn_close;
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            //选中标签页
            this.addContextListener(EventType.SELECTTAB, onSelectTab);
        }

        /**选中标签页*/
        private function onSelectTab(evt:Event = null, index:int = 0):void {
            var rankInfos:SRankList = _rankListDataCache[hash[index]];

            list_pvp.visible = index == 0;
            list_rich.visible = !list_pvp.visible;
            if (rankInfos) {
                refreshList(rankInfos);
                updateSelfRank(hash[index], null);
            } else {
                getRankInfos(hash[index]);
            }
        }

        private function updateSelfRank(type:int, ranks:Vector.<IData>):void {
            // 设置自己排行榜的位置
            var renderer:DefaultListItemRenderer = _selfRank[type];
            if (!_selfRank[type]) {
                renderer = new hashRender[type]();
                renderer.x = 176;
                renderer.y = 460;
                addChild(renderer);
                _selfRank[type] = renderer;
                FilterUtils.colorMatrixFilter(renderer["bgImage0"], -25, 25, 96, -30, 1);
                renderer["bgImage1"].alpha = 0.5;
            }

            for each (var rank:RankInfo in ranks) {
                if (rank.id == GameMgr.instance.uid) {
                    renderer.data = rank;
                    break;
                }
            }

            if (renderer.data == null) {
                var info:RankInfo = new RankInfo();
                info.index = 51;
                info.id = GameMgr.instance.uid;
                info.name = GameMgr.instance.arenaname;
                info.picture = GameMgr.instance.picture;
                renderer.data = info;
            }

            for each (var r:DefaultListItemRenderer in _selfRank) {
                r.visible = (r == renderer);
            }
        }

        /**列出按钮*/
        override protected function listTabButton():Array {
            var arr:Array = Langue.getLans("rankType");
            tab_1.text = Langue.getLangue("game_play_Honor");
            tab_2.text = arr[1];
            return [tab_1, tab_2];
        }

        public function getRankInfos(type:int):void {
            var sendRanksPackage:CRankList = new CRankList();
            sendRanksPackage.type = type;
            GameSocket.instance.sendData(sendRanksPackage);
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();

            var listLayout:TiledRowsLayout = new TiledRowsLayout();
            listLayout.gap = 5;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_rich.layout = listLayout;
            list_rich.itemRendererFactory = tileListItemRichRendererFactory;
            list_rich.addEventListener(Event.SELECT, onRichSelect);

            listLayout = new TiledRowsLayout();
            listLayout.gap = 5;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_pvp.layout = listLayout;
            list_pvp.itemRendererFactory = tileListItemRendererFactory;
            list_pvp.addEventListener(Event.SELECT, onSelect);
        }

        private function tileListItemRendererFactory():IListItemRenderer {
            var renderer:RankPVPRender = new RankPVPRender();
            renderer.setSize(738, 82);
            return renderer;
        }

        private function tileListItemRichRendererFactory():IListItemRenderer {
            var renderer:RankRichRender = new RankRichRender();
            renderer.setSize(738, 82);
            return renderer;
        }

        private function onRichSelect(e:Event):void {
            trace(this, "onRichSelect");
        }

        private function onSelect(e:Event):void {
            trace(this, "onSelect");
        }

        override public function listNotificationName():Vector.<String> {
            var v:Vector.<String> = new Vector.<String>();
            v.push(SRankList.CMD, SRankHero.CMD);
            return v;
        }

        override public function handleNotification(gameData:INotification):void {
            var downProtocol:String = gameData.getName();
            switch (downProtocol) {
                case SRankList.CMD.toString():  {
                    var rankInfos:SRankList = gameData as SRankList;
                    var type:int = rankInfos.type;
                    _rankListDataCache[type] = rankInfos;
                    refreshList(rankInfos);
                    updateSelfRank(type, rankInfos.ranks);
                    break;
                }
                case SRankHero.CMD.toString():  {
                    break;
                }
                default:
                    break;
            }
        }

        private function refreshList(rankInfos:SRankList):void {
            if (rankInfos.type == RANK_MONEY) {
                list_rich.dataProvider = new ListCollection(rankInfos.ranks);
            } else if (rankInfos.type == RANK_PVP) {
                list_pvp.dataProvider = new ListCollection(rankInfos.ranks);
            }
        }

        override public function dispose():void {
            _selfRank = null;
            _rankListDataCache = null;
            list_rich.removeFromParent(true);
            list_pvp.removeFromParent(true);
            super.dispose();
        }

    }
}
