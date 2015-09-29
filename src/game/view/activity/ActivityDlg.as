package game.view.activity {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.mvc.interfaces.INotification;

    import game.data.FirstPay;
    import game.data.Goods;
    import game.data.HeroData;
    import game.dialog.ShowLoader;
    import game.manager.AssetMgr;
    import game.net.GameSocket;
    import game.net.data.c.CFirstPayPrize;
    import game.net.data.c.CFirstPayStart;
    import game.net.data.s.SFirstPayPrize;
    import game.net.data.s.SFirstPayStart;
    import game.view.heroHall.render.HeroCardShow;
    import game.view.uitils.Res;
    import game.view.viewBase.ActivityDlgBase;
    import game.view.vip.VipDlg;

    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;

    /**
     *首冲
     * @author lfr
     */
    public class ActivityDlg extends ActivityDlgBase {
        private static var isReceive:Boolean;
        private var heroCar:HeroCardShow = null;

        public function ActivityDlg() {
            super();
        }

        override protected function init():void {
            isVisible = true;
            _closeButton = btn_close;
            Recharge.text = Langue.getLangue("Recharge");

        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        override protected function show():void {
            send();
            showGoods();
        }

        override public function listNotificationName():Vector.<String> {
            var vect:Vector.<String> = new Vector.<String>;
            vect.push(SFirstPayStart.CMD, SFirstPayPrize.CMD);
            return vect;
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            Recharge.addEventListener(Event.TRIGGERED, onRecharge);
        }

        private function onRecharge(e:Event):void {
            if (!isReceive)
                DialogMgr.instance.open(VipDlg, VipDlg.CHARGE);
            else {
                receiveSend();
            }
        }

        private function receiveSend():void {
            var cmd:CFirstPayPrize = new CFirstPayPrize();
            GameSocket.instance.sendData(cmd);
            ShowLoader.add();
        }

        private function send():void {
            var cmd:CFirstPayStart = new CFirstPayStart();
            GameSocket.instance.sendData(cmd);
            ShowLoader.add();
        }

        private function showGoods():void {
            var icon:Image;
            var texture:Texture;
            var box:Image;
            var text:TextField;
            var numText:TextField;
            var vect:Vector.<*> = FirstPay.hash.values();
            var len:int = vect.length;
            var data:FirstPay;
            for (var i:int = 1; i <= len; i++) {
                data = vect[i - 1] as FirstPay;
                if (i > 1) {
                    box = this["box_" + data.id];
                    text = this["name_" + data.id];
                    numText = this["values_" + data.id];
                    if (data.tid == 1) {
                        texture = Res.instance.getCommTexture(10); //AssetMgr.instance.getTexture("ui_tubiao_jinbi_da");
                        icon = new Image(texture);
                        addQuiackChild(icon);
                        texture = Res.instance.getQualityToolTexture(0);
                        box.texture = texture;
                        text.text = Langue.getLans("props")[2];
                    } else if (data.tid == 2) {
                        texture = Res.instance.getCommTexture(11); //AssetMgr.instance.getTexture("ui_tubiao_zuanshi_da");
                        icon = new Image(texture);
                        addQuiackChild(icon);
                        texture = Res.instance.getQualityToolTexture(0);
                        box.texture = texture;
                        text.text = Langue.getLangue("diamond");
                    } else {
                        var widget:Goods = Goods.goods.getValue(data.tid);
                        texture = AssetMgr.instance.getTexture(widget.picture);
                        icon = new Image(texture);
                        addQuiackChild(icon);
                        texture = Res.instance.getQualityToolTexture(widget.quality);
                        box.texture = texture;
                        text.text = widget.name;
                    }
                    icon.x = box.x;
                    icon.y = box.y;
                    this.swapChildren(box, icon);
                    numText.text = "x " + data.num + "";
                    this.swapChildren(numText, box);
                } else {
                    var heroData:HeroData = HeroData.hero.getValue(data.heroType) as HeroData;
                    if (heroCar == null) {
                        heroCar = new HeroCardShow();
                        addChild(heroCar);
                        heroCar.x = 69;
                        heroCar.y = 236;
                    }
                    heroData.quality = data.quality;
                    heroCar.updata(heroData);
                }
            }
        }

        override public function handleNotification(_arg1:INotification):void {
            if (_arg1.getName() == String(SFirstPayStart.CMD)) {
                var info:SFirstPayStart = _arg1 as SFirstPayStart;
                if (info.code == 0) {
                    isReceive = true;
                    Recharge.text = Langue.getLangue("okUse"); //可以领取
                    Recharge.visible = true;
                } else if (info.code == 1) {
                    isReceive = false;
                    Recharge.text = Langue.getLangue("Recharge"); //充值
                    Recharge.visible = true;
                } else if (info.code == 2) {
                    isReceive = false;
                    Recharge.text = Langue.getLangue("signRewardReceived"); //已领取
                    Recharge.visible = true;
                } else {
                    RollTips.add(Langue.getLangue("codeError") + "," + info.code);
                }
            } else {
                var info1:SFirstPayPrize = _arg1 as SFirstPayPrize;
                if (info1.code == 0) {
                    RollTips.add(Langue.getLangue("signRewardSucceed")); //领取成功
                } else if (info1.code == 1) {
                    RollTips.add(Langue.getLangue("notReceive")); //未达到领取条件
                } else if (info1.code == 2) {
                    RollTips.add(Langue.getLangue("useReceive")); //您已经领取过
                } else if (info1.code == 3) {
                    RollTips.add(Langue.getLangue("packFulls")); //背包已满，物品已通过邮件发送
                } else if (info1.code >= 127) {
                    RollTips.add(Langue.getLangue("codeError") + info1.code);
                }
            }
            ShowLoader.remove();
        }

        override public function dispose():void {
            heroCar && heroCar.removeFromParent(true);
            super.dispose();
        }
    }
}
