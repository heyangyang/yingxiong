package  game.view.viewBase
{
    import starling.display.Image;
    import game.manager.AssetMgr;
    import starling.utils.AssetManager;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.text.TextField;
    import starling.display.Button;
    import flash.geom.Rectangle;
    import com.utils.Constants;
    import feathers.controls.TextInput;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;
    import game.scene.world.MapItemList;
    import game.scene.world.MainMapFigthView;
    import com.dialog.Dialog;

    public class MainMapDialogBase extends Dialog
    {
        public var ui_dicengying02_jiemian84644:Scale9Image;
        public var bg:Image;
        public var maskMap:Scale9Image;
        public var ui_dicengying02_jiemian84544:Scale9Image;
        public var ui_ditu_zhishibiaoshidi930105:Scale9Image;
        public var mapItem:MapItemList;
        public var btn_close:Button;
        public var lastBtn:Button;
        public var nextBtn:Button;
        public var figthView:MainMapFigthView;

        public function MainMapDialogBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var ui_dicengying02_jiemian84644Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_dicengying02_jiemian846449ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_dicengying02_jiemian84644Rect);
            ui_dicengying02_jiemian84644 = new Scale9Image(ui_dicengying02_jiemian846449ScaleTexture);
            ui_dicengying02_jiemian84644.x = 846;
            ui_dicengying02_jiemian84644.y = 44;
            ui_dicengying02_jiemian84644.width = 78;
            ui_dicengying02_jiemian84644.height = 504;
            this.addQuiackChild(ui_dicengying02_jiemian84644);
            texture = assetMgr.getTexture('ui_tanchukuangdi02_jiemian')
            bg = new Image(texture);
            bg.width = 972;
            bg.height = 598;
            this.addQuiackChild(bg);
            bg.touchable = false;
            texture = assetMgr.getTexture('ui_ditu_zhezhaoding');
            var maskMapRect:Rectangle = new Rectangle(46,46,4,4);
            var maskMap9ScaleTexture:Scale9Textures = new Scale9Textures(texture,maskMapRect);
            maskMap = new Scale9Image(maskMap9ScaleTexture);
            maskMap.x = 43;
            maskMap.y = 40;
            maskMap.width = 881;
            maskMap.height = 512;
            this.addQuiackChild(maskMap);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var ui_dicengying02_jiemian84544Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_dicengying02_jiemian845449ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_dicengying02_jiemian84544Rect);
            ui_dicengying02_jiemian84544 = new Scale9Image(ui_dicengying02_jiemian845449ScaleTexture);
            ui_dicengying02_jiemian84544.x = 845;
            ui_dicengying02_jiemian84544.y = 44;
            ui_dicengying02_jiemian84544.width = 78;
            ui_dicengying02_jiemian84544.height = 504;
            this.addQuiackChild(ui_dicengying02_jiemian84544);
            texture = assetMgr.getTexture('ui_ditu_zhishibiaoshidi');
            var ui_ditu_zhishibiaoshidi930105Rect:Rectangle = new Rectangle(4,12,8,8);
            var ui_ditu_zhishibiaoshidi9301059ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_ditu_zhishibiaoshidi930105Rect);
            ui_ditu_zhishibiaoshidi930105 = new Scale9Image(ui_ditu_zhishibiaoshidi9301059ScaleTexture);
            ui_ditu_zhishibiaoshidi930105.x = 930;
            ui_ditu_zhishibiaoshidi930105.y = 105;
            ui_ditu_zhishibiaoshidi930105.width = 15;
            ui_ditu_zhishibiaoshidi930105.height = 390;
            this.addQuiackChild(ui_ditu_zhishibiaoshidi930105);
            mapItem = new MapItemList();
            mapItem.x = 852;
            mapItem.y = 101;
            this.addQuiackChild(mapItem);
            texture = assetMgr.getTexture('ui_guanbi01_anniu');
            btn_close = new Button(texture);
            btn_close.name= 'btn_close';
            btn_close.x = 884;
            btn_close.y = 15;
            btn_close.width = 72;
            btn_close.height = 76;
            this.addQuiackChild(btn_close);
            texture = assetMgr.getTexture('ui_xiangshangtishi01_anniu');
            lastBtn = new Button(texture);
            lastBtn.name= 'lastBtn';
            lastBtn.x = 403;
            lastBtn.y = 6;
            lastBtn.width = 109;
            lastBtn.height = 68;
            this.addQuiackChild(lastBtn);
            texture = assetMgr.getTexture('ui_xiangxiatishi01_anniu');
            nextBtn = new Button(texture);
            nextBtn.name= 'nextBtn';
            nextBtn.x = 403;
            nextBtn.y = 519;
            nextBtn.width = 109;
            nextBtn.height = 68;
            this.addQuiackChild(nextBtn);
            figthView = new MainMapFigthView();
            figthView.x = 45;
            figthView.y = 41;
            this.addQuiackChild(figthView);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            mapItem.dispose();
            btn_close.dispose();
            lastBtn.dispose();
            nextBtn.dispose();
            figthView.dispose();
            super.dispose();
        
}
    }
}
