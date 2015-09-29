package game.view.task {
    import com.dialog.DialogMgr;
    import com.langue.Langue;
    import com.scene.SceneMgr;
    import com.sound.SoundManager;
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import feathers.controls.tree.TreeCellRendererVO;
    import feathers.controls.tree.TreeEvent;

    import game.base.BaseIcon;
    import game.common.JTFastBuyComponent;
    import game.common.JTGlobalDef;
    import game.common.JTLogger;
    import game.common.JTSession;
    import game.data.ConfigData;
    import game.data.IconData;
    import game.data.MainLineData;
    import game.data.MonsterData;
    import game.data.RoleShow;
    import game.data.TaskData;
    import game.data.TollgateData;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.manager.HeroDataMgr;
    import game.manager.TaskDataMgr;
    import game.managers.JTFunctionManager;
    import game.net.data.vo.TaskPlan;
    import game.net.message.GameMessage;
    import game.net.message.GoodsMessage;
    import game.net.message.TaskMessage;
    import game.scene.FBMapDialog;
    import game.scene.MainMapDialog;
    import game.view.achievement.AchievementDlg;
    import game.view.activity.ActivityDlg;
    import game.view.arena.ArenaCreateNameDlg;
    import game.view.arena.ArenaDialog;
    import game.view.blacksmith.BlacksmithDialog;
    import game.view.chat.component.JTChatControllerComponent;
    import game.view.city.CityFace;
    import game.view.email.EmailDlg;
    import game.view.heroHall.HeroDialog;
    import game.view.loginReward.LoginRewardDlg;
    import game.view.luckyStar.LuckyDlg;
    import game.view.magicShop.MagicOrbDia;
    import game.view.notice.NoticeDlg;
    import game.view.pack.PackDlg;
    import game.view.picture.PictureView;
    import game.view.rank.RankDlg;
    import game.view.shop.ShopDlg;
    import game.view.strategy.StrategyDlg;
    import game.view.task.render.TaskCellRender;
    import game.view.task.view.TaskTree;
    import game.view.tavern.TavernDialog;
    import game.view.viewBase.TaskDialogBase;
    import game.view.vip.VipDlg;
    import game.view.vip.VipRewardDlg;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.display.DisplayObjectContainer;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.utils.HAlign;

    /**
     * 任务系统模块
     * @author Samuel
     */
    public class TaskDialog extends TaskDialogBase {
        /**任务列表*/
        private var _tree:TaskTree = null;
        /**当前选中节点*/
        private var _taskCellRender:TaskCellRender = null;
        /**任务宝箱*/
        private var _effectSp:SpriterClip = null;
        /**是否是初始化*/
        private var _init:Boolean = false;

        public function TaskDialog() {
            super();
        }

        /**初始化*/
        override protected function init():void {
            _closeButton = btn_close;
            bgImage0.alpha = bgImage1.alpha = bgImage2.alpha = 0.5;
            //任务列表
            _tree = new TaskTree();
            _tree.itemRenderer = TaskCellRender;
            _tree.x = 54;
            _tree.y = 112;
            _tree.width = 195;
            _tree.height = 385;
            addChild(_tree);

            if (_effectSp) {
                _effectSp.visible = false;
            }
            this.taskContent.text = "";
            this.taskButton_Scale9Button.text = "";
            this.taskButton_Scale9Button.touchable = false;
        }

        /**初始化监听*/
        override protected function addListenerHandler():void {
            super.addListenerHandler();
            _tree.addEventListener(TreeEvent.CLICK_NODE, onClickTreeNode);
            addViewListener(taskButton_Scale9Button, Event.TRIGGERED, makeTaskHandler);
            addContextListener(EventType.UPDATA_TASK_LIST, onUpdataTaskList);
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            _tree.dataProvider = TaskDataMgr.instance.getTaskDatas(TaskDataMgr.instance.hash.values());
            setToCenter();
            openComplete();
        }

        /**关闭*/
        override public function close():void {
            background && background.removeFromParent(true);
            super.close();
        }

        private function onUpdataTaskList(evt:Event):void {
            if (_effectSp) {
                _effectSp.visible = false;
            }
            this.taskContent.text = "";
            this.taskButton_Scale9Button.text = "";
            this.taskButton_Scale9Button.touchable = false;
            _tree.dataProvider = TaskDataMgr.instance.getTaskDatas(TaskDataMgr.instance.hash.values());
            openComplete();
        }

        private function getBoxHandler(e:TouchEvent):void {
            var touch:Touch = e.getTouch(stage);
            if (touch == null) {
                return;
            }
            switch (touch.phase) {
                case TouchPhase.BEGAN:
                    if (_taskCellRender != null) {
                        var treeData:TreeCellRendererVO = _taskCellRender.data;
                        var taskData:TaskData = TaskDataMgr.instance.hash.getValue(treeData.id);
                        if (taskData.state == 1) {
                            TaskMessage.getTask(taskData.TaskId);
                        }
                    }
                    break;
            }
        }

        /**打开结束*/
        protected function openComplete():void {

            if (TaskDataMgr.instance.currTaskType == 0 && TaskDataMgr.instance.currTaskId == 0) {
                _tree.openAllNodes();
                var taskData:TaskData = TaskDataMgr.instance.makeOneTask;
                if (taskData == null) {
                    _tree.selectOneNode();
                } else {
                    TaskDataMgr.instance.currTaskId = taskData.TaskId;
                    _tree.selectChildNode(TaskDataMgr.instance.currTaskId);
                }
            } else {
                _tree.openAllNodes();
                _tree.selectChildNode(TaskDataMgr.instance.currTaskId);
            }
        }

        /**选中节点*/
        private function onClickTreeNode(e:TreeEvent):void {
            var cellTree:TaskCellRender = e.target as TaskCellRender;
            if (_init)
                SoundManager.instance.playSound("UI_click");
            if (cellTree.data.hasParentNodes) {
                var taskData:TaskData = TaskDataMgr.instance.hash.getValue(cellTree.data.id);
                updataTaskUI(taskData);
                _taskCellRender = cellTree;
                _taskCellRender.removeNewIcon();
                TaskDataMgr.instance.currTaskType = taskData.TaskType;
                TaskDataMgr.instance.currTaskId = taskData.TaskId;
                _init = true;
            } else {
//                if (cellTree.isOpen())
//                {
//                    _tree.scrollToPosition(0, cellTree.y, 1); //将选中的置位置0
//                }
//                else
//                {
//                    _tree.scrollToPosition(0, 0, 1);
//                }
            }
        }

        /**更新taskUI列表*/
        protected function updataTaskUI(taskData:TaskData):void {
            _effectSp && _effectSp.removeFromParent();
            Starling.juggler.remove(_effectSp);
            _effectSp = null;
            this.taskButton_Scale9Button.touchable = true;
            this.taskContent.text = taskData.TaskDes;
            if (taskData.state == 1) {
                this.taskButton_Scale9Button.text = Langue.getLangue("okUse"); //可领取
                if (_effectSp == null) {
                    _effectSp = AnimationCreator.instance.create("effect_036", AssetMgr.instance);
                    addQuiackChild(_effectSp);
                    _effectSp.play("round"); //effect_036 round out open; 
                    _effectSp.animation.looping = true;
                    _effectSp.animation.id = 1;
                    _effectSp.touchable = true;
                    _effectSp.x = 830;
                    _effectSp.y = 320;
                    _effectSp.visible = true;
                    Starling.juggler.add(_effectSp);
                    setChildIndex(_effectSp, this.numChildren - 1);
                    _effectSp.addEventListener(TouchEvent.TOUCH, getBoxHandler);
                }

            } else {
                this.taskButton_Scale9Button.text = Langue.getLangue("goto") + "(" + (TaskDataMgr.instance.taskProgress(taskData) + "/" + TaskDataMgr.instance.totalProgress(taskData)) + ")";
            }
            updataTarget(taskData);
            updataRawd(taskData);
        }

        /**任务奖励物品数据*/
        private function updataRawd(taskData:TaskData):void {
            var vect:Vector.<IconData> = taskData.GetTaskRwad(true, false);
            var len:uint = vect.length;
            var baseIcon:BaseIcon = null;
            var iconData:IconData = null;
            for (var i:uint = 0; i < 4; i++) {
                iconData = i < len ? vect[i] : null;
                if (iconData) {
                    baseIcon = this.getChildByName("baseIcon_" + i) as BaseIcon;
                    if (baseIcon == null) {
                        baseIcon = new BaseIcon(iconData);
                        baseIcon.name = "baseIcon_" + i;
                        baseIcon.x = i * 105 + 275;
                        baseIcon.y = 395;
                        baseIcon.text_Num.hAlign = HAlign.LEFT;
                        addQuiackChild(baseIcon);
                    } else {
                        baseIcon.updata(iconData);
                    }
                } else {
                    baseIcon = this.getChildByName("baseIcon_" + i) as BaseIcon;
                    baseIcon && baseIcon.removeFromParent(true);
                }
            }
        }

        /**更新任务目标*/
        /**
         * @param tastData
         */
        private function updataTarget(tastData:TaskData):void {
            var iconData:IconData = null;
            var mainLineData:MainLineData = null;
            var monsterData:MonsterData = null;
            var taskPlan:TaskPlan = null;
            var roleShow:RoleShow = null;
            var vectorData:Vector.<IconData> = new Vector.<IconData>;
            var arr:Array = Langue.getLans("task_target_name");
            switch (tastData.TaskTarget) {
                case 1: //关卡目标
                    for each (taskPlan in tastData.TaskPlanVector) {
                        iconData = new IconData();
                        mainLineData = MainLineData.getPoint(taskPlan.type);
                        if (mainLineData.boss_type == 1) {
                            iconData.bg = "ui_touxiangdi02_02";
                        } else {
                            iconData.bg = "ui_touxiangdi02_03";
                        }
                        iconData.Name = arr[0] + mainLineData.pointName;
                        iconData.Num = "x " + taskPlan.number.toString();
                        monsterData = MonsterData.monster.getValue(mainLineData.boss_id);
                        roleShow = RoleShow.hash.getValue(monsterData.show) as RoleShow;
                        iconData.IconTrue = roleShow.photo;
                        vectorData.push(iconData);
                    }
                    break;
                case 2: //怪物目标
                    for each (taskPlan in tastData.TaskPlanVector) {
                        iconData = new IconData();
                        monsterData = MonsterData.monster.getValue(taskPlan.type);
                        roleShow = RoleShow.hash.getValue(monsterData.show) as RoleShow;
                        iconData.Name = arr[1] + monsterData.name;
                        iconData.Num = "x " + taskPlan.number.toString();
                        iconData.QualityTrue = "ui_touxiangkuang_01";
                        iconData.IconTrue = roleShow.photo;
                        vectorData.push(iconData);
                    }
                    break;
                default: //其他目标
                    break;
            }

            var baseIcon:BaseIcon = null;
            var len:uint = vectorData.length;
            var taskTips:TextField = null;
            for (var i:uint = 0; i < 3; i++) {
                iconData = i < len ? vectorData[i] : null;
                baseIcon = this.getChildByName("baseIconTarget_" + i) as BaseIcon;
                baseIcon && baseIcon.removeFromParent(true);
                baseIcon = null;
                if (baseIcon == null && iconData) {
                    baseIcon = new BaseIcon(iconData);
                    baseIcon.name = "baseIconTarget_" + i;
                    if (tastData.TaskTarget == 1) {
                        baseIcon.iconImage.scaleX = 0.7;
                        baseIcon.iconImage.scaleY = 0.7;
                        baseIcon.iconImage.x += 10;
                        baseIcon.iconImage.y += 10;
                        baseIcon.iconImage.parent.setChildIndex(baseIcon.iconImage, 0);
                    } else {
                        baseIcon.scaleX = 0.8;
                        baseIcon.scaleY = 0.8;
                    }
                    addQuiackChild(baseIcon);
                    baseIcon.x = i * 120 + 580;
                    baseIcon.y = 270;
                    this["targetName_" + (i + 1)].text = (i + 1) + "." + iconData.Name;
                    baseIcon.text_Name.text = "";
                    baseIcon.text_Num.fontSize = 28;
                    baseIcon.text_Num.hAlign = HAlign.RIGHT;
                    baseIcon.text_Num.x -= 5;
                    baseIcon.text_Num.y -= 10;
                } else {
                    this["targetName_" + (i + 1)].text = "";
                }
            }
        }

        /**去做任务*/
        private function makeTaskHandler(e:Event):void {
            if (_taskCellRender != null) {
                var treeData:TreeCellRendererVO = _taskCellRender.data;
                var taskData:TaskData = TaskDataMgr.instance.hash.getValue(treeData.id);
                if (taskData.state == 1) {
                    TaskMessage.getTask(taskData.TaskId);
                    return;
                }

                if (taskData.OperTaskType == 1) { //主线 或者关卡
                    if (taskData.OperTaskChlidType > 0) {
                        if (HeroDataMgr.instance.getHerosMaxLv() <= taskData.TaskLevel) {
                            addTips(Langue.getLangue("task_leve_show").replace("*", taskData.TaskLevel));
                            return;
                        }

                        var mainLineData:MainLineData = MainLineData.getPoint(taskData.OperTaskChlidType);
                        if (mainLineData.isFb) { //副本
                        } else if (mainLineData.isNightMare) { //噩梦

                        } else if (mainLineData.isStory) {

                        } else {
                            //主线
                            if (GameMgr.instance.tollgateID < mainLineData.pointID) {
                                addTips(Langue.getLangue("task_tollgate_show").replace("*", mainLineData.pointID));
                                return;
                            }
                        }

                        var tollgateData:TollgateData = TollgateData.hash.getValue(taskData.OperTaskChlidType);
                        if (GameMgr.instance.tired < tollgateData.tired) //购买体力
                        {
                            GoodsMessage.onBuyTiredClick();
                            return;
                        }

                        if (SceneMgr.instance.isScene(CityFace)) {
                            GameMessage.gotoTollgateData(taskData.OperTaskChlidType, DialogMgr.instance.currScene, DialogMgr.instance.currDialogs,
                                                         DialogMgr.instance.currDialogParams);
                        } else {
                            GameMessage.gotoTollgateData(taskData.OperTaskChlidType);
                        }
                        close();
                    }
                    return;
                }

                if (GameMgr.instance.tollgateID < taskData.TaskTollgate) //功能模块关卡不够
                {
                    addTips(Langue.getLangue("task_tollgate_show").replace("*", taskData.TaskTollgate));
                    return;
                }
                var dialogMgr:DialogMgr = DialogMgr.instance;
                switch (taskData.OperTaskType) {
                    case 1: //主线 或者关卡
                        break;
                    case 2: //装备模块
                        dialogMgr.open(BlacksmithDialog, {tab: taskData.OperTaskChlidType});
                        break;
                    case 3: //英雄模块
                        dialogMgr.open(HeroDialog, taskData.OperTaskChlidType);
                        break;
                    case 4: //酒馆模块
                        dialogMgr.open(TavernDialog, taskData.OperTaskChlidType);
                        break;
                    case 5: //宝珠模块
                        dialogMgr.open(MagicOrbDia, taskData.OperTaskChlidType);
                        break;
                    case 6: //商店模块
                        dialogMgr.open(ShopDlg, taskData.OperTaskChlidType);
                        break;
                    case 7: //试练
                        DialogMgr.instance.closeAllDialog();
                        SceneMgr.instance.changeScene(CityFace);
                        DialogMgr.instance.open(FBMapDialog);
                        JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                        break;
                    case 8: //角斗场
                        if (GameMgr.instance.arenaname == "" || GameMgr.instance.arenaname == null) { //创建玩家名字
                            JTFunctionManager.executeFunction(JTGlobalDef.PLAY_CITY_ANIMATABLE);
                            DialogMgr.instance.open(ArenaCreateNameDlg, false);
                            close();
                        } else {
                            DialogMgr.instance.open(ArenaDialog, false);
                        }
                        break;
                    case 9: //排行
                        DialogMgr.instance.open(RankDlg);
                        break;
                    case 10: //公会
                        JTLogger.debug("公会");
                        break;
                    case 11: //购买钻石&VIP
                        dialogMgr.open(VipRewardDlg);
                        break;
                    case 12: //购买金币
                        dialogMgr.open(JTFastBuyComponent, JTFastBuyComponent.FAST_BUY_MONEY);
                        break;
                    case 13: //购买疲劳
                        GoodsMessage.onBuyTiredClick();
                        break;
                    case 14: //小助手模块
                        dialogMgr.open(StrategyDlg, taskData.OperTaskChlidType);
                        break;
                    case 15: //邮件
                        dialogMgr.open(EmailDlg);
                        break;
                    case 16: //聊天
                        if (!JTSession.layerChat.contains(JTChatControllerComponent.instance)) {
                            JTChatControllerComponent.instance = new JTChatControllerComponent();
                            JTSession.layerChat.addChild(JTChatControllerComponent.instance);
                        }
                        JTFunctionManager.executeFunction(JTGlobalDef.MIN_SWITCHOVER_MAX);
                        break;
                    case 17: //公告
                        dialogMgr.open(NoticeDlg);
                        break;
                    case 18: //福利
                        trace("福利");
                        break;
                    case 19: //图鉴
                        dialogMgr.open(PictureView);
                        break;
                    case 20: //背包
                        dialogMgr.open(PackDlg, taskData.OperTaskChlidType);
                        break;
                    case 21: //成就
                        dialogMgr.open(AchievementDlg);
                        break;
                    case 22: //活动模块
                        DialogMgr.instance.open(ActivityDlg, taskData.OperTaskChlidType);
                        break;
                    case 23: //幸运星
                        DialogMgr.instance.open(LuckyDlg);
                        break;
                    case 24: //每日VIP礼包
                        DialogMgr.instance.open(VipRewardDlg);
                        break;
                    case 25: //月卡
                        DialogMgr.instance.open(VipDlg, taskData.OperTaskChlidType);
                        break;
                    case 26: //签到
                        dialogMgr.open(LoginRewardDlg);
                        break;
                    case 27: //跳转facebook
                        ViewDispatcher.dispatch(EventType.GOTO_WEB, ConfigData.instance.facebook_url.replace('"', '').replace('"',
                                                                                                                              ''));
                        TaskMessage.getSpecialTask(1);
                        break;
                    case 28: //主线通关次数
                        DialogMgr.instance.closeAllDialog();
                        SceneMgr.instance.changeScene(CityFace);
                        DialogMgr.instance.open(MainMapDialog);
                        JTFunctionManager.executeFunction(JTGlobalDef.STOP_CITY_ANIMATABLE);
                        break;
                    default:
                        JTLogger.debug("没有对应的操作类型");
                        break;
                }
            }

        }

        /**销毁*/
        override public function dispose():void {
            _init = false;
            _taskCellRender.removeFromParent(true);
            _effectSp && _effectSp.removeFromParent(true);
            _tree.removeFromParent(true);
            super.dispose();
        }

    }
}


