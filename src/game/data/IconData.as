package game.data {

    public class IconData {
        /**在帧频数那里执行获得的物品显示**/
        public var frame:int = 0;

        /**物品类型*/
        public var IconType:uint = 0;

        /**物品id*/
        public var IconId:uint = 0;

        /**底色框*/
        public var bg:String = "ui_daojukuangdi";

        /**图片Icon*/
        public var IconTrue:String = "";

        /**品质背景框*/
        public var QualityTrue:String = "";

        /**
         *英雄魂图标
         */
        public var hun:String = "ui_yingxionghun_tubiao_02";

        /**图标名字*/
        public var Name:String = "";

        /**物品数量*/
        public var Num:String = "";

        /**是否是按钮模式 默认false*/
        public var ButtonModel:Boolean = true;
        /**是否显示英雄混图标false*/
        public var hunModel:Boolean = true;
    }
}


