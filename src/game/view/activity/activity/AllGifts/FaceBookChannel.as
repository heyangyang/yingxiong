package game.view.activity.activity.AllGifts {
    import com.components.RollTips;
    import com.langue.Langue;
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import game.data.ActivityNum;
    import game.data.ConfigData;
    import game.data.FestPrizeData;
    import game.dialog.ShowLoader;
    import game.net.GameSocket;
    import game.net.data.c.CWeixinShare;
    import game.net.data.c.CWeixinSharePrize;
    import game.net.data.s.SWeixinShare;
    import game.net.data.s.SWeixinSharePrize;
    import game.net.data.vo.FestValues;
    import game.view.activity.base.AllGiftsBase.FaceBookBase;
    import game.view.uitils.Res;

    import starling.events.Event;

    /**
     *
     * @author faceBook分享
     *
     */
    public class FaceBookChannel extends FaceBookBase implements IGifts {

        private var box:Box;
        private var anum:ActivityNum;
        private var festValues:FestValues;

        public function FaceBookChannel() {
            super();
            receiveButton.text = Langue.getLangue("dianZanReceiveButton");
            receiveButton.addEventListener(Event.TRIGGERED, onReceive);
            receiveButton.fontSize = 30;
            receiveButton.fontColor = 0xffffcc;
        }

        override protected function addListenerHandler():void {
            this.addContextListener(SWeixinShare.CMD.toString(), onSWeixinShare);
            this.addContextListener(SWeixinSharePrize.CMD.toString(), onWeixinSharePrize);
        }

        public function set data(value:ActivityNum):void {
            var i:int = 0;
            var len:int = value.ids.length;
            var values:FestValues;
            var data:FestPrizeData;
            anum = value;
            for (i; i < len; i++) {
                values = (value.ids[i] as FestValues)

                if (value.id == values.id) {
                    data = FestPrizeData.hash.getValue(value.id + "" + values.num);
                    contentTxt.text = value.caption;
                    festValues = values;
                    showGoods(data);
                    if (festValues.state == 0) {
                        receiveButton.text = Langue.getLangue("dianZanReceiveButton");
                    } else if (festValues.state == 1) {
                        receiveButton.text = Langue.getLangue("signRewardReceiveButton");
                    } else if (festValues.state == 2) {
                        receiveButton.text = Langue.getLangue("signRewardReceived");
                    }
                    break;
                }
            }
        }

        private function showGoods(fest:FestPrizeData):void {
            box = new Box(Res.instance.getQualityToolTexture(0));
            box.data = fest;
            receiveButton.addEventListener(Event.TRIGGERED, onReceive);
            addChild(box);
            box.stuat = festValues.state;
        }

        private function onSWeixinShare(e:Event, info:SWeixinShare):void {
            if (info.id == festValues.id) {
                if (info.code == 0) {
                    festValues.state = 1;
                    receiveButton.text = Langue.getLangue("signRewardReceiveButton");
                } else if (info.code == 1) {
                    RollTips.add(Langue.getLangue("useReceive")); //已经领取
                } else if (info.code >= 127) {
                    RollTips.add(Langue.getLangue("codeError")); //程序错误
                }
                ShowLoader.remove();
            }
        }

        private function onWeixinSharePrize(e:Event, info:SWeixinSharePrize):void {
            if (info.id == festValues.id) {
                if (info.code == 0) {
                    festValues.state = 2;
                    receiveButton.text = Langue.getLangue("signRewardReceived");
                } else if (info.code == 1) {
                    RollTips.add(Langue.getLangue("useReceive")); //已经领取
                } else if (info.code >= 127) {
                    RollTips.add(Langue.getLangue("codeError")); //程序错误
                }
                ShowLoader.remove();
            }
        }

        private function onReceive(e:Event):void {
            if (festValues.state == 0) //点赞
            {
                ViewDispatcher.dispatch(EventType.GOTO_WEB, ConfigData.instance.facebook_url.replace('"', '').replace('"',
                                                                                                                      ''));
                var cmd1:CWeixinShare = new CWeixinShare();
                cmd1.id = festValues.id;
                GameSocket.instance.sendData(cmd1);
                ShowLoader.add();

            } else if (festValues.state == 1) //领取
            {
                var cmd:CWeixinSharePrize = new CWeixinSharePrize();
                cmd.id = festValues.id;
                GameSocket.instance.sendData(cmd);
                ShowLoader.add();
            } else if (festValues.state == 2) {
                RollTips.add(Langue.getLangue("useReceive")); //已经领取
            }

        }

    }
}


