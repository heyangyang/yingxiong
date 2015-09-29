package game.view.city {
    import com.dialog.DialogMgr;
    import com.utils.Constants;
    import com.view.base.event.EventType;

    import flash.utils.Dictionary;

    import game.common.JTGlobalDef;
    import game.common.JTSession;
    import game.data.Attain;
    import game.data.ConfigData;
    import game.data.JTTollgateGIftData;
    import game.data.TaskData;
    import game.dialog.CommGoodsView;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.manager.TaskDataMgr;
    import game.managers.JTFunctionManager;
    import game.managers.JTSingleManager;
    import game.managers.JTTollgateInfoManager;
    import game.net.data.c.CGet_tired;
    import game.net.data.vo.AttainInfo;
    import game.net.message.MailMessage;
    import game.scene.world.JTGiftTollgateComponent;
    import game.view.SystemSet.SystemSetDlg;
    import game.view.achievement.AchievementDlg;
    import game.view.achievement.data.AchievementData;
    import game.view.activity.ActivityDlg;
    import game.view.chat.base.JTUIMiniChat;
    import game.view.chat.component.JTChatControllerComponent;
    import game.view.dispark.DisparkControl;
    import game.view.dispark.data.ConfigDisparkStep;
    import game.view.email.EmailDlg;
    import game.view.loginReward.LoginRewardDlg;
    import game.view.luckyStar.LuckyDlg;
    import game.view.notice.NoticeDlg;
    import game.view.pack.PackDlg;
    import game.view.picture.PictureView;
    import game.view.task.TaskDialog;
    import game.view.uitils.Res;
    import game.view.viewBase.CityIconBase;
    import game.view.vip.VipDlg;
    import game.view.vip.VipRewardDlg;

    import spriter.SpriterClip;

    import starling.animation.Transitions;
    import starling.core.Starling;
    import starling.display.Button;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;

    public class CityIcon extends CityIconBase {
        public static var isInside:Boolean = true;
        private var tag_dic:Dictionary = new Dictionary(true);
        private var _moneyBar:Sprite = null; //主城玩家资产条

        public function CityIcon() {
            super();
        }

        override protected function init():void {
            cityAticveBar.x = (Constants.virtualWidth - cityAticveBar.width) >> 1;
            cityAticveBar.y = 75;
            cityMenubar.x = Constants.virtualWidth - cityMenubar.width;
            btn_tcouh.x = Constants.virtualWidth - btn_tcouh.width;
            if (isInside) {
                cityMenubar.y = -cityMenubar.height;
            }
            moneyBar();
            //refreshImage();
        }

        private function moneyBar():void {
            var commGoods:CommGoodsView;
            _moneyBar = new Sprite();
            _moneyBar.name = "moneyBar";
            JTSession.layerGlobal.addChild(_moneyBar);
            for (var i:int = 0; i < 4; i++) {
                commGoods = new CommGoodsView(i == 3 ? 7 : i);
                _moneyBar.addQuiackChild(commGoods);
                commGoods.name = "goodsView_" + i;
                commGoods.x = i * 188;
            }
            _moneyBar.x = (Constants.virtualWidth - _moneyBar.width) >> 1;
            _moneyBar.y = 5;
        }

        /**显示*/
        override protected function show():void {
            //请求疲劳
            sendMessage(CGet_tired);

            updateHeroIco(null, GameMgr.instance.picture);
            updateSignStatus();
            updateFbStatus();
            updateVipStatus();
            updateNoticeStatus(null, GameMgr.instance.hasNotice);
            onUpdateMailState(null, MailMessage.isNotice);
            updateAchievementStatus(null, AchievementData.instance.isReceive);
            updateDailyStatus();
            updateTaskIco(null);
            updateGiftTollgate(null, JTSingleManager.instance.tollgateInfoManager.isGetGift);
            updateVipRawad()
            updateDays(null)
            JTChatControllerComponent.isShowCityIcon = true;

        }

        override protected function addListenerHandler():void {
            addViewListener(ico_hero, Event.TRIGGERED, tcouhTriggred); // 头像点击
            addViewListener(btn_vip, Event.TRIGGERED, tcouhTriggred); //vip
            addViewListener(btn_strategy, Event.TRIGGERED, tcouhTriggred); //每日任务

            addViewListener(cityAticveBar.btn_fristpay, Event.TRIGGERED, tcouhTriggred); //首充
            addViewListener(cityAticveBar.btn_pay, Event.TRIGGERED, tcouhTriggred); //充值
            addViewListener(cityAticveBar.btn_qindao, Event.TRIGGERED, tcouhTriggred); //签到
            addViewListener(cityAticveBar.btn_vipReward, Event.TRIGGERED, tcouhTriggred); //Vip奖励
            addViewListener(cityAticveBar.btn_notice, Event.TRIGGERED, tcouhTriggred); //公告	
            addViewListener(cityAticveBar.btn_giftButton, Event.TRIGGERED, tcouhTriggred); //关卡宝箱

            addViewListener(cityMenubar.btn_xingyun, Event.TRIGGERED, tcouhTriggred); //背包
            addViewListener(cityMenubar.btn_mail, Event.TRIGGERED, tcouhTriggred); //邮件
            addViewListener(cityMenubar.btn_pic, Event.TRIGGERED, tcouhTriggred); //图鉴
            addViewListener(cityMenubar.btn_reward, Event.TRIGGERED, tcouhTriggred); //成就
            addViewListener(cityMenubar.btn_bag, Event.TRIGGERED, tcouhTriggred); //背包
            addViewListener(btn_tcouh, Event.TRIGGERED, tcouhTriggred); //收缩

            addContextListener(MailMessage.NOTICE_MAIL, onUpdateMailState);
            addContextListener(EventType.UPDATE_SIGN, updateSignStatus);
            addContextListener(EventType.UPDATE_NOTICE, updateNoticeStatus);
            addContextListener(EventType.NOTIFY_ACHIEVEMENT, updateAchievementStatus);
            addContextListener(EventType.UPDATE_PASS_FB, updateFbStatus);
            addContextListener(EventType.UPDATE_VIP, updateVipStatus);
            addContextListener(EventType.UP_HEROPHOTO, updateHeroIco);
            addContextListener(EventType.UPDATA_TASK_LIST, updateTaskIco)
            addContextListener(EventType.UPDATE_VIP, getVipRawadResponse);
            addContextListener(EventType.UPDATE_SIGN, updateDays);

            JTFunctionManager.registerFunction(JTGlobalDef.GET_TOLLGATE_GIFT, getTollgateGiftResponse);
        }


        public function refreshImage():void {
            var tollgateInfoManager:JTTollgateInfoManager = JTSingleManager.instance.tollgateInfoManager;
            var curTollgateData:JTTollgateGIftData = JTTollgateGIftData.getTollgateGift(tollgateInfoManager.current_TollgateID);
            if (!curTollgateData) {
                cityAticveBar.btn_giftButton.visible = false;
            } else {
                cityAticveBar.btn_giftButton.visible = JTSingleManager.instance.tollgateInfoManager.isGetGift;
            }
        }

        private function onCityBarHandler(info:Object):void {
            btn_tcouh.dispatchEventWith(Event.TRIGGERED);
        }

        public function visibleElements(bool:Boolean):void {
            JTUIMiniChat.btn_maxButton.visible = bg1.visible = bg2.visible = ico_hero.visible = btn_vip.visible = txt_vip.visible = btn_strategy.visible = cityAticveBar.visible = cityMenubar.visible = btn_tcouh.visible = bool;
        }

        private function tcouhTriggred(e:Event):void {
            switch (e.currentTarget) {
                case ico_hero:
                    DialogMgr.instance.open(SystemSetDlg);
                    break;
                case cityAticveBar.btn_fristpay:
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(ActivityDlg, null, null, cancelHandler);
                    break;
                case cityAticveBar.btn_pay:
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(VipDlg, VipDlg.CHARGE, null, cancelHandler);
                    break;
                case cityAticveBar.btn_qindao:
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(LoginRewardDlg, null, null, cancelHandler);
                    break;
                case btn_strategy:
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(TaskDialog, null, null, cancelHandler);
                    break;
                case cityMenubar.btn_bag:
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(PackDlg, null, null, cancelHandler);
                    break;
                case cityMenubar.btn_xingyun: //辛福星
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep5))
                        return;
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(LuckyDlg, null, null, cancelHandler);
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep5);
                    break;
                case cityMenubar.btn_mail: //邮件
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep9))
                        return;
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(EmailDlg, null, null, cancelHandler);
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep9);
                    break;
                case cityMenubar.btn_pic: //图鉴
                    if (!DisparkControl.instance.isOpenHandler(ConfigDisparkStep.DisparkStep2))
                        return;
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(PictureView, null, null, cancelHandler);
                    DisparkControl.instance.removeDisparkHandler(ConfigDisparkStep.DisparkStep2);
                    break;
                case btn_vip:
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(VipDlg, null, null, cancelHandler);
                    break;
                case cityAticveBar.btn_vipReward:
                    DialogMgr.instance.open(VipRewardDlg, null, null, null);
                    break;
                case cityMenubar.btn_reward:
                    JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                    DialogMgr.instance.open(AchievementDlg, null, null, cancelHandler);
                    break;
                case cityAticveBar.btn_notice:
                    DialogMgr.instance.open(NoticeDlg, null, null, null);
                    break;
                case cityAticveBar.btn_giftButton:
                    DialogMgr.instance.open(JTGiftTollgateComponent);
                    break;
                case btn_tcouh:
                    Starling.juggler.removeTweens(cityMenubar);
                    btn_tcouh.visible = false;
                    cityMenubar.touchable = false;
                    if (!isInside) {
                        btn_tcouh.upState = AssetMgr.instance.getTexture("icon_dakaicaozuolan_tubiao");
                        Starling.juggler.tween(cityMenubar, 0.2, {y: -cityMenubar.height, transition: Transitions.EASE_IN,
                                                   onComplete: function():void {
                                                       btn_tcouh.visible = isInside = true;
                                                       cityMenubar.touchable = true;
                                                   }});
                    } else {
                        btn_tcouh.upState = AssetMgr.instance.getTexture("icon_shouqicaozuolan_tubiao");
                        Starling.juggler.tween(cityMenubar, 0.2, {y: 0, transition: Transitions.EASE_OUT, onComplete: function():void {
                            isInside = false;
                            cityMenubar.touchable = true;
                            btn_tcouh.visible = true;
                        }});
                    }
                    break;
            }
        }

        /**改变时显示元素*/
        private function cancelHandler(e:*):void {
            JTFunctionManager.executeFunction(JTGlobalDef.PLAY_CITY_ANIMATABLE);
        }

        /**更新每日签到*/
        private function updateDays(evt:Event = null):void {
            if (GameMgr.instance.sign_reward == 1) {
                createAction(cityAticveBar.btn_qindao, "btn_qindao", 55);
                return;
            }
            removeAction("btn_qindao");
        }

        /**更新奖励*/
        private function updateVipRawad():void {
            var vipId:int = seatVipId(GameMgr.instance.vip);
            var isGet:Boolean = GameMgr.instance.vipData.dayPrize > 0;
            if (GameMgr.instance.vipData.baseVip.dayPrize != vipId && vipId > 0) {
                isGet = true;
            }
            if (vipId == 0) {
                removeAction("btn_vipReward");
                return;
            }

            if (isGet) {
                removeAction("btn_vipReward");
            } else {
                createAction(cityAticveBar.btn_vipReward, "btn_vipReward", 55);
            }

        }

        /**当前的VIP礼包*/
        public function seatVipId(vipLv:int):int {
            if (vipLv > 0) {
                if (vipLv < 5) {
                    return 1;
                } else if (vipLv < 7) {
                    return 2;
                } else if (vipLv < 11) {
                    return 3;
                } else if (vipLv < 14) {
                    return 4;
                }
                return 5;
            }
            return 0;
        }

        private function updateGiftTollgate(evt:Event, isGetGift:Boolean):void {
            if (isGetGift) {
                createAction(cityAticveBar.btn_giftButton, "btn_giftButton", 55);
                return;
            }
            removeAction("btn_giftButton");
        }

        private function updateTaskIco(evt:Event, isReceive:Boolean = false):void {
            var vect:Vector.<*> = TaskDataMgr.instance.hash.values();
            for each (var taskData:TaskData in vect) {
                if (taskData.state == 1) {
                    createAction(btn_strategy, "btn_task", 55);
                    return;
                }
            }
            removeAction("btn_task");
        }

        private function getTollgateGiftResponse(object:Object):void {
            updateGiftTollgate(null, JTSingleManager.instance.tollgateInfoManager.isGetGift);
        }

        private function getVipRawadResponse(object:Object):void {
            updateVipRawad()
        }

        /**
         * vip等级更新
         */
        private function updateVipStatus():void {
            txt_vip.text = GameMgr.instance.vip + "";
            cityAticveBar.btn_vipReward.visible = GameMgr.instance.vipData.id > 1 && GameMgr.instance.vipData.dayPrize == 0;
            cityAticveBar.btn_vipReward.visible = true;
        }

        /**
         * 更换头像
         */
        private function updateHeroIco(evt:Event, picture:int):void {
            ico_hero.upState = Res.instance.getRolePhoto(picture); //人物头像		
        }

        /**
         * 更新幸运星提示
         */
        private function updateLuckyStatus():void {
            if (GameMgr.instance.star > 0 && GameMgr.instance.tollgateID >= ConfigData.instance.luckyGuide) {
                updateWelfareStatus(true, "lucky");
                return;
            }
            updateWelfareStatus(false, "lucky");
        }

        /**福利更新*/
        private function updateWelfareStatus(value:Boolean, btn:String):void {
            if (tag_dic["welfare"] == null)
                tag_dic["welfare"] = [];
            var list:Array = tag_dic["welfare"];
            var index:int = list.indexOf(btn);

            if (value && index == -1) {
                list.push(btn);
            } else if (!value && index != -1) {
                list.splice(index, 1);
                list.length == 0 && removeAction("btn_welfare");
            }
        }

        /**
         * 检测是否有新副本可打
         */
        private function updateFbStatus():void {

        }

        /**
         * 更新登陆奖励提示
         */
        private function updateSignStatus():void {
            if (GameMgr.instance.sign_reward == 1) {
                updateWelfareStatus(true, "sign");
                return;
            }
            updateWelfareStatus(false, "sign");
        }

        /**
         * 更新邮件提示动画
         * @param evt
         * @param notice
         */
        private function onUpdateMailState(evt:Event, notice:Boolean):void {
            if (notice) {
                createAction(cityMenubar.btn_mail, "mail_notice", 55);
                return;
            }
            removeAction("mail_notice");
        }

        /**
         * 更新成就提示
         * @param isReceive
         */
        private function updateAchievementStatus(evt:Event, isReceive:Boolean):void {
            if (isReceive) {
                createAction(cityMenubar.btn_reward, "Achievement", 55);
                return;
            }
            removeAction("Achievement");
        }

        /**
         * 更新每日成就奖励
         */
        private function updateDailyStatus():void {
            var tmp_list:Array = Attain.getListByType(9, GameMgr.instance.tollgateID);
            var len:int = tmp_list.length;
            var attainInfo:AttainInfo;
            var attainData:Attain;
            var needTips:Boolean = false;
            for (var i:int = 0; i < len; i++) {
                attainData = tmp_list[i];
                attainInfo = AchievementData.instance.getAttainInfoById(attainData.id);

                if (attainInfo && attainInfo.num < attainData.condition)
                    needTips = true;
            }
            if (needTips) {
                createAction(btn_strategy, "btn_strategy");
                return;
            }
            removeAction("btn_strategy");
        }

        /**
         * 更新公告提示
         * @param evt
         * @param isReceive
         */
        private function updateNoticeStatus(evt:Event, isReceive:Boolean):void {
            if (isReceive) {
                createAction(cityAticveBar.btn_notice, "notice");
                return;
            }
            removeAction("notice");
        }


        /**
         * @param name
         */
        private function removeAction(name:String):void {
            CityIcon.removeAction(name, tag_dic);
        }

        /**
         * @param child
         * @param name
         * @param x
         * @param y
         * @return
         *
         */
        private function createAction(child:Button, name:String, x:int = 0, y:int = 0):SpriterClip {
            child.name = name;
            return CityIcon.createAction(child, name, tag_dic, x, y);
        }

        /**
         * 创建动画提示
         * @param child
         * @param name
         * @param x
         * @param y
         * @return
         */
        public static function createAction(child:Button, name:String, dic:Dictionary, x:int = 0, y:int = 0):SpriterClip {
            var disObj:SpriterClip = dic[name] as SpriterClip;

            if (disObj) {
                return null;
            }
            var action:SpriterClip = AnimationCreator.instance.create("effect_warning", AssetMgr.instance);
            action.play("NewAnimation");
            action.animation.looping = true;
            action.x = x > 0 ? x : (child.width - child.width * .08);
            action.y = y > 0 ? y : child.height * .2;
            child.addQuiackChild(action);
            action.touchable = false;
            action.name = "tag";
            dic[name] = action;
            return action;
        }

        /**
         * 移除动画
         * @param name
         */
        public static function removeAction(name:String, dic:Dictionary):void {
            var disObj:DisplayObject = dic[name];
            disObj && disObj.removeFromParent(true);
            delete dic[name];
        }

        /**销毁*/
        override public function dispose():void {
            JTFunctionManager.removeFunction(JTGlobalDef.CITY_MENU_BAR, onCityBarHandler);
            JTSession.layerGlobal.removeChild(_moneyBar);
            var clip:SpriterClip;
            for (var key:String in tag_dic) {
                clip = tag_dic[key] as SpriterClip;
                clip && clip.removeFromParent(true);
                tag_dic[key] = null;
            }
            super.dispose();
        }
    }
}
