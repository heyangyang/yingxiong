package game.view.embattle {

    import com.langue.Langue;
    import com.view.base.event.EventType;

    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.net.message.GameMessage;
    import game.utils.LocalShareManager;
    import game.view.uitils.Res;
    import game.view.viewBase.BattleVideoRankBase;

    import starling.core.Starling;
    import starling.events.Event;

    /**
     * 战报列表
     * @author hyy
     *
     */
    public class BattleVideoRank extends BattleVideoRankBase {
        private var rankList:Array;
        public var isTweening:Boolean = false;
        public var isOpen:Boolean;

        public function BattleVideoRank() {
            super();
        }

        override protected function init():void {
            bgImage0.alpha = bgImage1.alpha = bgImage2.alpha = 0.5;
            text_Help.text = Langue.getLangue("Help_Clearance"); //通关帮助
            bgImage.touchable = false;
            look0_Scale9Button.text = look1_Scale9Button.text = look2_Scale9Button.text = Langue.getLangue("go_to_Watch"); //观看
            //只有关卡才显示战报
            this.visible = GameMgr.instance.tollgateData && GameMgr.instance.tollgateData.id < 1000;
            //初始化
            battleRankNotify(null, []);
        }

        override protected function show():void {
            if (!visible) {
                return;
            }
            //更新上次战报是否打开
            isOpen = int(LocalShareManager.getInstance().get(LocalShareManager.BEAST_BATTLE)) == 1;
            isOpen = !isOpen;
            onTweenClick();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            for (var i:int = 0; i < 3; i++) {
                this.addViewListener(this["look" + i + "_Scale9Button"], Event.TRIGGERED, onClick);
            }
            this.addViewListener(btn_menu, Event.TRIGGERED, onTweenClick);
            this.addViewListener(btn_menu1, Event.TRIGGERED, onTweenClick);
            this.addContextListener(EventType.UPDATE_BATTLE_VIDEO_RANK, battleRankNotify);
        }

        private function onClick(evt:Event):void {
            var index:int = evt.target["name"];
            if (rankList && rankList[index]) {
                GameMessage.sendBattleRankVideoInfo((index + 1), GameMgr.instance.tollgateData.id);
            }
        }

        public function onTweenClick(isSave:Boolean = true):void {
            if (isTweening) {
                return;
            }
            isOpen = !isOpen;

            if (x == (isOpen ? 0 : -520)) {
                return;
            }

            if (x == -520) {
                btn_menu.upState = AssetMgr.instance.getTexture("icon_shouqicaozuolan02_tubiao");
            } else {
                btn_menu.upState = AssetMgr.instance.getTexture("icon_huchucaozuolan02_tubiao");
            }

            isTweening = true;
            Starling.juggler.tween(this, 0.3, {x: isOpen ? 0 : -520, onComplete: onComplete});

            //请求战报数据
            if (isOpen && rankList == null) {
                GameMessage.sendBattleRank(GameMgr.instance.tollgateData.id);
            }

            function onComplete():void {
                isSave && LocalShareManager.getInstance().save(LocalShareManager.BEAST_BATTLE, isOpen ? 1 : 0);
                isTweening = false;
            }
        }

        private function battleRankNotify(evt:Event, tmp_list:Array):void {
            var len:int = tmp_list.length;
            var data:Object;
            if (evt) {
                rankList = tmp_list;
            }

            for (var i:int = 0; i < 3; i++) {
                data = tmp_list[i];
                this["look" + i + "_Scale9Button"].visible = data;
                this["look" + i + "_Scale9Button"].name = data ? data.index : 0;
                this["txt_power" + i].text = data ? data.power : "";
                this["txt_name" + i].text = data ? data.name : getLangue("NOTENCHANTING");
                this["ico_hero" + i].texture = Res.instance.getRolePhoto(data ? data.picture : 0); //人物头像
            }
        }
    }
}
