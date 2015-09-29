/**
 * Created by Administrator on 2014/10/7 0007.
 */
package game.view.widget {
    import com.dialog.DialogMgr;
    import com.langue.Langue;

    import game.data.HeroData;
    import game.data.Val;
    import game.data.WidgetData;
    import game.manager.AssetMgr;
    import game.net.message.EquipMessage;
    import game.view.blacksmith.BlacksmithDialog;
    import game.view.dispark.DisparkControl;
    import game.view.dispark.data.ConfigDisparkStep;
    import game.view.goodsGuide.GetBestEquipDlg;
    import game.view.uitils.Res;
    import game.view.viewBase.EquipDlgBase;

    import starling.display.DisplayObjectContainer;
    import starling.events.Event;
    import starling.text.TextField;

    public class EquipDlg extends EquipDlgBase {
        private var _widgetData:WidgetData;
        private var _heroData:HeroData;
        private var _equipBallBar:EquipBallBarRendler;

        public function EquipDlg() {
            super();
        }

        override protected function init():void {
            enableTween = true;
            clickBackroundClose();
            bgImage0.alpha = bgImage1.alpha = bgImage2.alpha = bgImage3.alpha = 0.5;
            _equipBallBar = new EquipBallBarRendler();
            _equipBallBar.x = 56;
            _equipBallBar.y = 115;
            addQuiackChild(_equipBallBar);

            var tmpArray:Array = Val.MAGICBALL;
            var len:int = tmpArray.length;
            var goods_title:TextField;
            var langue:Array = Langue.getLans("ENCHANTING_TYPE");
            for (var i:int = 0; i < len; i++) {
                var nameStr:String = tmpArray[i];
                if (i >= 2) {
                    goods_title = this[nameStr + "Name"] as TextField;
                    goods_title.text = langue[i];
                }
            }
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            addViewListener(replace_Scale9Button, Event.TRIGGERED, clickHandler);
            addViewListener(strengthen_Scale9Button, Event.TRIGGERED, clickHandler);
            addViewListener(embed_Scale9Button, Event.TRIGGERED, clickHandler);
            addViewListener(fall_Scale9Button, Event.TRIGGERED, clickHandler);
        }

        private function clickHandler(e:Event):void {
            switch (e.currentTarget) {
                case replace_Scale9Button:
                    EquipMessage.sendReplaceEquip(_widgetData.seat, _heroData, 0);
                    this.close();
                    break;
                case strengthen_Scale9Button:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep1))
                        return;
                    DialogMgr.instance.open(BlacksmithDialog, {tab: 0, data: _widgetData});
                    break;
                case embed_Scale9Button:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep17))
                        return;
                    DialogMgr.instance.open(BlacksmithDialog, {tab: 1, data: _widgetData});
                    break;
                case fall_Scale9Button:
                    var data:Object = {data: Langue.getLangue("get_goods"), level: _heroData.level, type: _widgetData.sort};
                    DialogMgr.instance.open(GetBestEquipDlg, data);
                    break;
            }
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            _widgetData = parameter.wid;
            _heroData = parameter.hero;

            replace_Scale9Button.text = Langue.getLangue("noreplceNull");
            strengthen_Scale9Button.text = Langue.getLans("blacksmith")[0];
            embed_Scale9Button.text = Langue.getLans("blacksmith")[1];
            fall_Scale9Button.text = Langue.getLangue("get");

            nameTxt.text = _widgetData.name;
            icon.texture = AssetMgr.instance.getTexture(_widgetData.picture);
            if (_widgetData.type < 100) {
                quality.texture = Res.instance.getQualityToolTexture(0);
            } else {
                quality.texture = Res.instance.getQualityToolTexture(_widgetData.quality);
            }

            var goods_title:TextField;
            var tmpArray:Array = Val.MAGICBALL;
            var len:int = tmpArray.length;
            var langue:Array = Langue.getLans("ENCHANTING_TYPE");
            for (var i:int = 0; i < len; i++) {
                var nameStr:String = tmpArray[i];
                if (i >= 2) {
                    goods_title = this[nameStr + "Name"] as TextField;
                    goods_title.text = langue[i];
                }
                var vTxt:TextField = this[nameStr];
                vTxt.text = _widgetData[nameStr];
                var addTxt:TextField = this["add" + nameStr];
                addTxt.text = "";

                var addValueTxt:TextField = this["add" + nameStr + "Value"];
                addValueTxt.text = "";
            }
            _equipBallBar.updata(_widgetData);
        }

        override public function close():void {
            super.close();
        }
    }
}
