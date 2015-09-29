package game.view.viewBase {
    import com.components.Scale9Button;
    import com.view.View;

    import flash.geom.Rectangle;

    import feathers.controls.List;
    import feathers.controls.TextInput;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;

    import game.manager.AssetMgr;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.AssetManager;

    public class GoodsGuideForgeViewBase extends View {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var view_drop:Sprite;
        public var list_drop:List;
        public var grid:GoodsGuideGridBase;
        public var list_equip:List;
        public var btnok_Scale9Button:Scale9Button;

        public function GoodsGuideForgeViewBase() {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var ui_tipstanchukuangdi01_jiemian00Rect:Rectangle = new Rectangle(48, 46, 44, 43);
            var ui_tipstanchukuangdi01_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture, ui_tipstanchukuangdi01_jiemian00Rect);
            ui_tipstanchukuangdi01_jiemian00 = new Scale9Image(ui_tipstanchukuangdi01_jiemian009ScaleTexture);
            ui_tipstanchukuangdi01_jiemian00.width = 408;
            ui_tipstanchukuangdi01_jiemian00.height = 570;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            view_drop = new Sprite();
            view_drop.x = 28;
            view_drop.y = 161;
            view_drop.width = 352;
            view_drop.height = 328;
            this.addQuiackChild(view_drop);
            view_drop.name = 'view_drop';
            texture = assetMgr.getTexture('ui_anniuzhixiangjiantou01_anniu')
            image = new Image(texture);
            image.name = 'tag';
            image.x = 181;
            image.width = 16;
            image.height = 9;
            view_drop.addQuiackChild(image);
            image.touchable = false;
            list_drop = new List();
            list_drop.y = 18;
            list_drop.width = 352;
            list_drop.height = 310;
            view_drop.addQuiackChild(list_drop);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian114Rect:Rectangle = new Rectangle(3, 0, 3, 2);
            var ui_zhuangshixianquan02_jiemian1149ScaleTexture:Scale9Textures = new Scale9Textures(texture, ui_zhuangshixianquan02_jiemian114Rect);
            var ui_zhuangshixianquan02_jiemian114:Scale9Image = new Scale9Image(ui_zhuangshixianquan02_jiemian1149ScaleTexture);
            ui_zhuangshixianquan02_jiemian114.x = 1;
            ui_zhuangshixianquan02_jiemian114.y = 14;
            ui_zhuangshixianquan02_jiemian114.width = 350;
            ui_zhuangshixianquan02_jiemian114.height = 1;
            view_drop.addQuiackChild(ui_zhuangshixianquan02_jiemian114);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian113Rect:Rectangle = new Rectangle(3, 0, 3, 2);
            var ui_zhuangshixianquan02_jiemian1139ScaleTexture:Scale9Textures = new Scale9Textures(texture, ui_zhuangshixianquan02_jiemian113Rect);
            var ui_zhuangshixianquan02_jiemian113:Scale9Image = new Scale9Image(ui_zhuangshixianquan02_jiemian1139ScaleTexture);
            ui_zhuangshixianquan02_jiemian113.x = 1;
            ui_zhuangshixianquan02_jiemian113.y = 13;
            ui_zhuangshixianquan02_jiemian113.width = 350;
            ui_zhuangshixianquan02_jiemian113.height = 1;
            view_drop.addQuiackChild(ui_zhuangshixianquan02_jiemian113);
            grid = new GoodsGuideGridBase();
            grid.x = 156;
            grid.y = 55;
            this.addQuiackChild(grid);
            list_equip = new List();
            list_equip.x = 49;
            list_equip.y = 219;
            list_equip.width = 310;
            list_equip.height = 133;
            this.addQuiackChild(list_equip);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var btnok_Scale9ButtonRect:Rectangle = new Rectangle(37, 18, 45, 22);
            btnok_Scale9Button = new Scale9Button(texture, btnok_Scale9ButtonRect);
            btnok_Scale9Button.x = 115;
            btnok_Scale9Button.y = 424;
            btnok_Scale9Button.width = 180;
            btnok_Scale9Button.height = 62;
            this.addQuiackChild(btnok_Scale9Button);
            btnok_Scale9Button.name = 'btnok_Scale9Button';
            btnok_Scale9Button.text = 'lable';
            btnok_Scale9Button.fontColor = 0xFFFFFF;
            btnok_Scale9Button.fontSize = 22;
            init();
        }

        public function get assetMgr():AssetManager {
            return AssetMgr.instance;
        }

        override public function dispose():void {
            list_drop.dispose();
            view_drop.dispose();
            grid.dispose();
            list_equip.dispose();
            super.dispose();

        }
    }
}
