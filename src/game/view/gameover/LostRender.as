package game.view.gameover {
    import com.dialog.Dialog;
    import com.dialog.DialogMgr;
    import com.langue.Langue;

    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.manager.HeroDataMgr;
    import game.net.message.GameMessage;
    import game.utils.LocalShareManager;
    import game.view.blacksmith.BlacksmithDialog;
    import game.view.dispark.DisparkControl;
    import game.view.dispark.data.ConfigDisparkStep;
    import game.view.heroHall.HeroDialog;
    import game.view.heroHall.render.StarBarRender;
    import game.view.magicShop.MagicOrbDia;
    import game.view.tavern.TavernDialog;
    import game.view.viewBase.LostRenderBase;

    import starling.events.Event;

    public class LostRender extends LostRenderBase {
        public function LostRender() {
            super();
            bgImage.alpha = 0.5;
            ok_Scale9Button.text = Langue.getLangue("now_goto_btn"); //立即前往
            ok_Scale9Button.addEventListener(Event.TRIGGERED, onClick);
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (data == null) {
                return;
            }
            switch (data.type) {
                case 0:
                case 3:
                    icon.texture = AssetMgr.instance.getTexture("photo_525");
                    var star:StarBarRender = new StarBarRender();
                    addChild(star);
                    star.updataStar(5, 0.9);
                    star.x = quality.x + ((quality.width - star.width) >> 1);
                    star.y = quality.y + quality.height - star.height - 6;
                    txt_level.text = "";
                    break;
                case 1:
                case 2:
                    icon.texture = AssetMgr.instance.getTexture("icon_201002");
                    txt_level.text = "+15"
                    break;
                case 4:
                case 5:
                    icon.texture = AssetMgr.instance.getTexture("icon_201002");
                    txt_level.text = "+15"
                    break;
                default:
                    icon.texture = AssetMgr.instance.getTexture("ui_button_look_iocn");
                    txt_level.text = "";
                    break;
            }
            icon.readjustSize();
            txt_des.text = Langue.getLans("GUIDE_TYPE")[data.type];
        }

        private function onClick():void {
            var dlg:Dialog;
            //0英雄数量|1装备等级|2强化等级|3英雄品质|4宝珠品质|5宝珠等级
            switch (data.type) {
                case 0:
                    if (HeroDataMgr.instance.getFreeBattleHero().length == 0) {
                        if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep3)) {
                            return;
                        }
                        dlg = DialogMgr.instance.open(TavernDialog) as Dialog;
                    } else {
                        GameMessage.gotoTollgateData(GameMgr.instance.tollgateData.id);
                        return;
                    }
                    break;
                case 1:
                    dlg = DialogMgr.instance.open(HeroDialog, HeroDialog.HERO) as Dialog;
                    break;
                case 2:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep1)) {
                        return;
                    }
                    dlg = DialogMgr.instance.open(BlacksmithDialog, 0) as Dialog;
                    break;
                case 3:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep12)) {
                        return;
                    }
                    dlg = DialogMgr.instance.open(HeroDialog, HeroDialog.JINHUA) as Dialog;
                    break;
                case 4:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep20)) {
                        return;
                    }
                    dlg = DialogMgr.instance.open(MagicOrbDia, MagicOrbDia.FOUSE) as Dialog;
                    break;
                case 5:
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep18)) {
                        return;
                    }
                    dlg = DialogMgr.instance.open(MagicOrbDia, MagicOrbDia.TUSHI) as Dialog;
                    break;
                case 6:
                    LocalShareManager.getInstance().save(LocalShareManager.BEAST_BATTLE, 1);
                    GameMessage.gotoTollgateData(GameMgr.instance.tollgateData.id);
                    break;
                default:
                    break;
            }

            dlg && dlg.addEventListener(Dialog.CLOSE_CONTAINER, onClose);
            function onClose():void {
                dlg.removeEventListener(Dialog.CLOSE_CONTAINER, onClose)
            }
        }

    }
}

