package game.view.SystemSet {
    import com.components.RollTips;
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.mobileLib.utils.ConverURL;
    import com.scene.SceneMgr;
    import com.sound.SoundManager;
    import com.utils.Constants;
    import com.view.base.event.EventType;

    import flash.desktop.NativeApplication;

    import feathers.core.PopUpManager;

    import game.data.ConfigData;
    import game.data.TollgateData;
    import game.dialog.ResignDlg;
    import game.dialog.ShowLoader;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.managers.JTSingleManager;
    import game.net.GameSocket;
    import game.net.GlobalMessage;
    import game.net.message.ConnectMessage;
    import game.scene.LoginScene;
    import game.utils.Config;
    import game.utils.LocalShareManager;
    import game.view.FeedBack.FeedBackDlg;
    import game.view.achievement.data.AchievementData;
    import game.view.activity.activity.ActivityCodeView;
    import game.view.chat.component.JTChatControllerComponent;
    import game.view.chat.component.JTMessageHornComponent;
    import game.view.chat.component.JTMessageSystemComponent;
    import game.view.city.CityFace;
    import game.view.city.CityIcon;
    import game.view.embattle.EmBattleDlg;
    import game.view.gameover.WinView;
    import game.view.new2Guide.NewGuide2Manager;
    import game.view.replacePhotoList.GamePhotoDlg;
    import game.view.uitils.Res;
    import game.view.viewBase.SystemSetDlgBase;

    import sdk.AccountManager;
    import sdk.DataEyeManger;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.events.Event;

    public class SystemSetDlg extends SystemSetDlgBase {
        private var isTween_effect:Boolean;
        private var isTween_bg:Boolean = false;
        private var isOpen_effect:Boolean = false;
        private var isOpen_bg:Boolean = false;
        private var picture:int;

        public function SystemSetDlg() {
            super();
        }

        override protected function init():void {
            enableTween = true;
            ico_hero.touchable = false;
            clickBackroundClose(); //点击关闭界面
            text_version_number.text = Langue.getLangue("systemSetDlgVersion"); //版本号
            //版本号
            var ns:Namespace = NativeApplication.nativeApplication.applicationDescriptor.namespace();
            text_number.text = NativeApplication.nativeApplication.applicationDescriptor.ns::versionNumber + "." + ConfigData.data_version + "." + ConfigData.main_version;

            txt_association_Name.fontName = "";
            txt_name.fontName = "";
        }

        /**
         * 关闭打开按钮缓动
         * @param child
         * @param isOpen
         *
         */
        private function tweenTab(child:DisplayObject, isOpen:Boolean, onComplete:Function):void {
            Starling.juggler.tween(child, 0, {x: 561, y: 119, onComplete: onComplete});
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            feed_Scale9Button.addEventListener(Event.TRIGGERED, onFeedbackButtonClick);
            out_Scale9Button.addEventListener(Event.TRIGGERED, onLogoutButtonClick);
            btn_offMusic.addEventListener(Event.TRIGGERED, onMusicButtonEvent);
            change_Scale9Button.addEventListener(Event.TRIGGERED, onGameHeroPhotoClick);
            redemption_Scale9Button.addEventListener(Event.TRIGGERED, onRedemptionCode);
            addContextListener(EventType.UP_HEROPHOTO, updateHeroIco);
            addContextListener(EventType.UPDATE_VIP, updateVipStatus);
        }

        override protected function show():void {
            setToCenter();
            isOpen_bg = !SoundManager.instance.getMusicState();
            isOpen_effect = !SoundManager.instance.getEffectState();
            onMusicButtonEvent();
            var gameMgr:GameMgr = GameMgr.instance;
            name_01.text = Langue.getLangue("Nick_Name"); //昵称
            txt_association.text = Langue.getLangue("Association"); //公会
            txt_association_Name.text = "";
            txt_name.text = gameMgr.arenaname;
            txt_des7.text = Langue.getLangue("youCode"); //邀请码
            txt_code.text = gameMgr.code + "";
            change_Scale9Button.text = Langue.getLangue("Replacing_Avatar"); //更换头像
            redemption_Scale9Button.text = Langue.getLangue("Redemption_Code"); //兑换码
            feed_Scale9Button.text = Langue.getLangue("systemSetDlgFeedBack"); //意见反馈
            out_Scale9Button.text = Langue.getLangue("systemSetDlgLogout"); //帐号注销

            updateHeroIco(null, gameMgr.picture);
            updateVipStatus();
        }

        override public function close():void {
            super.close();
        }

        /**
         * vip等级更新
         */
        private function updateVipStatus():void {
            txt_vip.text = GameMgr.instance.vip + "";
        }

        /**
         * 更新玩家头像
         * @param picture
         *
         */
        private function updateHeroIco(evt:Event, picture:int):void {
            head.texture = Res.instance.getRolePhoto(picture); //人物头像
        }

        private function onMusicButtonEvent(evt:Event = null):void {
            if (isTween_effect && isTween_bg) {
                return;
            }
            isTween_effect = true;
            isTween_bg = true;
            isOpen_effect = !isOpen_effect;
            isOpen_bg = !isOpen_bg;
            tweenTab(btn_offMusic, isOpen_effect, onComplete);
            tweenTab(btn_offMusic, isOpen_bg, onComplete);
            if (evt == null && SoundManager.instance.getEffectState() == isOpen_effect && SoundManager.instance.getMusicState() == isOpen_bg) {
                return;
            }
            SoundManager.instance.setEffectState(isOpen_effect);
            SoundManager.instance.setMusicState(isOpen_bg);

            function onComplete():void {
                isTween_bg = false;
                isTween_effect = false;
                if (isOpen_effect || isOpen_bg) {
                    btn_offMusic.upState = AssetMgr.instance.getTexture("ui_shengyin01_anniu");
                } else {
                    btn_offMusic.upState = AssetMgr.instance.getTexture("ui_shengyin02_anniu");
                }
            }
        }

        /**
         * 反馈
         * @param e
         *
         */
        private function onFeedbackButtonClick(e:Event):void {
            DialogMgr.instance.open(FeedBackDlg);
        }

        /**
         * 更换头像
         */
        private function onGameHeroPhotoClick(e:Event):void {
            if (GameMgr.instance.tollgateID <= ConfigData.instance.arenaGuide) {
                RollTips.addNoOpenInfo(ConfigData.instance.arenaGuide);
                return;
            } else {
                DialogMgr.instance.open(GamePhotoDlg);
            }
        }

        /**
         *兑换码
         * @param e
         */
        private function onRedemptionCode(e:Event):void {
            DialogMgr.instance.open(ActivityCodeView);
        }

        /**
         * 注销
         *
         */
        private function onLogoutButtonClick():void {
            var tip:ResignDlg = DialogMgr.instance.open(ResignDlg) as ResignDlg;
            tip.text = getLangue("confirm");
            tip.onResign.addOnce(logout);
        }

        public static function logout():void {
            ShowLoader.remove();
            CityIcon.isInside = true;
            ConnectMessage.isAutoLogin = false;
            TollgateData.reset();
            AccountManager.instance.loginOut();
            DataEyeManger.instance.loginOut();
            AchievementData.isFirstGuide = false;
            CityFace.isNewGuideInit = false;
            CityFace.isViewGuideInit = false;
            EmBattleDlg.seat_index = 0;
            WinView.code = 0;
            WinView.achievementData = null;
            //如果缓存有保存用户文件，则删除该文件   , 清除缓存文件
            LocalShareManager.getInstance().cacheSaveData();
            Constants.userPwdMd5 = null;
            GlobalMessage.getInstance().clear();
            GameSocket.instance.close(true);
            GameMgr.instance.sign_reward = 0;
            GameMgr.instance.tollgateID = 1;
            DialogMgr.instance.closeAllDialog();
            JTChatControllerComponent.close();
            JTMessageHornComponent.close();
            JTMessageSystemComponent.close();
            JTSingleManager.clears();
            PopUpManager.removePopUps();
            NewGuide2Manager.instance && NewGuide2Manager.instance.dispose();

            Config.isNewPass = false; // 注销账户跳过新手引导


            AssetMgr.instance.enqueue(ConverURL.conver("loginUi/"));
            AssetMgr.instance.loadQueue(onComplete);

            function onComplete(tmp_ratio:Number):void {
                if (tmp_ratio == 1.0) {
                    SceneMgr.instance.changeScene(LoginScene);
                }
            }
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
