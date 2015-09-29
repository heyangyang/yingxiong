package {
import com.dialog.DialogMgr;
import com.langue.PlayerName;
import com.langue.WordFilter;
import com.mobileLib.utils.ConverURL;
import com.mvc.interfaces.INotification;
import com.scene.SceneMgr;
import com.utils.Assets;
import com.utils.Constants;
import com.view.View;

import feathers.core.PopUpManager;

import flash.system.Capabilities;

import game.common.JTGlobalDef;
import game.common.JTSession;
import game.data.Goods;
import game.data.HeroData;
import game.data.WidgetData;
import game.manager.AssetMgr;
import game.manager.GameMgr;
import game.manager.HeroDataMgr;
import game.managers.JTFunctionManager;
import game.managers.JTSingleManager;
import game.net.GlobalMessage;
import game.net.data.AddCmd;
import game.net.data.IData;
import game.net.data.s.SAllgoods;
import game.net.data.s.SDelGoods;
import game.net.data.s.SDeletehero;
import game.net.data.s.SGet_game_coin;
import game.net.data.s.SGet_game_diamond;
import game.net.data.s.SGet_game_honor;
import game.net.data.s.SGet_game_luck;
import game.net.data.s.SMsgCode;
import game.net.data.s.SNewhero;
import game.net.data.vo.DelGoodsVO;
import game.net.data.vo.GoodsVO;
import game.scene.LoginLoadingScene;
import game.view.gameover.WinView;
import game.view.msg.MsgTips;

import starling.core.Starling;

/**
     * This class is the primary Starling Sprite based class
     * that triggers the different screens.
     *
     * @author Michael
     *
     */
    public class Game extends View {

        public function Game() {
            super();
        }

        override protected function init():void {
        }

        override public function listNotificationName():Vector.<String> {
            var vector:Vector.<String> = new Vector.<String>();
            vector.push(SNewhero.CMD);
            vector.push(SGet_game_diamond.CMD);
            vector.push(SGet_game_coin.CMD);
            vector.push(SDelGoods.CMD);
            vector.push(SDeletehero.CMD);
            vector.push(SAllgoods.CMD);
            vector.push(SGet_game_honor.CMD);
            vector.push(SMsgCode.CMD);
            vector.push(SGet_game_luck.CMD);
            return vector;
        }

        override public function handleNotification(arg1:INotification):void {
            switch (arg1.getName()) {
                //  更新物品堆叠数,pile=0时删除该物品，检索背包当id不存在时则添加
                case SAllgoods.CMD + "":
                    var data:SAllgoods = arg1 as SAllgoods;
                    if (data.type == 3) {
                        var props:Vector.<IData> = data.props;
                        var len:int = props.length;
                        for (var i:int = 0; i < len; i++) {
                            var vo:GoodsVO = props[i] as GoodsVO;
                            if (vo.pile == 0) {
                                WidgetData.hash.remove(vo.id);
                            } else {
                                var widgetData:WidgetData = WidgetData.hash.getValue(vo.id);
                                if (widgetData) {
                                    widgetData.pile = vo.pile;
                                } else {
                                    var g:Goods = Goods.goods.getValue(vo.type);
                                    widgetData = new WidgetData(g);
                                    widgetData.id = vo.id;
                                    widgetData.type = vo.type;
                                    widgetData.pile = vo.pile;
                                    widgetData.level = vo.level;
                                    widgetData.exp = vo.exp;
                                    WidgetData.hash.put(widgetData.id, widgetData);
                                }
                            }
                        }
                        var equip:Vector.<IData> = data.equip;
                        WidgetData.createEquip(equip);
                    }
                    break;
                // 增加英雄
                case SNewhero.CMD + "":
                    var newhero:SNewhero = arg1 as SNewhero;
                    HeroDataMgr.instance.create(newhero);
                    break;
                // 删除英雄
                case SDeletehero.CMD + "":
                    var deleteC:SDeletehero = arg1 as SDeletehero;
                    var heros:Vector.<int> = deleteC.heroes;

                    var le:int = heros.length;
                    for (i = 0; i < le; i++) {
                        var id:int = heros[i];
                        HeroDataMgr.instance.hash.remove(id);
                    }
                    break;
                // 更新游戏钻石
                case SGet_game_diamond.CMD + "":

                    var diamond:int = (arg1 as SGet_game_diamond).diamond
                    var gap:int = diamond - GameMgr.instance.diamond
                    if (gap > 0)
                    {
//                        RollTips.add(Langue.getLangue("Congratulations_to_get") + gap + Langue.getLangue("diamond"));
                    }

                    GameMgr.instance.diamond = diamond;
                    GameMgr.instance.updateMoney();
                    break;
                // 更新游戏金币
                case SGet_game_coin.CMD + "":

                    var coin:int = (arg1 as SGet_game_coin).coin
                    gap = coin - GameMgr.instance.coin
                    if (gap > 0)
                    {
//                        RollTips.add(Langue.getLangue("Congratulations_to_get") + gap + Langue.getLangue("buyMoney"));
                    }

                    GameMgr.instance.coin = coin;
                    GameMgr.instance.updateMoney();
                    break;
                //更新荣誉值
                case SGet_game_honor.CMD + "":
                    var honor:int = (arg1 as SGet_game_honor).honor
                    gap = honor - GameMgr.instance.honor
                    if (gap > 0)
                    {
//                        RollTips.add(Langue.getLangue("Congratulations_to_get") + gap + Langue.getLangue("game_play_Honor"));
                    }

                    GameMgr.instance.honor = honor;
                    GameMgr.instance.updateMoney();
                    JTFunctionManager.executeFunction(JTGlobalDef.PVP_REFRHES_HONOR, GameMgr.instance.honor);
                    break;
                case SGet_game_luck.CMD + "":
                    GameMgr.instance.star = (arg1 as SGet_game_luck).luck;
                    GameMgr.instance.updateMoney();
                    break;
                case SMsgCode.CMD + "":
                    var info:SMsgCode = arg1 as SMsgCode;
                    if (info.type == 1) {
                        MsgTips.instance.tips(info.code);
                    } else if (info.type == 2) {
                        WinView.code = info.code;
                            //MsgTipsDlg.instance.tips(info.code);
                    }
                    break;
                // 删除玩家物品
                case SDelGoods.CMD + "":
                    var delGoods:SDelGoods = arg1 as SDelGoods;
                    props = delGoods.props;
                    len = props.length;
                    var values:Vector.<*> = HeroDataMgr.instance.hash.values();
                    for (i = 0; i < len; i++) {
                        var delGoodsVo:DelGoodsVO = props[i] as DelGoodsVO;
                        if (delGoodsVo.pile == 0) {
                            for each (var heroData:HeroData in values) {
                                if (delGoodsVo.id > 100000) {
                                    heroData.seat1 == delGoodsVo.id ? heroData.seat1 = 0 : null;
                                    heroData.seat2 == delGoodsVo.id ? heroData.seat2 = 0 : null;
                                    heroData.seat3 == delGoodsVo.id ? heroData.seat3 = 0 : null;
                                    heroData.seat4 == delGoodsVo.id ? heroData.seat4 = 0 : null;
                                }
                            }
                            WidgetData.hash.remove(delGoodsVo.id);
                        } else {
                            widgetData = WidgetData.hash.getValue(delGoodsVo.id);
                            if (widgetData)
                                widgetData.pile = delGoodsVo.pile;
                        }
                    }
                    break;
                default:
                    break;
            }
        }

        public function start():void {
            //进度条解析
            PopUpManager.forStarling(Starling.current);
            JTSingleManager.initialize();
            SceneMgr.instance.init(JTSession.layerSence);
            DialogMgr.instance.init(JTSession.layerPanel);

            PopUpManager.root = JTSession.layerPanel;
            GlobalMessage.getInstance();
            AddCmd.init();

            stage.alpha = 0.999; // 优化
            stage.color = 0x000002;

            var str:String = new String(new Assets.Dirtyword());
            WordFilter.instance.init(str);
            PlayerName.XML_CLASS = Assets.Username;

            stage.addChild(JTSession.layerSence);
            stage.addChild(JTSession.layerChat);
            stage.addChild(JTSession.layerPanel);
            stage.addChild(JTSession.layerGlobal);
            stage.addChild(JTSession.layerGuideGlobal);

            JTSession.layerGuideGlobal.scaleX = JTSession.layerGuideGlobal.scaleY = Constants.scale;
            JTSession.layerGlobal.scaleX = JTSession.layerGlobal.scaleY = Constants.scale;
            JTSession.layerChat.scaleX = JTSession.layerChat.scaleY = Constants.scale;

            //fps
            if (Capabilities.isDebugger) 
                Starling.current.showStatsAt("right", "top", 2);
			decompress();
        }


        /**
         * 解析总配置文件
         * @param byteArray
         *
         */
        public function decompress():void {
            AssetMgr.instance.enqueue(ConverURL.conver("progressbar_home/"));
            AssetMgr.instance.loadQueue(onComplete);

            function onComplete(tmp_ratio:Number):void {
                if (tmp_ratio == 1.0) {
                    SceneMgr.instance.changeScene(LoginLoadingScene);
                }
            }
        }
    }
}
