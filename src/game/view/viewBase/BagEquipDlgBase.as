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
    import feathers.controls.List;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;
    import com.components.Scale9Button;
    import com.dialog.TabDialog;

    public class BagEquipDlgBase extends TabDialog
    {
        public var ui_tanchukuangdi01_jiemian014:Scale9Image;
        public var btn_close:Button;
        public var bgImage0:Scale9Image;
        public var ui_zhuangshixianquan03_jiemian39888:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian412102:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian416149:Scale9Image;
        public var bgImage2:Scale9Image;
        public var bgImage3:Scale9Image;
        public var bgImage4:Scale9Image;
        public var bgImage1:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian424368:Scale9Image;
        public var list_eq:List;
        public var replace_Scale9Button:Scale9Button;
        public var icon:Image;
        public var quality:Image;
        public var title:TextField;
        public var useTitle:TextField;
        public var heroName:TextField;
        public var useleve:TextField;
        public var text_Item:TextField;
        public var defend:TextField;
        public var adddefendValue:TextField;
        public var adddefend:TextField;
        public var defendName:TextField;
        public var hit:TextField;
        public var addhitValue:TextField;
        public var addhit:TextField;
        public var hitName:TextField;
        public var crit:TextField;
        public var addcritValue:TextField;
        public var addcrit:TextField;
        public var critName:TextField;
        public var anitCrit:TextField;
        public var addanitCritValue:TextField;
        public var addanitCrit:TextField;
        public var anitCritName:TextField;
        public var dodgeName:TextField;
        public var puncture:TextField;
        public var addpunctureValue:TextField;
        public var addpuncture:TextField;
        public var punctureName:TextField;
        public var adddodgeValue:TextField;
        public var adddodge:TextField;
        public var dodge:TextField;
        public var critPercentage:TextField;
        public var addcritPercentageValue:TextField;
        public var addcritPercentage:TextField;
        public var critPercentageName:TextField;
        public var toughness:TextField;
        public var addtoughnessValue:TextField;
        public var addtoughness:TextField;
        public var toughnessName:TextField;
        public var attack:TextField;
        public var addattackValue:TextField;
        public var addattack:TextField;
        public var hp:TextField;
        public var addhpValue:TextField;
        public var addhp:TextField;
        public var icon_hero:Image;
        public var quality_hero:Image;

        public function BagEquipDlgBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tanchukuangdi01_jiemian');
            var ui_tanchukuangdi01_jiemian014Rect:Rectangle = new Rectangle(420,240,4,4);
            var ui_tanchukuangdi01_jiemian0149ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_tanchukuangdi01_jiemian014Rect);
            ui_tanchukuangdi01_jiemian014 = new Scale9Image(ui_tanchukuangdi01_jiemian0149ScaleTexture);
            ui_tanchukuangdi01_jiemian014.y = 14;
            ui_tanchukuangdi01_jiemian014.width = 856;
            ui_tanchukuangdi01_jiemian014.height = 580;
            this.addQuiackChild(ui_tanchukuangdi01_jiemian014);
            texture =assetMgr.getTexture('ui_taitoudi01_jiemian');
            image = new Image(texture);
            image.x = 68;
            image.y = 10;
            image.width = 720;
            image.height = 56;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_guanbi01_anniu');
            btn_close = new Button(texture);
            btn_close.name= 'btn_close';
            btn_close.x = 754;
            btn_close.width = 72;
            btn_close.height = 76;
            this.addQuiackChild(btn_close);
            texture =assetMgr.getTexture('ui_mingzidi01');
            image = new Image(texture);
            image.x = 202;
            image.y = 20;
            image.width = 452;
            image.height = 37;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage0Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage09ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage0Rect);
            bgImage0 = new Scale9Image(bgImage09ScaleTexture);
            bgImage0.x = 53;
            bgImage0.y = 92;
            bgImage0.width = 340;
            bgImage0.height = 437;
            this.addQuiackChild(bgImage0);
            texture = assetMgr.getTexture('ui_zhuangshixianquan03_jiemian');
            var ui_zhuangshixianquan03_jiemian39888Rect:Rectangle = new Rectangle(30,30,10,10);
            var ui_zhuangshixianquan03_jiemian398889ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan03_jiemian39888Rect);
            ui_zhuangshixianquan03_jiemian39888 = new Scale9Image(ui_zhuangshixianquan03_jiemian398889ScaleTexture);
            ui_zhuangshixianquan03_jiemian39888.x = 398;
            ui_zhuangshixianquan03_jiemian39888.y = 88;
            ui_zhuangshixianquan03_jiemian39888.width = 422;
            ui_zhuangshixianquan03_jiemian39888.height = 384;
            this.addQuiackChild(ui_zhuangshixianquan03_jiemian39888);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian412102Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian4121029ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian412102Rect);
            ui_zhuangshixianquan01_jiemian412102 = new Scale9Image(ui_zhuangshixianquan01_jiemian4121029ScaleTexture);
            ui_zhuangshixianquan01_jiemian412102.x = 412;
            ui_zhuangshixianquan01_jiemian412102.y = 102;
            ui_zhuangshixianquan01_jiemian412102.width = 394;
            ui_zhuangshixianquan01_jiemian412102.height = 356;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian412102);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian416149Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian4161499ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian416149Rect);
            ui_zhuangshixianquan02_jiemian416149 = new Scale9Image(ui_zhuangshixianquan02_jiemian4161499ScaleTexture);
            ui_zhuangshixianquan02_jiemian416149.x = 416;
            ui_zhuangshixianquan02_jiemian416149.y = 149;
            ui_zhuangshixianquan02_jiemian416149.width = 386;
            ui_zhuangshixianquan02_jiemian416149.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian416149);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage2Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage29ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage2Rect);
            bgImage2 = new Scale9Image(bgImage29ScaleTexture);
            bgImage2.x = 617;
            bgImage2.y = 157;
            bgImage2.width = 179;
            bgImage2.height = 30;
            this.addQuiackChild(bgImage2);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage3Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage39ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage3Rect);
            bgImage3 = new Scale9Image(bgImage39ScaleTexture);
            bgImage3.x = 617;
            bgImage3.y = 194;
            bgImage3.width = 179;
            bgImage3.height = 30;
            this.addQuiackChild(bgImage3);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage4Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage49ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage4Rect);
            bgImage4 = new Scale9Image(bgImage49ScaleTexture);
            bgImage4.x = 606;
            bgImage4.y = 231;
            bgImage4.width = 190;
            bgImage4.height = 218;
            this.addQuiackChild(bgImage4);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage1Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage19ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage1Rect);
            bgImage1 = new Scale9Image(bgImage19ScaleTexture);
            bgImage1.x = 424;
            bgImage1.y = 159;
            bgImage1.width = 170;
            bgImage1.height = 68;
            this.addQuiackChild(bgImage1);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian424368Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian4243689ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian424368Rect);
            ui_zhuangshixianquan02_jiemian424368 = new Scale9Image(ui_zhuangshixianquan02_jiemian4243689ScaleTexture);
            ui_zhuangshixianquan02_jiemian424368.x = 424;
            ui_zhuangshixianquan02_jiemian424368.y = 368;
            ui_zhuangshixianquan02_jiemian424368.width = 168;
            ui_zhuangshixianquan02_jiemian424368.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian424368);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 420;
            image.y = 105;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 797;
            image.y = 105;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 420;
            image.y = 455;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 797;
            image.y = 455;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 795;
            image.y = 111;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 423;
            image.y = 111;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 795;
            image.y = 448;
            image.width = 8;
            image.height = 33;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 423;
            image.y = 449;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangbei_taitou_wenzi');
            image = new Image(texture);
            image.x = 371;
            image.y = 20;
            image.width = 115;
            image.height = 37;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            list_eq = new List();
            list_eq.x = 64;
            list_eq.y = 101;
            list_eq.width = 318;
            list_eq.height = 419;
            this.addQuiackChild(list_eq);
            texture =assetMgr.getTexture('ui_gongji01_tubiao');
            image = new Image(texture);
            image.x = 601;
            image.y = 153;
            image.width = 38;
            image.height = 38;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_shengming01_tubiao');
            image = new Image(texture);
            image.x = 601;
            image.y = 191;
            image.width = 38;
            image.height = 38;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_lv03_01_anniu');
            var replace_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            replace_Scale9Button = new Scale9Button(texture,replace_Scale9ButtonRect);
            replace_Scale9Button.x = 516;
            replace_Scale9Button.y = 474;
            replace_Scale9Button.width = 186;
            replace_Scale9Button.height = 70;
            this.addQuiackChild(replace_Scale9Button);
            replace_Scale9Button.name = 'replace_Scale9Button';
            replace_Scale9Button.text= 'lable';
            replace_Scale9Button.fontColor= 0xFFFFFF;
            replace_Scale9Button.fontSize= 24;
            texture =assetMgr.getTexture('ui_daojukuangdi');
            image = new Image(texture);
            image.x = 461;
            image.y = 263;
            image.width = 98;
            image.height = 98;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('icon_101001')
            icon = new Image(texture);
            icon.x = 466;
            icon.y = 268;
            icon.width = 89;
            icon.height = 89;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            quality = new Image(texture);
            quality.x = 461;
            quality.y = 263;
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            title = new TextField(118,28,'','',21,0xFFFFFF,false);
            title.touchable = false;
            title.hAlign= 'center';
            title.text= '';
            title.x = 450;
            title.y = 158;
            this.addQuiackChild(title);
            useTitle = new TextField(65,28,'','',21,0xFFFFFF,false);
            useTitle.touchable = false;
            useTitle.hAlign= 'center';
            useTitle.text= '';
            useTitle.x = 415;
            useTitle.y = 376;
            this.addQuiackChild(useTitle);
            heroName = new TextField(118,28,'','',21,0xFF00FF,false);
            heroName.touchable = false;
            heroName.hAlign= 'center';
            heroName.text= '';
            heroName.x = 484;
            heroName.y = 376;
            this.addQuiackChild(heroName);
            useleve = new TextField(152,28,'','',21,0xFFFFFF,false);
            useleve.touchable = false;
            useleve.hAlign= 'center';
            useleve.text= '';
            useleve.x = 433;
            useleve.y = 230;
            this.addQuiackChild(useleve);
            text_Item = new TextField(271,32,'','',24,0xFF00FF,false);
            text_Item.touchable = false;
            text_Item.hAlign= 'center';
            text_Item.text= '';
            text_Item.x = 478;
            text_Item.y = 113;
            this.addQuiackChild(text_Item);
            defend = new TextField(80,26,'','',18,0xFFFFFF,false);
            defend.touchable = false;
            defend.hAlign= 'center';
            defend.text= '';
            defend.x = 655;
            defend.y = 233;
            this.addQuiackChild(defend);
            adddefendValue = new TextField(60,26,'','',18,0x00FF00,false);
            adddefendValue.touchable = false;
            adddefendValue.hAlign= 'center';
            adddefendValue.text= '';
            adddefendValue.x = 744;
            adddefendValue.y = 233;
            this.addQuiackChild(adddefendValue);
            adddefend = new TextField(20,26,'','',18,0x00FF00,false);
            adddefend.touchable = false;
            adddefend.hAlign= 'center';
            adddefend.text= '';
            adddefend.x = 728;
            adddefend.y = 233;
            this.addQuiackChild(adddefend);
            defendName = new TextField(60,24,'','',18,0xFFCC99,false);
            defendName.touchable = false;
            defendName.hAlign= 'center';
            defendName.text= '';
            defendName.x = 606;
            defendName.y = 233;
            this.addQuiackChild(defendName);
            hit = new TextField(80,26,'','',18,0xFFFFFF,false);
            hit.touchable = false;
            hit.hAlign= 'center';
            hit.text= '';
            hit.x = 655;
            hit.y = 259;
            this.addQuiackChild(hit);
            addhitValue = new TextField(60,26,'','',18,0x00FF00,false);
            addhitValue.touchable = false;
            addhitValue.hAlign= 'center';
            addhitValue.text= '';
            addhitValue.x = 744;
            addhitValue.y = 259;
            this.addQuiackChild(addhitValue);
            addhit = new TextField(20,26,'','',18,0x00FF00,false);
            addhit.touchable = false;
            addhit.hAlign= 'center';
            addhit.text= '';
            addhit.x = 728;
            addhit.y = 259;
            this.addQuiackChild(addhit);
            hitName = new TextField(60,26,'','',18,0xFFCC99,false);
            hitName.touchable = false;
            hitName.hAlign= 'center';
            hitName.text= '';
            hitName.x = 606;
            hitName.y = 259;
            this.addQuiackChild(hitName);
            crit = new TextField(80,26,'','',18,0xFFFFFF,false);
            crit.touchable = false;
            crit.hAlign= 'center';
            crit.text= '';
            crit.x = 655;
            crit.y = 285;
            this.addQuiackChild(crit);
            addcritValue = new TextField(60,26,'','',18,0x00FF00,false);
            addcritValue.touchable = false;
            addcritValue.hAlign= 'center';
            addcritValue.text= '';
            addcritValue.x = 744;
            addcritValue.y = 285;
            this.addQuiackChild(addcritValue);
            addcrit = new TextField(20,26,'','',18,0x00FF00,false);
            addcrit.touchable = false;
            addcrit.hAlign= 'center';
            addcrit.text= '';
            addcrit.x = 728;
            addcrit.y = 285;
            this.addQuiackChild(addcrit);
            critName = new TextField(60,26,'','',18,0xFFCC99,false);
            critName.touchable = false;
            critName.hAlign= 'center';
            critName.text= '';
            critName.x = 606;
            critName.y = 285;
            this.addQuiackChild(critName);
            anitCrit = new TextField(80,26,'','',18,0xFFFFFF,false);
            anitCrit.touchable = false;
            anitCrit.hAlign= 'center';
            anitCrit.text= '';
            anitCrit.x = 655;
            anitCrit.y = 311;
            this.addQuiackChild(anitCrit);
            addanitCritValue = new TextField(60,26,'','',18,0x00FF00,false);
            addanitCritValue.touchable = false;
            addanitCritValue.hAlign= 'center';
            addanitCritValue.text= '';
            addanitCritValue.x = 744;
            addanitCritValue.y = 311;
            this.addQuiackChild(addanitCritValue);
            addanitCrit = new TextField(20,26,'','',18,0x00FF00,false);
            addanitCrit.touchable = false;
            addanitCrit.hAlign= 'center';
            addanitCrit.text= '';
            addanitCrit.x = 728;
            addanitCrit.y = 311;
            this.addQuiackChild(addanitCrit);
            anitCritName = new TextField(60,26,'','',18,0xFFCC99,false);
            anitCritName.touchable = false;
            anitCritName.hAlign= 'center';
            anitCritName.text= '';
            anitCritName.x = 606;
            anitCritName.y = 311;
            this.addQuiackChild(anitCritName);
            dodgeName = new TextField(60,26,'','',18,0xFFCC99,false);
            dodgeName.touchable = false;
            dodgeName.hAlign= 'center';
            dodgeName.text= '';
            dodgeName.x = 606;
            dodgeName.y = 364;
            this.addQuiackChild(dodgeName);
            puncture = new TextField(80,26,'','',18,0xFFFFFF,false);
            puncture.touchable = false;
            puncture.hAlign= 'center';
            puncture.text= '';
            puncture.x = 655;
            puncture.y = 337;
            this.addQuiackChild(puncture);
            addpunctureValue = new TextField(60,26,'','',18,0x00FF00,false);
            addpunctureValue.touchable = false;
            addpunctureValue.hAlign= 'center';
            addpunctureValue.text= '';
            addpunctureValue.x = 744;
            addpunctureValue.y = 337;
            this.addQuiackChild(addpunctureValue);
            addpuncture = new TextField(20,26,'','',18,0x00FF00,false);
            addpuncture.touchable = false;
            addpuncture.hAlign= 'center';
            addpuncture.text= '';
            addpuncture.x = 728;
            addpuncture.y = 337;
            this.addQuiackChild(addpuncture);
            punctureName = new TextField(60,26,'','',18,0xFFCC99,false);
            punctureName.touchable = false;
            punctureName.hAlign= 'center';
            punctureName.text= '';
            punctureName.x = 606;
            punctureName.y = 337;
            this.addQuiackChild(punctureName);
            adddodgeValue = new TextField(60,26,'','',18,0x00FF00,false);
            adddodgeValue.touchable = false;
            adddodgeValue.hAlign= 'center';
            adddodgeValue.text= '';
            adddodgeValue.x = 744;
            adddodgeValue.y = 364;
            this.addQuiackChild(adddodgeValue);
            adddodge = new TextField(20,26,'','',18,0x00FF00,false);
            adddodge.touchable = false;
            adddodge.hAlign= 'center';
            adddodge.text= '';
            adddodge.x = 728;
            adddodge.y = 364;
            this.addQuiackChild(adddodge);
            dodge = new TextField(80,26,'','',18,0xFFFFFF,false);
            dodge.touchable = false;
            dodge.hAlign= 'center';
            dodge.text= '';
            dodge.x = 655;
            dodge.y = 364;
            this.addQuiackChild(dodge);
            critPercentage = new TextField(80,26,'','',18,0xFFFFFF,false);
            critPercentage.touchable = false;
            critPercentage.hAlign= 'center';
            critPercentage.text= '';
            critPercentage.x = 655;
            critPercentage.y = 392;
            this.addQuiackChild(critPercentage);
            addcritPercentageValue = new TextField(60,26,'','',18,0x00FF00,false);
            addcritPercentageValue.touchable = false;
            addcritPercentageValue.hAlign= 'center';
            addcritPercentageValue.text= '';
            addcritPercentageValue.x = 744;
            addcritPercentageValue.y = 392;
            this.addQuiackChild(addcritPercentageValue);
            addcritPercentage = new TextField(20,26,'','',18,0x00FF00,false);
            addcritPercentage.touchable = false;
            addcritPercentage.hAlign= 'center';
            addcritPercentage.text= '';
            addcritPercentage.x = 728;
            addcritPercentage.y = 392;
            this.addQuiackChild(addcritPercentage);
            critPercentageName = new TextField(60,26,'','',18,0xFFCC99,false);
            critPercentageName.touchable = false;
            critPercentageName.hAlign= 'center';
            critPercentageName.text= '';
            critPercentageName.x = 606;
            critPercentageName.y = 392;
            this.addQuiackChild(critPercentageName);
            toughness = new TextField(80,26,'','',18,0xFFFFFF,false);
            toughness.touchable = false;
            toughness.hAlign= 'center';
            toughness.text= '';
            toughness.x = 656;
            toughness.y = 419;
            this.addQuiackChild(toughness);
            addtoughnessValue = new TextField(60,26,'','',18,0x00FF00,false);
            addtoughnessValue.touchable = false;
            addtoughnessValue.hAlign= 'center';
            addtoughnessValue.text= '';
            addtoughnessValue.x = 745;
            addtoughnessValue.y = 419;
            this.addQuiackChild(addtoughnessValue);
            addtoughness = new TextField(20,26,'','',18,0x00FF00,false);
            addtoughness.touchable = false;
            addtoughness.hAlign= 'center';
            addtoughness.text= '';
            addtoughness.x = 728;
            addtoughness.y = 419;
            this.addQuiackChild(addtoughness);
            toughnessName = new TextField(60,26,'','',18,0xFFCC99,false);
            toughnessName.touchable = false;
            toughnessName.hAlign= 'center';
            toughnessName.text= '';
            toughnessName.x = 606;
            toughnessName.y = 419;
            this.addQuiackChild(toughnessName);
            attack = new TextField(72,26,'','',18,0xFFFFFF,false);
            attack.touchable = false;
            attack.hAlign= 'center';
            attack.text= '';
            attack.x = 638;
            attack.y = 159;
            this.addQuiackChild(attack);
            addattackValue = new TextField(72,26,'','',18,0x00FF00,false);
            addattackValue.touchable = false;
            addattackValue.hAlign= 'center';
            addattackValue.text= '';
            addattackValue.x = 722;
            addattackValue.y = 159;
            this.addQuiackChild(addattackValue);
            addattack = new TextField(20,26,'','',18,0x00FF00,false);
            addattack.touchable = false;
            addattack.hAlign= 'center';
            addattack.text= '';
            addattack.x = 712;
            addattack.y = 159;
            this.addQuiackChild(addattack);
            hp = new TextField(72,26,'','',18,0xFFFFFF,false);
            hp.touchable = false;
            hp.hAlign= 'center';
            hp.text= '';
            hp.x = 638;
            hp.y = 196;
            this.addQuiackChild(hp);
            addhpValue = new TextField(72,26,'','',18,0x00FF00,false);
            addhpValue.touchable = false;
            addhpValue.hAlign= 'center';
            addhpValue.text= '';
            addhpValue.x = 722;
            addhpValue.y = 196;
            this.addQuiackChild(addhpValue);
            addhp = new TextField(20,26,'','',18,0x00FF00,false);
            addhp.touchable = false;
            addhp.hAlign= 'center';
            addhp.text= '';
            addhp.x = 712;
            addhp.y = 196;
            this.addQuiackChild(addhp);
            texture =assetMgr.getTexture('ui_daojukuangdi');
            image = new Image(texture);
            image.x = 486;
            image.y = 408;
            image.width = 45;
            image.height = 45;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('photo_501')
            icon_hero = new Image(texture);
            icon_hero.x = 486;
            icon_hero.y = 408;
            icon_hero.width = 45;
            icon_hero.height = 45;
            this.addQuiackChild(icon_hero);
            icon_hero.touchable = false;
            texture = assetMgr.getTexture('ui_touxiangkuang_01')
            quality_hero = new Image(texture);
            quality_hero.x = 486;
            quality_hero.y = 408;
            quality_hero.width = 45;
            quality_hero.height = 45;
            this.addQuiackChild(quality_hero);
            quality_hero.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_close.dispose();
            list_eq.dispose();
            super.dispose();
        
}
    }
}
