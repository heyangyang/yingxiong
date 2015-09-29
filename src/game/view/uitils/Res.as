package game.view.uitils {
    import game.data.Goods;
    import game.data.RoleShow;
    import game.manager.AssetMgr;

    import starling.textures.Texture;

    /**
     *
     * @author Samuel
     *
     */
    public class Res {
        private var assetMgr:AssetMgr;
        private static var _instance:Res;

        public function Res() {
            assetMgr = AssetMgr.instance;
        }

        public static function get instance():Res {
            if (_instance == null)
                _instance = new Res();
            return _instance;
        }

        /**
         * 获得道具或者物品的图标 icon
         * @param id
         * @return
         */
        public function getGoodIconTexture(id:int):Texture {
            var goods:Goods = Goods.goods.getValue(id);
            return assetMgr.getTexture(goods.picture);
        }

        /**道具品质框*/
        public function getQualityToolTexture(quality:int):Texture {
            return assetMgr.getTexture("ui_daojukuang0" + (quality == 0 ? 1 : quality));
        }

        /**道具品质框*/
        public function getQualityToolTextures(quality:int):String {
            return "ui_daojukuang0" + (quality == 0 ? 1 : quality);
        }

        /**英雄头像图标*/
        public function getHeroIconTexture(show:int):Texture {
            var str:String = (show > 0) ? (RoleShow.hash.getValue(show) as RoleShow).photo : "ui_gongyong_100yingxiongkuang_kong";
            return assetMgr.getTexture(str);
        }

        /**英雄品质框*/
        public function getQualityHeroTexture(quality:int):Texture {
            return assetMgr.getTexture("ui_touxiangkuang_0" + (quality == 0 ? 1 : quality));
        }

        /**英雄品质框*/
        public function getQualityHeroTextures(quality:int):String {
            return "ui_touxiangkuang_0" + (quality == 0 ? 1 : quality);
        }

        /**英雄职业图标 攻|防|治|辅*/
        public function getJobIconTexture(job:int):Texture {
            var str:String = (job > 0) ? "ui_texingtubiao_0" + job : "ui_jinengkuangdi01";
            return assetMgr.getTexture(str);
        }

        /**获取卡牌*/
        public function getCardIconTexture(quality:int):Texture {
            var str:String = "";
            if (quality > 0) {
                if (quality >= 11) {
                    str = "ui_renwukapai_0" + 5;
                } else if (quality >= 7) {
                    str = "ui_renwukapai_0" + 4;
                } else if (quality >= 4) {
                    str = "ui_renwukapai_0" + 3;
                } else if (quality >= 2) {
                    str = "ui_renwukapai_0" + 2;
                } else if (quality >= 1) {
                    str = "ui_renwukapai_0" + 1;
                }
            } else {
                str = "ui_renwukapai_01";
            }
            return assetMgr.getTexture(str);
        }

        /**pvp人物头像*/
        public function getRolePhoto(picture:int):Texture {
            return assetMgr.getTexture("ui_pvp_renwutouxiang" + picture);
        }

        /**
         * 战斗加速图标
         * @param show
         * @return
         */
        public function getVipSpeedPhoto(speed:Number):Texture {
            return assetMgr.getTexture("ui_icon_acceleration" + Math.floor(speed) + "_" + (speed % 1.0) * 10);
        }

        /**装备类型图标*/
        public function getTypeEquipTexture(sort:int):Texture {
            return assetMgr.getTexture("ui_yingxiongshengdian_wuqikuangbiaozhi" + (sort > 0 ? sort : 1));
        }

        /**
         * 竞技图标
         * @param rankLevel
         * @return
         */
        public function getRankPhoto(rankLevel:int):Texture {
            if (rankLevel == 0) {
                rankLevel = 6;
            }
            return assetMgr.getTexture("ui_iocn_qualifying" + rankLevel);
        }

        /**
         * 获公用图标
         * @param type 0:战斗力, 1:金币, 2:钻石 , 3:幸运星, 7:疲劳, 8:喇叭, 9:英雄魂, 10:大的金币, 11:大的钻石, 12:大的幸运星, 13:大的疲劳
         * @return
         */
        public function getCommTexture(type:int = 1):Texture {
            var str:String = "";
            switch (type) {
                case 0:
                    //战斗力
                    str = "ui_zhandouli02_tubiao";
                    break;
                case 1:
                    //金币
                    str = "ui_jinbi01_tubiao";
                    break;
                case 2:
                    //钻石
                    str = "ui_zuanshi01_tubiao";
                    break;
                case 3:
                    //幸运星
                    str = "ui_xingyunxing01_tubiao";
                    break;
                case 7:
                    //疲劳
                    str = "ui_tili01_tubiao";
                    break;
                case 8:
                    //喇叭
                    str = "icon_8";
                    break;
                case 9:
                    //英雄魂图标
                    str = "ui_yingxionghun_tubiao_02";
                    break;
                case 10:
                    //大的金币
                    str = "ui_tubiao_jinbi_da";
                    break;
                case 11:
                    //大的钻石
                    str = "ui_tubiao_zuanshi_da";
                    break;
                case 12:
                    //大的幸运星
                    str = "icon_3";
                    break;
                case 13:
                    //大的疲劳
                    str = "icon_7";
                    break;
            }
            return assetMgr.getTexture(str);
        }


        /**
         * 获公用图标
         * @param type 0:战斗力, 1:小的金币, 2:小的钻石 , 3:幸运星, 7:疲劳, 8:喇叭, 9:英雄魂, 10:大的金币, 11:大的钻石, 12:大的幸运星, 13:大的疲劳
         * @return
         */
        public function getCommTextures(type:int = 1):String {
            var str:String = "";
            switch (type) {
                case 0:
                    //战斗力
                    str = "ui_zhandouli02_tubiao";
                    break;
                case 1:
                    //小的金币
                    str = "ui_jinbi01_tubiao";
                    break;
                case 2:
                    //小的钻石
                    str = "ui_zuanshi01_tubiao";
                    break;
                case 3:
                    //幸运星
                    str = "ui_xingyunxing01_tubiao";
                    break;
                case 7:
                    //疲劳
                    str = "ui_tili01_tubiao";
                    break;
                case 8:
                    //喇叭
                    str = "icon_8";
                    break;
                case 9:
                    //英雄魂图标
                    str = "ui_yingxionghun_tubiao_02";
                    break;
                case 10:
                    //大的金币
                    str = "ui_tubiao_jinbi_da";
                    break;
                case 11:
                    //大的钻石
                    str = "ui_tubiao_zuanshi_da";
                    break;
                case 12:
                    //大的幸运星
                    str = "icon_3";
                    break;
                case 13:
                    //大的疲劳
                    str = "icon_7";
                    break;
            }
            return str;
        }
    }
}
