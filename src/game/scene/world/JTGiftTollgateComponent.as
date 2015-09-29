package game.scene.world {
    import com.dialog.DialogMgr;
    import com.langue.Langue;

    import game.common.JTGlobalDef;
    import game.data.IconData;
    import game.data.JTTollgateGIftData;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.managers.JTFunctionManager;
    import game.managers.JTSingleManager;
    import game.managers.JTTollgateInfoManager;
    import game.net.GameSocket;
    import game.net.data.c.CGet_tollgatePrize;
    import game.net.data.s.SGet_tollgatePrize;
    import game.view.comm.GetGoodsAwardEffectDia;
    import game.view.uitils.Res;
    import game.view.viewBase.JTUIGitTollgateBase;

    import spriter.SpriterClip;

    import starling.display.Image;
    import starling.events.Event;
    import starling.text.TextField;

    /**
     *关卡奖励
     * @author lfr
     */
    public class JTGiftTollgateComponent extends JTUIGitTollgateBase {
        /**
         *幸运星
         */
        private const TYPE_STAR:int = 3;
        /**
         *疲劳值
         */
        private const TYPE_TRIED:int = 7;
        /**
         *钻石
         */
        private const TYPE_DIAMOND:int = 2;
        /**
         *金币
         */
        private const TYPE_COIN:int = 1;
        /**
         *喇叭
         */
        private const TYPE_HORN:int = 8;
        private var dataVector:Vector.<IconData> = null;

        public function JTGiftTollgateComponent() {
            super();
        }

        override protected function init():void {
            enableTween = true;
            initialize();
            setToCenter();
            clickBackroundClose();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            this.getGift_Scale9Button.addEventListener(Event.TRIGGERED, onGetGiftHandler);
            JTFunctionManager.registerFunction(JTGlobalDef.GET_TOLLGATE_GIFT, getTollgateGiftResponse);
        }

        public function onGetGiftHandler(e:Event):void {
            var tollgateInfoManager:JTTollgateInfoManager = JTSingleManager.instance.tollgateInfoManager;
            var curTollgateData:JTTollgateGIftData = JTTollgateGIftData.getTollgateGift(tollgateInfoManager.current_TollgateID);
            if (!curTollgateData) {
                return;
            }

            if (GameMgr.instance.tollgateID > curTollgateData.id2) {
                var getGiftPackage:CGet_tollgatePrize = new CGet_tollgatePrize();
                GameSocket.instance.sendData(getGiftPackage);
            }
        }

        private function initialize():void {
            txt_cu_progress.text = Langue.getLangue("tollgatePrompt"); //关卡进度
            var tollgateInfoManager:JTTollgateInfoManager = JTSingleManager.instance.tollgateInfoManager;
            var curTollgateData:JTTollgateGIftData = JTTollgateGIftData.getTollgateGift(tollgateInfoManager.current_TollgateID);
            this.txt_0.text = txt_1.text = txt_2.text = "x 0";

            if (tollgateInfoManager.isGetGift) {
                getGift_Scale9Button.disable = false;
                getGift_Scale9Button.text = Langue.getLangue("okUse"); //可领取
            } else {
                getGift_Scale9Button.disable = true;
                getGift_Scale9Button.text = Langue.getLangue("notUse"); //不可领取
            }
            this.getGift_Scale9Button.touchable = tollgateInfoManager.isGetGift;

            if (!curTollgateData) {
                return;
            }
            this.txt_tolltage_num.text = GameMgr.instance.tollgateID - 1 + "/" + curTollgateData.id2;
            setArgs(curTollgateData.prize);
        }

        private function setArgs(list:Array):void {
            var i:int = 0;
            var l:int = list.length;
            var iconData:IconData = null;
            var icon:Image;
            var text:TextField;
            dataVector = new Vector.<IconData>;
            for (i = 0; i < l; i++) {
                var dataInfo:Object = list[i] as Object;
                var type:int = dataInfo[0];
                var count:int = dataInfo[1];

                if (i < 3) {
                    icon = this["icon_" + i] as Image;
                    text = this["txt_" + i] as TextField;
                }
                icon.texture = Res.instance.getCommTexture(type);
                text.text = "x " + count;

                switch (type) {
                    case TYPE_DIAMOND:  {
                        iconData = new IconData();
                        iconData.IconId = TYPE_DIAMOND;
                        iconData.QualityTrue = Res.instance.getQualityToolTextures(0);
                        iconData.IconTrue = Res.instance.getCommTextures(11);
                        iconData.Num = "x " + count;
                        iconData.IconType = 2;
                        iconData.Name = Langue.getLangue("buyDiamond"); //"钻石"
                        dataVector.push(iconData);
                        break;
                    }

                    case TYPE_STAR:  {
                        iconData = new IconData();
                        iconData.IconId = TYPE_STAR;
                        iconData.QualityTrue = Res.instance.getQualityToolTextures(0);
                        iconData.IconTrue = Res.instance.getCommTextures(12);
                        iconData.Num = "x " + count;
                        iconData.IconType = 3;
                        iconData.Name = Langue.getLangue("buyLucky"); //"幸运星"
                        dataVector.push(iconData);
                        break;
                    }

                    case TYPE_TRIED:  {
                        iconData = new IconData();
                        iconData.IconId = TYPE_TRIED;
                        iconData.QualityTrue = Res.instance.getQualityToolTextures(0);
                        iconData.IconTrue = Res.instance.getCommTextures(13);
                        iconData.Num = "x " + count;
                        iconData.IconType = 0;
                        iconData.Name = Langue.getLangue("buyFatigue"); //"疲劳值"
                        dataVector.push(iconData);
                        break;
                    }

                    case TYPE_COIN:  {
                        iconData = new IconData();
                        iconData.IconId = TYPE_COIN;
                        iconData.QualityTrue = Res.instance.getQualityToolTextures(0);
                        iconData.IconTrue = Res.instance.getCommTextures(10);
                        iconData.Num = "x " + count;
                        iconData.IconType = 1;
                        iconData.Name = Langue.getLangue("buyMoney"); //"金币"
                        dataVector.push(iconData);
                        break;
                    }

                    case TYPE_HORN:  {
                        iconData = new IconData();
                        iconData.IconId = TYPE_HORN;
                        iconData.QualityTrue = Res.instance.getQualityToolTextures(0);
                        iconData.IconTrue = Res.instance.getCommTextures(8);
                        iconData.Num = "x " + count;
                        iconData.IconType = 8;
                        iconData.Name = Langue.getLans("ChatButtonName")[2]; //"喇叭"
                        dataVector.push(iconData);
                        break;
                    }
                    default:
                        break;
                }
            }
        }

        private function getTollgateGiftResponse(result:Object):void {
            var tollgateInfoManager:JTTollgateInfoManager = JTSingleManager.instance.tollgateInfoManager;
            var tollgateGift:SGet_tollgatePrize = result as SGet_tollgatePrize;
            if (tollgateGift.code == 0) {
                var giftAmintion:SpriterClip = AnimationCreator.instance.create("effect_baoxiangshanguang", AssetMgr.instance,
                                                                                true);
                giftAmintion.play("effect_baoxiangshanguang");
                giftAmintion.animation.looping = false;
                giftAmintion.addCallback(onPlayComplete, 500);
                giftAmintion.name = "giftAminition";
                this.addChild(giftAmintion);
                this.setChildIndex(this.getGift_Scale9Button, this.numChildren - 1);
                giftAmintion.x = this.getGift_Scale9Button.x + getGift_Scale9Button.width / 2;
                giftAmintion.y = this.getGift_Scale9Button.y + getGift_Scale9Button.height / 2;
            }
            DialogMgr.instance.isVisibleDialogs(true);
            var effectData:Object = {vector: dataVector, effectPoint: null, effectName: "effect_036", effectSound: "baoxiangkaiqihuode",
                    effectFrame: 299};
            DialogMgr.instance.open(GetGoodsAwardEffectDia, effectData, null, null, "translucence", 0x000000, 0.5);
        }

        private function removeAnimation():void {
            var giftAminition:SpriterClip = this.getChildByName("giftAminition") as SpriterClip;
            giftAminition && giftAminition.removeFromParent();
            giftAminition.dispose();
            giftAminition = null;
        }

        private function onPlayComplete():void {
            initialize();
            removeAnimation();
        }

        override public function dispose():void {
            super.dispose();
            JTFunctionManager.removeFunction(JTGlobalDef.GET_TOLLGATE_GIFT, getTollgateGiftResponse);
        }

    }
}
