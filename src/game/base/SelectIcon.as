package game.base {
    import game.manager.AssetMgr;

    import starling.display.Image;
    import starling.display.Sprite;

    public class SelectIcon extends Sprite {
        public function SelectIcon(w:int = 0, h:int = 0) {
            super();
            addChildIcon(w, h);
        }

        private function addChildIcon(w:int = 0, h:int = 0):void {
            //选中背景
//            var iconBg:Image = new Image(AssetMgr.instance.getTexture("ui_gongyong_heisetongmingding50"));
//            iconBg.width = 90;
//            iconBg.height = 90;
//            addQuiackChild(iconBg);
//            if (w > 0 && h > 0) {
//                iconBg.width = w;
//                iconBg.height = h;
//            }
            //选中沟选图标
            var selectIcon:Image = new Image(AssetMgr.instance.getTexture("ui_kexuanzhuangtai2"));
            selectIcon.touchable = false;
            addQuiackChild(selectIcon);
//            ObjectUtil.setToCenter(iconBg, selectIcon);
        }
    }
}
