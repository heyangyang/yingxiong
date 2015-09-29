package game.view.chat.component {
    import com.dialog.DialogMgr;

    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import game.base.JTSprite;
    import game.common.JTGlobalDef;
    import game.common.JTSession;
    import game.data.ConfigData;
    import game.manager.GameMgr;
    import game.managers.JTFunctionManager;
    import game.view.dispark.DisparkControl;
    import game.view.dispark.data.ConfigDisparkStep;

    import starling.display.Sprite;

    /**
     * 聊天小界面与大界面之间切换的容器
     * @author CabbageWrom
     *
     */
    public class JTChatControllerComponent extends JTSprite {
        public static var isShowCityIcon:Boolean = false;
        private var timer:Timer = null;
        private var interval:int = 30;
        public static var instance:JTChatControllerComponent = null;

        public function JTChatControllerComponent() {
            super();
            initialize();
            timer = new Timer(1000, GameMgr.instance.chatTime);
            timer.addEventListener(TimerEvent.TIMER, onTimerHandler);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteHandler);
            JTFunctionManager.registerFunction(JTGlobalDef.MAX_SWITCHOVER_MIN, onMaxSwitchMinPanel);
            JTFunctionManager.registerFunction(JTGlobalDef.MIN_SWITCHOVER_MAX, onMinSwitchMaxPanel);
        }

        protected function onTimerHandler(e:TimerEvent):void {
            var timer:Timer = e.target as Timer;
            var totalCount:int = timer.repeatCount;
            var currentCount:int = timer.currentCount;
            this.interval = totalCount - currentCount;
        }

        protected function onTimerCompleteHandler(e:TimerEvent):void {
            var timer:Timer = e.target as Timer;
            interval = GameMgr.instance.chatTime;
            timer.stop();
        }

        private function onMinSwitchMaxPanel():void {
            JTChatMiniComponent.colse();
            JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
            DialogMgr.instance.open(JTChatMaxComponent, null, null, cancelHandler);
        }

        /**改变时显示元素*/
        private function cancelHandler(e:*):void {
            JTFunctionManager.executeFunction(JTGlobalDef.PLAY_CITY_ANIMATABLE);
        }

        public function getInterval():int {
            return this.interval;
        }

        public function getTimer():Timer {
            return timer;
        }

        public function resetTimer():void {
            if (timer) {
                timer.reset();
                timer.start();
            }
        }

        public function timerRunning():Boolean {
            if (timer) {
                return timer.running;
            }
            return false;
        }

        private function onMaxSwitchMinPanel():void {
            initialize();
        }

        private function initialize():void {
            JTChatMiniComponent.open(this);
        }

        public static function open(parent:Sprite):void {
            if (!instance) {
                instance = new JTChatControllerComponent();
                JTSession.layerChat.addChild(instance);
                //智能判断是否添加功能开放提示图标（聊天）
                DisparkControl.instance.addDisparkHandler(ConfigDisparkStep.DisparkStep6);

                if (GameMgr.instance.tollgateID > ConfigData.instance.arenaGuide) {
                    if (GameMgr.instance.arenaname == "") {
                        //RollTips.add(Langue.getLangue("chatRestrictStart"));
                    } else {
                        instance = new JTChatControllerComponent();
                        JTSession.layerChat.addChild(instance);
                    }
                }
            } else {
                instance.visible = true;
            }
        }

        public static function close():void {
            if (instance) {
                instance.removeFromParent(true);
                instance = null;
            }
        }

        public static function hide():void {
            if (instance) {
                instance.visible = false;
            }
        }

        override public function dispose():void {
            super.dispose();
            if (timer) {
                timer.stop();
                timer.removeEventListener(TimerEvent.TIMER, onTimerHandler);
                timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerCompleteHandler);
                timer = null;
            }
            JTFunctionManager.removeFunction(JTGlobalDef.MAX_SWITCHOVER_MIN, onMaxSwitchMinPanel);
            JTFunctionManager.removeFunction(JTGlobalDef.MIN_SWITCHOVER_MAX, onMinSwitchMaxPanel);
            JTChatMiniComponent.colse();
            instance = null;
        }

    }
}

//import com.utils.Constants;
//import game.view.chat.component.JTChatControllerComponent;
//import starling.display.Button;
//import starling.events.Event;
//import starling.textures.Texture;
//class JTMinImageButton extends Button {
//    public function JTMinImageButton(upState:Texture, text:String = "", downState:Texture = null) {
//        super(upState, text, downState);
//        this.touchable = true;
//        this.addEventListener(Event.TRIGGERED, onMouseClickHandler);
//        show();
//    }
//
//    public function show():void {
//        this.y = Constants.FullScreenHeight - this.height - 80;
//    }
//
//    private function onMouseClickHandler(e:Event):void {
//        if (JTChatControllerComponent.instance) {
//            JTChatControllerComponent.close();
//        } else {
//        }
//        e.stopImmediatePropagation();
//    }
//
//    override public function dispose():void {
//        super.dispose();
//        this.removeEventListener(Event.TRIGGERED, onMouseClickHandler);
//        this.removeFromParent();
//    }
//}
