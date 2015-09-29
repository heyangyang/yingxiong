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
    import game.view.embattle.EmbattleGrid;
    import game.view.embattle.EmbattleFigthView;
    import game.view.embattle.BattleVideoRank;
    import com.dialog.Dialog;

    public class NewEmBattleDlgBase extends Dialog
    {
        public var pos1:EmbattleGrid;
        public var pos4:EmbattleGrid;
        public var pos7:EmbattleGrid;
        public var pos8:EmbattleGrid;
        public var pos5:EmbattleGrid;
        public var pos2:EmbattleGrid;
        public var pos3:EmbattleGrid;
        public var pos6:EmbattleGrid;
        public var pos9:EmbattleGrid;
        public var view_list:Sprite;
        public var figthView:EmbattleFigthView;
        public var view_title:Sprite;
        public var btn_close:Button;
        public var view_rank:BattleVideoRank;

        public function NewEmBattleDlgBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            pos1 = new EmbattleGrid();
            pos1.x = 320;
            pos1.y = 195;
            this.addQuiackChild(pos1);
            pos4 = new EmbattleGrid();
            pos4.x = 178;
            pos4.y = 195;
            this.addQuiackChild(pos4);
            pos7 = new EmbattleGrid();
            pos7.x = 40;
            pos7.y = 195;
            this.addQuiackChild(pos7);
            pos8 = new EmbattleGrid();
            pos8.x = 13;
            pos8.y = 285;
            this.addQuiackChild(pos8);
            pos5 = new EmbattleGrid();
            pos5.x = 151;
            pos5.y = 285;
            this.addQuiackChild(pos5);
            pos2 = new EmbattleGrid();
            pos2.x = 291;
            pos2.y = 285;
            this.addQuiackChild(pos2);
            pos3 = new EmbattleGrid();
            pos3.x = 264;
            pos3.y = 375;
            this.addQuiackChild(pos3);
            pos6 = new EmbattleGrid();
            pos6.x = 125;
            pos6.y = 375;
            this.addQuiackChild(pos6);
            pos9 = new EmbattleGrid();
            pos9.x = -17;
            pos9.y = 375;
            this.addQuiackChild(pos9);
            view_list = new Sprite();
            view_list.x = -20;
            view_list.y = 447;
            view_list.width = 984;
            view_list.height = 214;
            this.addQuiackChild(view_list);
            view_list.name= 'view_list';
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var heroListBGRect:Rectangle = new Rectangle(68,64,6,6);
            var heroListBG9ScaleTexture:Scale9Textures = new Scale9Textures(texture,heroListBGRect);
            var heroListBG : Scale9Image = new Scale9Image(heroListBG9ScaleTexture);
            heroListBG.width = 984;
            heroListBG.height = 214;
            view_list.addQuiackChild(heroListBG);
            figthView = new EmbattleFigthView();
            figthView.x = -20;
            figthView.y = 447;
            this.addQuiackChild(figthView);
            view_title = new Sprite();
            view_title.x = 330;
            view_title.y = 8;
            view_title.width = 300;
            view_title.height = 50;
            this.addQuiackChild(view_title);
            view_title.name= 'view_title';
            texture = assetMgr.getTexture('ui_danxiangkuangdi');
            var bgImgRect:Rectangle = new Rectangle(18,32,34,2);
            var bgImg9ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImgRect);
            var bgImg : Scale9Image = new Scale9Image(bgImg9ScaleTexture);
            bgImg.width = 300;
            bgImg.height = 50;
            view_title.addQuiackChild(bgImg);
            textField = new TextField(300,37,'','',24,0x6A3C00,false);
            textField.touchable = false;
            textField.y = 7;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'text';
            view_title.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_guanbi01_anniu');
            btn_close = new Button(texture);
            btn_close.name= 'btn_close';
            btn_close.x = 798;
            btn_close.y = 8;
            btn_close.width = 72;
            btn_close.height = 76;
            this.addQuiackChild(btn_close);
            view_rank = new BattleVideoRank();
            view_rank.x = -520;
            view_rank.y = 49;
            this.addQuiackChild(view_rank);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            pos1.dispose();
            pos4.dispose();
            pos7.dispose();
            pos8.dispose();
            pos5.dispose();
            pos2.dispose();
            pos3.dispose();
            pos6.dispose();
            pos9.dispose();
            view_list.dispose();
            figthView.dispose();
            view_title.dispose();
            btn_close.dispose();
            view_rank.dispose();
            super.dispose();
        
}
    }
}
