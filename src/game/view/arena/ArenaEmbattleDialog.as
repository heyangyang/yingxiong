package game.view.arena {
    import com.langue.Langue;
    import com.utils.Constants;

    import feathers.controls.Scroller;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.common.JTGlobalDef;
    import game.data.HeroData;
    import game.data.Val;
    import game.dialog.ShowLoader;
    import game.fight.Position;
    import game.manager.HeroDataMgr;
    import game.managers.JTFunctionManager;
    import game.managers.JTPvpInfoManager;
    import game.managers.JTSingleManager;
    import game.net.GameSocket;
    import game.net.data.IData;
    import game.net.data.c.CColiseumPoses;
    import game.net.data.vo.coliseumPosesVO;
    import game.net.data.vo.getColiseumPosesVO;
    import game.view.arena.render.EmbattleHeroItem;
    import game.view.arena.render.EmbattleShowItem;
    import game.view.viewBase.ArenaEmbattleDialogBase;

    import starling.events.Event;

    /**
     * 竞技场窗口
     * @author Samuel
     */
    public class ArenaEmbattleDialog extends ArenaEmbattleDialogBase {
        /**自动布阵的阵型*/
        private var seat_index:int = 0;
        private var heroList:Vector.<*> = new Vector.<*>;
        private var onBattleList:Array = [];

        public function ArenaEmbattleDialog() {
            clickBackroundClose()
            super();
        }

        override protected function init():void {
            enableTween = true;
            const layout:TiledRowsLayout = new TiledRowsLayout();
            layout.useSquareTiles = false;
            layout.useVirtualLayout = true;
            layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            layout.paging = TiledRowsLayout.PAGING_VERTICAL;
            list_hero.layout = layout;
            list_hero.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
            list_hero.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_hero.itemRendererFactory = tileListItemRendererFactory;

            var embGrid:EmbattleShowItem = null;
            for (var i:int = 1; i <= Val.SEAT_COUNT; i++) {
                embGrid = this["emb_" + i] as EmbattleShowItem;
                embGrid.setPosIndex(i);
            }

            var arr:Array = Langue.getLans("title_rank_name");
            txtPowerTitle.text = arr[1]; //当前战斗力
            enter_Scale9Button.text = arr[2] //确认阵型;
        }

        private function tileListItemRendererFactory():EmbattleHeroItem {
            const itemRender:EmbattleHeroItem = new EmbattleHeroItem();
            itemRender.setSize(100, 100);
            return itemRender;
        }

        /**初始化监听*/
        override protected function addListenerHandler():void {
            super.addListenerHandler();
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_REFRHES_BATTLE, onRefrhesBattle);
            JTFunctionManager.registerFunction(JTGlobalDef.PVP_UPDATE_BATTLE, onColiseumPoses);
            enter_Scale9Button.addEventListener(Event.TRIGGERED, onEnterHandler);
        }

        /**显示*/
        override protected function show():void {
            setToCenter();
            if (_parameter)
                showHeros();
        }

        /**显示自己的英雄*/
        private function showHeros():void {
            if (!heroList || heroList.length == 0) {
                heroList = HeroDataMgr.instance.hash.values();
                if (heroList.length < 12) {
                    var adlen:int = 12 - heroList.length;
                    for (var i:int = 0; i < adlen; i++) {
                        heroList.push(new HeroData());
                    }
                }
                for each (var data:HeroData in heroList) {
                    data.oldseat = data.seat;
                    data.seat = 0;
                }
                for each (var vo:getColiseumPosesVO in _parameter.poses) {
                    con: for each (var da:HeroData in heroList) {
                        if (vo.id == da.id) {
                            da.seat = Position.instance.posToSeat(vo.pos) - 1;
                            break con;
                        }
                    }
                }
            }
            list_hero.dataProvider = new ListCollection(heroList);
            if (list_hero.dataViewPort) {
                list_hero.dataViewPort.dataProvider_refreshItemHandler();
            }
            showBattleHeros();
        }

        /**显示已经布阵的英雄*/
        private function showBattleHeros():void {

            onBattleList = [];
            var power:int = 0;
            for each (var data:HeroData in heroList) {
                if (data.seat > 0) {
                    onBattleList.push(data);
                    power += data.getPower;
                }
            }

            txtPower.text = power.toString();
            onBattleList.sortOn("getPower", Array.DESCENDING | Array.NUMERIC);
            onBattleList.sortOn("hp", Array.DESCENDING);
            var count:int = onBattleList.length;
            var embGrid:EmbattleShowItem = null;
            var pos:int = 0;
            var i:int = 0;
            var heroData:HeroData;
            for (i = 1; i <= Val.SEAT_COUNT; i++) {
                embGrid = this["emb_" + i] as EmbattleShowItem;
                embGrid.data = null;
            }
            for (i = 0; i < count; i++) {
                heroData = onBattleList[i];
                if (heroData && heroData.seat > 0) {
                    pos = Position.instance.seatTopos(heroData.seat) + 1;
                    if (pos < 10) {
                        embGrid = this["emb_" + pos] as EmbattleShowItem;
                        embGrid.data = heroData;
                    }
                }
            }
        }

        /**确定阵型*/
        private function onEnterHandler(e:Event):void {
            var battVector:Vector.<IData> = new Vector.<IData>;
            var vo:coliseumPosesVO = null;
            for each (var heroData:HeroData in onBattleList) {
                vo = new coliseumPosesVO();
                vo.id = heroData.id;
                vo.pos = Position.instance.seatTopos(heroData.seat) + 1;
                battVector.push(vo);
            }
            if (battVector.length <= 0) {
                addTips("防守阵型一定要有英雄防守！");
                return;
            }
            var cmd:CColiseumPoses = new CColiseumPoses();
            cmd.poses = battVector;
            GameSocket.instance.sendData(cmd);
            ShowLoader.add();
        }

        /**是否成功布阵*/
        private function onColiseumPoses(info:Object):void {
            switch (info.code) {
                case 0:
                    var battVector:Vector.<IData> = new Vector.<IData>;
                    var gvo:getColiseumPosesVO = null;
                    for each (var heroData:HeroData in onBattleList) {
                        gvo = new getColiseumPosesVO();
                        gvo.id = heroData.id;
                        gvo.pos = Position.instance.seatTopos(heroData.seat) + 1;
                        battVector.push(gvo);
                    }
                    JTSingleManager.instance.pvpInfoManager.onbattle.poses = battVector;
                    JTFunctionManager.executeFunction(JTGlobalDef.PVP_GET_BATTLE, JTSingleManager.instance.pvpInfoManager.onbattle);
                    this.close();
                    addTips("布阵成功");
                    break;
                default:
                    addTips("程序异常");
                    break;
            }
            showBattleHeros();
            ShowLoader.remove();
        }

        /**
         * 刷新布阵
         * @param info
         *
         */
        private function onRefrhesBattle(info:Object):void {
            var curData:HeroData = info.curData.data; //当前英雄数据
            var tagetData:HeroData = info.tagetData ? info.tagetData.data : null; //目标英雄数据
            var curPos:int = info.curData.pos; //当前POS位置
            var tagetPos:int = info.tagetData ? info.tagetData.pos : 0; //目标POS位置
            var curType:int = info.curData.type; //当前数据类型 1布阵英雄，2 自己英雄
            var tagetType:int = info.tagetData ? info.tagetData.type : 0; //目标数据类型 1布阵英雄，2 自己英雄
            var curIndex:int = 0, tagetIndex:int = 0; //数组下标
            var len:int = onBattleList.length;

            //type 1上阵  2下阵  3交互（包括上阵 下阵）
            debug("布阵：" + info.type, "---", curPos, "---", tagetPos, '---', curType, '---', tagetType);

            if (curType == 1 && tagetType == 1 || curType == 1 && tagetType == 0) //在自己的英雄里面操作
            {
                if (info.type == 1) //点击自己的英雄直接上阵
                {
                    onSelectHeroToBattle(curData);
                } else if (info.type == 3) //自己英雄交互
                {
                    //不用交互
                }

            } else if (curType == 2 && tagetType == 2 || curType == 2 && tagetType == 0) //在布阵英雄里面操作
            {
                if (info.type == 2) //点击布阵英雄直接卸下
                {
                    curIndex = onBattleList.indexOf(curData);
                    if (curIndex != -1) {
                        curData.seat = 0;
                        onBattleList.splice(curIndex, 1);
                    }
                } else if (info.type == 3) //布阵英雄交互
                {
                    if (curPos != 0 && tagetPos != 0) {
                        if (tagetData == null) //拖到空位置修改seat
                        {
                            curData.seat = Position.instance.posToSeat(tagetPos - 1);
                        } else if (tagetData != null) //交互seat
                        {
                            curData.seat = Position.instance.posToSeat(tagetPos - 1);
                            tagetData.seat = Position.instance.posToSeat(curPos - 1);
                        }
                    } else if (curPos != 0 && tagetPos == 0) //点击布阵英雄直接卸下
                    {
                        curIndex = onBattleList.indexOf(curData);
                        if (curIndex != -1) {
                            curData.seat = 0;
                            onBattleList.splice(curIndex, 1);
                        }
                    }
                }
            } else if (curType == 1 && tagetType == 2) //自己的英雄到布阵英雄操作
            {
                if (tagetData == null) //布阵格子上没有英雄
                {
                    if (canBattleHero(curData)) //是否满足条件
                    {
                        curData.seat = Position.instance.posToSeat(tagetPos - 1);
                    }
                } else if (tagetData != null) //布阵格子上有英雄进行交互
                {
                    if (!currHeroIsBattle(curData)) //没上阵替换
                    {
                        tagetIndex = onBattleList.indexOf(tagetData);
                        if (tagetIndex != -1) {
                            curData.seat = tagetData.seat;
                            tagetData.seat = 0;
                        }
                    }
                }
            } else if (curType == 2 && tagetType == 1) //布阵英雄到自己的英雄操作
            {
                curIndex = onBattleList.indexOf(curData); //卸下英雄
                if (curIndex != -1) {
                    curData.seat = 0;
                    onBattleList.splice(curIndex, 1);
                }
            }

            showHeros();

        }


        /**选择英雄上阵*/
        private function onSelectHeroToBattle(heroData:HeroData):void {

            if (canBattleHero(heroData)) {
                onBattleList.push(heroData);
                var index:int, len:int, i:int;
                if (seat_index < 3) {
                    seat_index++;
                } else {
                    seat_index = 0;
                }
                var tmpArr:Array = JTPvpInfoManager.EMBATTLE[seat_index % JTPvpInfoManager.EMBATTLE.length];
                len = tmpArr.length;
                for (i = 0; i < len; i++) {
                    if (tmpArr[i] > 0) {
                        heroData = onBattleList[index++];
                        if (heroData) {
                            heroData.seat = Val.posC2S(i);
                        }
                    }
                }
                showHeros();
            }

        }

        /**可以上阵*/
        private function canBattleHero(heroData:HeroData):Boolean {
            var battleHero:HeroData = null;
            if (heroData && heroData.id > 0) {
                if (onBattleList.length >= Val.SEAT_MAX) {
                    addTips("上阵英雄已经达到最大限制");
                    return false;
                }
                if (currHeroIsBattle(heroData)) {
                    return false;
                }

            }
            return true;
        }

        /**当前英雄是否已经上阵*/
        private function currHeroIsBattle(heroData:HeroData):Boolean {
            if (heroData && heroData.id > 0) {
                var battleHero:HeroData = null;
                var len:int = heroList.length;
                for (var i:int = 0; i < len; i++) {
                    battleHero = heroList[i] as HeroData;
                    if (battleHero.id == heroData.id) {
                        if (battleHero.seat > 0) {
                            addTips("该英雄已经上阵");
                            return true;
                        }
                    }
                }
            }
            return false;
        }


        override public function dispose():void {
            JTFunctionManager.removeFunction(JTGlobalDef.PVP_REFRHES_BATTLE, onRefrhesBattle);
            JTFunctionManager.removeFunction(JTGlobalDef.PVP_UPDATE_BATTLE, onColiseumPoses);
            for each (var data:HeroData in heroList) {
                data.seat = data.oldseat;
                data.oldseat = 0;
            }
            heroList.length = 0;
            super.dispose();
        }
    }
}
