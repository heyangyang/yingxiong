package game.view.chat.component {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.utils.Constants;
    import com.utils.StringUtil;
    import com.view.base.event.EventType;
    
    import flash.text.ReturnKeyLabel;
    import flash.utils.ByteArray;
    import flash.utils.getTimer;
    
    import feathers.controls.TextInput;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;
    
    import game.common.JTFastBuyComponent;
    import game.common.JTGlobalDef;
    import game.common.JTGlobalFunction;
    import game.common.JTLogger;
    import game.manager.GameMgr;
    import game.managers.JTFunctionManager;
    import game.managers.JTMessageInfoManager;
    import game.managers.JTSingleManager;
    import game.net.GameSocket;
    import game.net.data.c.CChatSend;
    import game.net.data.s.SChat;
    import game.view.userLog.Input;
    import game.view.viewBase.JTUIMaxChatBase;
    
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    /**
     * 聊天界面最大化
     * @author CabbageWrom
     *
     */
    public class JTChatMaxComponent extends JTUIMaxChatBase {
        private var txt_input:TextInput = null;
        private var chatPanel:Sprite = null;
        public static var indexChannel:int = 0;
        private var indexInput:int = 0; //1世界，1喇叭
        private var ROW_MAX_NUM:int = 45;
        private var MAX_INPUT_NUM:int = 90;
        private var chatMessages:JTMessageList = null;

        public function JTChatMaxComponent() {
            super();
        }

        /**初始化*/
        override protected function init():void {
            bgImage0.alpha = 0.5
            bgImage1.alpha = 0.2;
            bgImage.touchable = false;
            enter_Scale9Button.text = Langue.getLangue("game_Send"); //发送
            clickBackroundClose();
            _closeButton = btn_close;
            initChatPanel();
            initSendInput();
        }

        /**初始化监听*/
        override protected function addListenerHandler():void {
            super.addListenerHandler();
            JTFunctionManager.registerFunction(JTGlobalDef.REFRESH_CHAT_PANEL, onRefreshChatPanel);
            JTSingleManager.instance.messageInfoManager.testExecuteLogic();
            this.enter_Scale9Button.addEventListener(Event.TRIGGERED, onSendChatHandler);
            this.txt_input.addEventListener(FeathersEventType.FOCUS_IN, onMouseFocusIn);
            this.txt_input.addEventListener(FeathersEventType.FOCUS_OUT, onMouseFocusOut);
            this.addContextListener(EventType.SELECTTAB, onSelectTab);
        }

        /**选中标签页*/
        private function onSelectTab(evt:Event = null, index:int = 0):void {
            onChangeChatMessages(index);
        }

        /**列出按钮*/
        override protected function listTabButton():Array {
            var arr:Array = Langue.getLans("chatNumbers");
            tab_1.text = arr[0];
            tab_2.text = arr[1];
            tab_3.text = Langue.getLangue("system");
            return [tab_1, tab_2, tab_3];
        }

        /**列出引用的类名*/
        override protected function listTabReference():Array {
            return [];
        }

        /**大开窗口*/
        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            if (parameter && parameter is int) {
                defaultSelect = parameter as int;
            }
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        private function initChatPanel():void {
            chatMessages = new JTMessageList();
            chatMessages.dataProvider = new ListCollection();
            this.addChild(chatMessages);
            showChatMessages(JTMessageInfoManager.getMessages());
        }

        private function onUpdateItemInfo(display:DisplayObject, itemInfo:Object):void {
            var textField:TextField = display as TextField;
            textField.text = itemInfo.toString();
        }

        private function initSendInput():void {
            this.indexInput = JTMessageInfoManager.MSG_WORLD;
            indexChannel = JTMessageInfoManager.MSG_ALL;
            txt_input = new TextInput();
            txt_input.x = 155;
            txt_input.y = 15;
            txt_input.width = 674;
            txt_input.height = 40;
            txt_input.maxChars = ROW_MAX_NUM;
			txt_input.textEditorProperties.fontFamily = "";
            var inputConfig:Input = new Input();
            inputConfig.isPassword = false;
            inputConfig.passMatch = false;
            inputConfig.size = 30;
            inputConfig.defaultText = Langue.getLangue("pleaseInput"); //请输入...
            inputConfig.input = txt_input;
            inputConfig.showDefaultText = true;
            inputConfig.StartFactory(ReturnKeyLabel.GO, onSendChatHandler);
            this.addChild(txt_input);
            this.setChildIndex(this.enter_Scale9Button, this.numChildren - 1);
        }

        private function onMouseFocusIn():void {
            if (txt_input.text == Langue.getLangue("pleaseInput")) { //请输入
                txt_input.text = "";
            }
        }

        private function onMouseFocusOut():void {
            if (txt_input.text == "") {
                txt_input.text = Langue.getLangue("pleaseInput");
            }
        }

        /**刷新聊天版面*/
        private function onRefreshChatPanel(result:Object):void {
            var chatInfo:SChat = result as SChat;
            if (indexChannel != JTMessageInfoManager.MSG_ALL) {
                if (indexChannel != chatInfo.type) {
                    return;
                }
            }

            switch (chatInfo.type) {
                case JTMessageInfoManager.MSG_HORN:  {
                    showHornMessage(chatInfo);
                    break;
                }
                case JTMessageInfoManager.MSG_SOCIETY:  {
                    break;
                }
                case JTMessageInfoManager.MSG_SYSTEMNOTICE:  {
                    showSystemMessage(chatInfo);
                    break;
                }
                case JTMessageInfoManager.MSG_WORLD:  {
                    showWorldMessage(chatInfo);
                    break;
                }
                default:  {
                    JTLogger.error("[JTChatMaxComponent.onRefreshChatPanel]Can't Find The Msg Type!");
                    break;
                }
            }
        }

        /**显示系统消息*/
        private function showSystemMessage(chatInfo:SChat):void {
            var content:String = Langue.getLangue("chat_system") + " : " + chatInfo.content; //系统
            var lines:Array = JTGlobalFunction.parseText(content, 730);
            var i:int = 0;
            var l:int = lines.length;
            for (i = 0; i < l; i++) {
                var line:String = lines.shift();

                if (chatInfo.id != 0) {
                    var index:int = line.indexOf(chatInfo.name);
                    var list:Array = line.split(chatInfo.name);

                    if (index != -1) {
                        onRefreshChatMessage(JTGlobalFunction.toHTMLStyle("#FFCC00", list[0]) + JTGlobalFunction.toHTMLStyle("#33FCFC",
                                                                                                                             chatInfo.name) + JTGlobalFunction.toHTMLStyle("#FF9900",
                                                                                                                                                                           list[1]));
                    } else {
                        onRefreshChatMessage(JTGlobalFunction.toHTMLStyle("#FFCC00", line));
                    }
                    continue;
                }

                if (i == 0) {
                    onRefreshChatMessage(JTGlobalFunction.toHTMLStyle("#FFCC00", line));
                    continue;
                }
                onRefreshChatMessage(JTGlobalFunction.toHTMLStyle("#FFCC00", line));
            }
        }

        /**显示世界消息*/
        private function showWorldMessage(chatInfo:SChat):void {
            var name:String = Langue.getLangue("chat_world") + chatInfo.name + " : " ; //世界
            var content:String = name + chatInfo.content;

            var lines:Array = JTGlobalFunction.parseText(content, 730);
            var l:int = lines.length;

            for (var i:int = 0; i < l; i++) {
                var line:String = lines.shift();
                var index:int = line.indexOf(name);

                if (index != -1) {
                    var list:Array = line.split(name);
                    onRefreshChatMessage(JTGlobalFunction.toHTMLStyle("#33FCFC", name) + JTGlobalFunction.toHTMLStyle("#FFFFCCI",
                                                                                                                      list[1]));
                } else {
                    onRefreshChatMessage(JTGlobalFunction.toHTMLStyle("#FFFFCCI", line));
                }
            }
        }

        /**显示喇叭消息*/
        private function showHornMessage(chatInfo:SChat):void {
            var name:String = Langue.getLangue("chat_notice") + chatInfo.name + " : " ; //喇叭
            var content:String = name + chatInfo.content;

            var lines:Array = JTGlobalFunction.parseText(content, 730);
            var i:int = 0;
            var l:int = lines.length;

            for (i = 0; i < l; i++) {
                var line:String = lines.shift();
                var index:int = line.indexOf(name);

                if (index != -1) {
                    var list:Array = line.split(name);
                    onRefreshChatMessage(JTGlobalFunction.toHTMLStyle("#33FCFC", name) + JTGlobalFunction.toHTMLStyle("#ff9900",
                                                                                                                      list[1]));
                } else {
                    onRefreshChatMessage(JTGlobalFunction.toHTMLStyle("#ff9900", line));
                }
            }
        }

        /**到一定时间刷新聊天消息*/
        private function onRefreshChatMessage(str:String):void {
            var msg:String = str + ":CabbageWrom:" + getTimer();
            chatMessages.restItemRender(msg + Math.random() * 100000 + 1);
        }

        /**更新聊天消息*/
        private function onUpdateChatPanel(messageList:Vector.<String>):void {
            var i:int = 0;
            var numChildren:int = chatPanel.numChildren;
            var l:int = messageList.length;

            for (i = 0; i < numChildren; i++) {
                var txt_item:TextField = chatPanel.getChildByName("txt" + i) as TextField;

                if (i > l - 1) {
                    txt_item.text = "";
                    continue;
                }
                txt_item.text = messageList[i];
            }
        }

        private function bytesToString(bytes:ByteArray):Vector.<String> {
            var lines:Vector.<String> = new Vector.<String>();
            bytes.position = 0;
            var msg:String = bytes.readUTF();
            var rows:int = Math.ceil(msg.length / ROW_MAX_NUM);
            var i:int = 0;
            var l:int = msg.length;
            var length:int = 0;
            var line:String = null;

            for (i = 0; i < l; i++) {
                var str:String = msg.charAt(i)

                if (length < 40) {
                    if (StringUtil.isDoubleChar(str)) {
                        length += 2;
                    } else {
                        length += 1;
                    }
                    line += str;
                } else {
                    lines.push(line);
                    line = null;
                    length = 0;
                }
            }
            return lines;
        }

        /**发送聊天*/
        private function onSendChatHandler(e:Event = null):void {
            var message:String = StringUtil.trim(txt_input.text);
            if (message == "" || message.length == 0 || message == Langue.getLangue("chatBeyondMax") || message == Langue.getLangue("pleaseInput")) {
                RollTips.add(Langue.getLangue("cannotBeEmpty")); //聊天内容不能为空
            } else {
                if (JTGlobalFunction.toStringBytes(message).bytesAvailable > MAX_INPUT_NUM) {
                    RollTips.add(Langue.getLangue("chatBeyondMax")); //只能输入30个字
                    txt_input.text = "";
                    return;
                }

                if (this.indexInput == JTMessageInfoManager.MSG_HORN) {
                    if (GameMgr.instance.horn <= 0) {
                        DialogMgr.instance.open(JTFastBuyComponent, JTFastBuyComponent.FAST_BUY_HORN);
                    } else {
                        var sendHornPackage:CChatSend = new CChatSend();
                        sendHornPackage.content = message;
                        sendHornPackage.type = JTMessageInfoManager.MSG_HORN;
                        GameSocket.instance.sendData(sendHornPackage);
                        txt_input.text = "";
                    }
                    return;
                }
                var chatController:JTChatControllerComponent = JTChatControllerComponent.instance;

                if (!chatController) {
                    JTLogger.error("[JTChatMaxComponent.onSendChatHandler]ChatController is Empty!");
                }
                var running:Boolean = chatController.timerRunning();

                if (!running) {
                    var sendMsgPackage:CChatSend = new CChatSend();
                    sendMsgPackage.content = message;
                    sendMsgPackage.type = this.indexInput;
                    GameSocket.instance.sendData(sendMsgPackage);
                    txt_input.text = "";
                }
                setChatRestrictTime();
            }
        }

        /**设置发送时间*/
        private function setChatRestrictTime():void {
            var chatController:JTChatControllerComponent = JTChatControllerComponent.instance;

            if (!chatController) {
                JTLogger.error("[JTChatMaxComponent.onSendChatHandler]ChatController is Empty!");
            }
            var interval:int = chatController.getInterval();
            var running:Boolean = chatController.timerRunning();

            if (running) {
                RollTips.add(interval.toString() + Langue.getLangue("sendMsgTime"));
                return;
            } else {
                chatController.resetTimer();
            }
        }

        /**改变聊天频道*/
        private function onChangeChatMessages(index:int):void {
//            var target:DisplayObject = e.target as DisplayObject;
//            var targetName:String = target.name;
            switch (index) {
                case 0:  {
                    indexInput = JTMessageInfoManager.MSG_WORLD;
                    indexChannel = JTMessageInfoManager.MSG_ALL;
                    showChatMessages(JTMessageInfoManager.getMessages());
					text_horn.visible = false;
                    break;
                }
                case 1:  {
                    indexInput = JTMessageInfoManager.MSG_HORN;
                    indexChannel = JTMessageInfoManager.MSG_HORN;
					text_horn.visible = true;
					onRefreshHornNum();
                    JTFunctionManager.registerFunction(JTGlobalDef.REFRESH_HORN_NUM, onRefreshHornNum);
                    showChatMessages(JTMessageInfoManager.getTypeMessages(JTMessageInfoManager.MSG_HORN));
                    break;
                }
                case 2:  {
                    indexInput = JTMessageInfoManager.MSG_WORLD;
                    indexChannel = JTMessageInfoManager.MSG_SYSTEMNOTICE;
                    showChatMessages(JTMessageInfoManager.getTypeMessages(JTMessageInfoManager.MSG_SYSTEMNOTICE));
					text_horn.visible = false;
                    break;
                }
                default:
                    break;
            }
        }

        /**
         *喇叭数量更新
         */
        private function onRefreshHornNum():void {
			text_horn.text = Langue.getLans("chatNumbers")[1] + " "  + GameMgr.instance.horn.toString();
        }

        private function showChatMessages(msgs:Vector.<SChat>):void {
            clearMessages();
            var i:int = 0;
            var l:int = msgs.length;

            for (i = 0; i < l; i++) {
                onRefreshChatPanel(msgs.shift());
            }
        }

        private function clearMessages():void {
            chatMessages.restItemRender(null);
        }

        override public function dispose():void {
            this.enter_Scale9Button.removeEventListener(Event.TRIGGERED, onSendChatHandler);
            this.txt_input.removeEventListener(FeathersEventType.FOCUS_IN, onMouseFocusIn);
            this.txt_input.removeEventListener(FeathersEventType.FOCUS_OUT, onMouseFocusOut);
            JTFunctionManager.executeFunction(JTGlobalDef.PLAY_CITY_ANIMATABLE);
            JTFunctionManager.executeFunction(JTGlobalDef.MAX_SWITCHOVER_MIN);
            JTFunctionManager.removeFunction(JTGlobalDef.REFRESH_CHAT_PANEL, onRefreshChatPanel);
            if (chatMessages) {
                chatMessages.dispose();
                chatMessages = null;
            }
            super.dispose();
        }
    }
}
