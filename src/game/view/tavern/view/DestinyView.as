package game.view.tavern.view {
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.sound.SoundManager;

    import game.common.JTLogger;
    import game.data.ConfigData;
    import game.data.Goods;
    import game.data.HeroData;
    import game.dialog.ResignDlg;
    import game.dialog.ShowLoader;
    import game.manager.GameMgr;
    import game.net.data.IData;
    import game.net.data.c.CGetherosoul;
    import game.net.data.c.CHerosoul;
    import game.net.data.s.SGetherosoul;
    import game.net.data.s.SHerosoul;
    import game.net.data.vo.heroSoulList;
    import game.net.message.base.Message;
    import game.view.tavern.TavernDialog;
    import game.view.tavern.data.DestinyCoinFlash;
    import game.view.tavern.data.TavernData;
    import game.view.uitils.Res;
    import game.view.viewBase.DestinyViewBase;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * 命运之轮
     * @author Samuel
     *
     */
    public class DestinyView extends DestinyViewBase {
        /**抽取类型*/
        private var _type:uint = 0;
        /**是否在刷新*/
        private var isRefresh:Boolean = false;
        private const COUNT:int = 8;
        private var getIndex:int = -1;

        public function DestinyView() {
            super();
        }

        override protected function show():void {

            var names:Array = Langue.getLans("jg_desz_moneytype");
            buyBtn0_Scale9Button.text = names[0];
            buyBtn1_Scale9Button.text = names[1];
            buyBtn2_Scale9Button.text = names[2];
            fushTimeTitle.text = names[3];
            buyNum_0.text = (ConfigData.instance.herosoul_cq * TavernData.instance.hasSoul).toString();
            buyNum_1.text = ConfigData.instance.herosoul_cq.toString();
            buyNum_2.text = ConfigData.instance.herosoul_coin_count.toString();
			
			for (var i:int = 0; i < COUNT; i++) {
				var item:Sprite = this.getChildByName("heroIcon_" + i) as Sprite;
				var image:Image = item.getChildByName("light") as Image;
				image.visible = false;
			}
			
			if (TavernData.instance.fushData2.time <= 0 || DestinyCoinFlash.instance.isTimeout()) {
				var cmd:CHerosoul = new CHerosoul();
				cmd.type = 0;
				Message.sendMessage(cmd);
			} else {
				TavernData.instance.fushData2.startTime();
				cdTime();
				updata();
			}
			DestinyCoinFlash.instance.resume(coinFushTime);
        }

        /**初始化监听*/
        override protected function addListenerHandler():void {

            this.addViewListener(fushBtn, Event.TRIGGERED, onClickHandler);
            this.addViewListener(buyBtn0_Scale9Button, Event.TRIGGERED, onClickHandler);
            this.addViewListener(buyBtn1_Scale9Button, Event.TRIGGERED, onClickHandler);
            this.addViewListener(buyBtn2_Scale9Button, Event.TRIGGERED, onClickHandler);
            this.addContextListener(SHerosoul.CMD.toString(), onHeroSoulHandler);
            this.addContextListener(SGetherosoul.CMD.toString(), onGetherosoulHandler);
        }

        private var index:int;

        private function turn(num:int, image:Image = null):void {
            SoundManager.instance.playSound("xingyunxin");
            if (image) {
                image.visible = false;
            }

            var item:Sprite = this["heroIcon_" + (index++ % 8)] as Sprite;
            image = item.getChildByName("light") as Image;
            image.visible = true;
            if (num-- == 0) {
                onCompeleTime(image);
            } else {
                if (num > 5) {
                    Starling.juggler.delayCall(turn, 0.08, num, image);
                } else {
                    Starling.juggler.delayCall(turn, 0.25, num, image);
                }
            }
        }

        /**抽取返回*/
        private function onGetherosoulHandler(event:Event, info:SGetherosoul):void {
            getIndex = -1;
            switch (info.code) {
                case 0: //成功
                    var hs:heroSoulList = null;
                    var vect:Vector.<IData> = TavernData.instance.heroSoulVector;
                    var len:int = vect.length;
                    JTLogger.debug("服务端返回位置" + info.pos, " 服务端返回id" + info.id);
                    if (_type == 1 || _type == 2) {
                        if (_type == 1) {
                            TavernData.instance.leftTimes = info.num;
                            if (TavernData.instance.leftTimes <= 0) {
                                TavernData.instance.leftTimes = 0;
                            }
                            leftTmies.text = TavernData.instance.leftTimes.toString() + '/' + ConfigData.instance.herosoul_cq_times;
                        }
                        con: for (var i:int = 0; i < len; i++) {
                            hs = vect[i] as heroSoulList;
                            if (hs.pos == info.pos) {
                                if (hs.type == 0) {
                                    hs.type = 1; //修改缓存
                                    getIndex = i;
                                    JTLogger.debug("抽到位置" + (i + 1), " 抽到id" + info.id);
                                    break con;
                                }
                            }
                        }

                    } else if (_type == 3) {
                        for each (hs in vect) {
                            hs.type = 1; //修改缓存
                        }
                    }
                    index = 0;
                    if (_type != 3) {
                        turn(8 * 2 + getIndex - index);
                    } else {
                        turn(8);
                    }
                    break;
                case 1: //金币不足
                    enbledTouchable(true);
                    addTips(Langue.getLangue("notEnoughCoin"));
                    break;
                case 2: //钻石不足
                    enbledTouchable(true);
                    addTips(Langue.getLangue("diamendNotEnough"));
                    break;
                case 4: //配置错误 
                    addTips(Langue.getLangue("Configuration_ERR"));
                    break;
                case 5: //其他错误
                    enbledTouchable(true);
                    addTips(Langue.getLangue("diamendNotEnough"));
                    break;
                case 6: //背包不足
                    enbledTouchable(true);
                    addTips(Langue.getLangue("clearPack"));
                    break;
                case 7: //金币抽取次数不足
                    enbledTouchable(true);
                    addTips(Langue.getLangue("NOt_HAS_TIMES"));
                    break;
                case 8: //没有可抽取英雄
                    enbledTouchable(true);
                    addTips("NO_HAS_HERO"); //没有可抽取英雄 请刷新
                    break;
            }
            ShowLoader.remove();
        }

        /**点击操作*/
        private function onClickHandler(e:Event):void {
            isRefresh = true;
            enbledTouchable(false);
            switch (e.currentTarget) {
                case fushBtn:
                    _type = 0;
                    if (GameMgr.instance.diamond < ConfigData.instance.herosoul_refresh) {
                        addTips(Langue.getLangue("diamendNotEnough"));
                        return;
                    }
                    (this.parent as TavernDialog).isVisible = true;
                    var tip:ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
                    tip.text = Langue.getLangue("get_herosoul_tip").replace("*", ConfigData.instance.herosoul_refresh);
                    tip.onResign.addOnce(function():void {
                        var cmd:CHerosoul = new CHerosoul();
                        cmd.type = 1;
                        Message.sendMessage(cmd);
                    });
                    tip.onClose.addOnce(function():void {
                        enbledTouchable(true);
                    });
                    break;
                case buyBtn0_Scale9Button:
                    getHerosoulCmd(1);
                    break;
                case buyBtn1_Scale9Button:
                    getHerosoulCmd(2);
                    break;
                case buyBtn2_Scale9Button:
                    getHerosoulCmd(3);
                    break;
                default:
                    break;
            }
        }

        /**抽取操作cmd*/
        private function getHerosoulCmd(type:uint):void {
            var has:Boolean = false;
            for each (var hs:heroSoulList in TavernData.instance.heroSoulVector) {
                if (hs.type == 0) {
                    has = true;
                    break;
                }
            }
            if (!has) {
                addTips("NO_HAS_HERO"); //没有可抽取英雄 请刷新
                enbledTouchable(true);
                return;
            }
            _type = type;
            if (_type == 1) {
                if (TavernData.instance.leftTimes > 0) {
                    if (GameMgr.instance.coin < ConfigData.instance.herosoul_coin_count) {
                        addTips(Langue.getLangue("notEnoughCoin"));
                        enbledTouchable(true);
                        return;
                    }
                } else if (TavernData.instance.leftTimes <= 0) {

                    addTips(Langue.getLangue("NOt_HAS_TIMES"));
                    enbledTouchable(true);
                    return;
                }
                enbledTouchable(false);
            } else if (_type == 2) {
                if (GameMgr.instance.diamond < ConfigData.instance.herosoul_cq) {
                    addTips(Langue.getLangue("diamendNotEnough"));
                    enbledTouchable(true);
                    return;
                }
            } else if (_type == 3) {

                if (GameMgr.instance.diamond < ConfigData.instance.herosoul_cq * TavernData.instance.hasSoul) {
                    addTips(Langue.getLangue("diamendNotEnough"));
                    enbledTouchable(true);
                    return;
                }
            }
            var cmd:CGetherosoul = new CGetherosoul();
            cmd.type = type;
            Message.sendMessage(cmd);
        }

        /**刷新返回*/
        private function onHeroSoulHandler(event:Event, info:SHerosoul):void {
            switch (info.code) {
                case 0: //成功
                    TavernData.instance.heroSoulVector = info.herosoul.sort(function(a:heroSoulList, b:heroSoulList):int {
                        if (a.pos < b.pos) {
                            return -1;
                        } else if (a.pos > b.pos) {
                            return 1;
                        }
                        return 0;
                    });
                    TavernData.instance.fushData2.time = info.time;
                    TavernData.instance.leftTimes = info.lefttimes;
                    TavernData.instance.fushData2.startTime();
                    TavernData.instance.fushData2.isSend = true;
                    if (isRefresh) {
                        isRefresh = false;
                        onCompeleTime();
                        cdTime();

                    } else {
                        enbledTouchable(true);
                        buyNum_0.text = (ConfigData.instance.herosoul_cq * TavernData.instance.hasSoul).toString();
                        cdTime();
                        updata();
                    }
//                    Starling.juggler.remove(_coinFlashCD);
//                    _coinFlashCD =  Starling.juggler.repeatCall(updateCoinTime, 1,0,coinFushTime,info.coin_time + 10,getTimer());

                    DestinyCoinFlash.instance.play(coinFushTime, info.coin_time);
                    break;
                case 1: //砖石不足
                    addTips(Langue.getLangue("diamendNotEnough"));
                    break;
                case 2: //配置错误
                    addTips(Langue.getLangue("Configuration_ERR"));
                    break;
            }
            ShowLoader.remove();
        }

        private function tweenTo(image:Image):void {
            if (image) {
                Starling.juggler.tween(image, 0.2, {scaleX: 1.25, scaleY: 1.25, x: image.x - (image.width * 0.125), y: image.y - (image.height * 0.125),
                                           onCompleteArgs: [image], onComplete: complete})
            }

            function complete(p:Image):void {
                p.scaleX = p.scaleY = 1;
                p.x = p.y = -10;
                p.visible = false;
            }
        }

        private function onCompeleTime(image:Image = null):void {
            if (_type == 3) {
                var item:Sprite = null;
                var img:Image = null;
                for (var i:int = 0; i < COUNT; i++) {
                    item = this.getChildByName("heroIcon_" + i) as Sprite;
                    img = item.getChildByName("light") as Image;
                    img.visible = true;
                    tweenTo(img);
                }
                Starling.juggler.delayCall(effectComplete, 0.4);
            } else {
                if (getIndex > 0) {
                    tweenTo(image);
                    Starling.juggler.delayCall(effectComplete, 0.4);
                } else {
                    if (isRefresh) {
                        addTips(Langue.getLangue("NOt_Get_SOUL"));
                    }
                    updata();
                    enbledTouchable(true);
                }
            }
        }

        /**刷新吃cd*/
        private function cdTime():void {
            TavernData.instance.fushData2.cdTime(fushTime, null, 1); //免费倒计时
            TavernData.instance.fushData2.onTimeEnd.remove(onTimeEnd);
            TavernData.instance.fushData2.onTimeEnd.addOnce(onTimeEnd);
        }

        private function onTimeEnd():void {
            TavernData.instance.fushData2.onTimeEnd.remove(onTimeEnd);
            fushTime.text = "00:00:00";
            isRefresh = true;
            var cmd:CHerosoul = new CHerosoul();
            cmd.type = 0;
            Message.sendMessage(cmd);
        }

        /**根据选中的佣兵英雄数据更新UI*/
        public function updata():void {
            var vect:Vector.<IData> = TavernData.instance.heroSoulVector;
            var hero:Sprite = null;
            var heroData:heroSoulList = null;
            var img:Image = null;
            var goods:Goods = null;
            var len:int = vect.length;
            for (var i:int = 0; i < len; i++) {
                hero = this["heroIcon_" + i] as Sprite;
                img = hero.getChildByName("img") as Image;
                heroData = vect[i] as heroSoulList;
                goods = Goods.goods.getValue(heroData.id);
                if (heroData.type == 0) {
                    var heroDataPoto:HeroData = (HeroData.hero.getValue(goods.type) as HeroData);
                    img.texture = Res.instance.getHeroIconTexture(heroDataPoto.show);
                    img.visible = true;
                } else {
                    img.visible = false;
                }
                hero.touchable = true;
            }
            buyNum_0.text = (ConfigData.instance.herosoul_cq * TavernData.instance.hasSoul).toString();
            leftTmies.text = TavernData.instance.leftTimes.toString() + '/' + ConfigData.instance.herosoul_cq_times;
        }

        private function completeEffect(img:Image):void {
            img.removeFromParent(true);
        }

        /**转圈特效完毕*/
        private function effectComplete():void {
            enbledTouchable(true);
            updata();
        }

        /**禁用点击*/
        private function enbledTouchable(bool:Boolean):void {
            fushBtn.touchable = bool;
            buyBtn0_Scale9Button.touchable = bool;
            buyBtn1_Scale9Button.touchable = bool;
            buyBtn2_Scale9Button.touchable = bool;
        }

        /**销毁*/
        override public function dispose():void {
            TavernData.instance.fushData2.onTimeEnd.remove(onTimeEnd);
            super.dispose();
            _type = 0;
            isRefresh = false;
            DestinyCoinFlash.instance.stop();
        }
    }
}
