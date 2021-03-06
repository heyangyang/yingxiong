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
    import com.view.View;

    public class AdvanceViewBase extends View
    {
        public var advanceBtn_Scale9Button:Scale9Button;
        public var gold:Image;
        public var ui_zhuangshixianquan03_jiemian18181:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian19494:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian201216:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian201215:Scale9Image;
        public var bg_but:Button;
        public var icon:Image;
        public var quality:Image;
        public var advanceNum:TextField;
        public var advanceGlod:TextField;
        public var advanceNumTitle:TextField;
        public var advanceGlodTitle:TextField;
        public var maxTis2:TextField;
        public var hero_name0:TextField;
        public var hero_jie0:TextField;
        public var hero_name1:TextField;
        public var hero_jie1:TextField;
        public var lock:Image;
        public var ui_zhuangshixianquan02_jiemian160272:Scale9Image;
        public var bgImage0:Scale9Image;
        public var bgImage1:Scale9Image;
        public var bgImage2:Scale9Image;
        public var attackValue:TextField;
        public var attackAddValue:TextField;
        public var add_0:TextField;
        public var hpValue:TextField;
        public var hpAddValue:TextField;
        public var add_1:TextField;
        public var defendValue:TextField;
        public var defendAddValue:TextField;
        public var add_2:TextField;
        public var defend:TextField;
        public var hitValue:TextField;
        public var hitAddValue:TextField;
        public var add_3:TextField;
        public var hit:TextField;
        public var critValue:TextField;
        public var critAddValue:TextField;
        public var add_4:TextField;
        public var crit:TextField;
        public var anitCritValue:TextField;
        public var anitCritAddValue:TextField;
        public var add_5:TextField;
        public var anitCrit:TextField;
        public var punctureValue:TextField;
        public var punctureAddValue:TextField;
        public var add_6:TextField;
        public var puncture:TextField;
        public var dodgeValue:TextField;
        public var dodgeAddValue:TextField;
        public var add_7:TextField;
        public var dodge:TextField;
        public var critPercentageValue:TextField;
        public var critPercentageAddValue:TextField;
        public var add_8:TextField;
        public var critPercentage:TextField;
        public var toughnessValue:TextField;
        public var toughnessAddValue:TextField;
        public var add_9:TextField;
        public var toughness:TextField;

        public function AdvanceViewBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture =assetMgr.getTexture('ui_yingxiongjinjie_taitou_wenzi');
            image = new Image(texture);
            image.x = 483;
            image.y = 20;
            image.width = 115;
            image.height = 37;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            var advanceBtn_Scale9ButtonRect:Rectangle = new Rectangle(56,24,4,2);
            advanceBtn_Scale9Button = new Scale9Button(texture,advanceBtn_Scale9ButtonRect);
            advanceBtn_Scale9Button.x = 770;
            advanceBtn_Scale9Button.y = 129;
            advanceBtn_Scale9Button.width = 125;
            advanceBtn_Scale9Button.height = 70;
            this.addQuiackChild(advanceBtn_Scale9Button);
            advanceBtn_Scale9Button.name = 'advanceBtn_Scale9Button';
            advanceBtn_Scale9Button.text= 'lable';
            advanceBtn_Scale9Button.fontColor= 0xFFFFFF;
            advanceBtn_Scale9Button.fontSize= 24;
            texture = assetMgr.getTexture('ui_jinbi01_tubiao')
            gold = new Image(texture);
            gold.x = 898;
            gold.y = 208;
            gold.width = 25;
            gold.height = 26;
            this.addQuiackChild(gold);
            gold.touchable = false;
            texture = assetMgr.getTexture('ui_zhuangshixianquan03_jiemian');
            var ui_zhuangshixianquan03_jiemian18181Rect:Rectangle = new Rectangle(30,30,10,10);
            var ui_zhuangshixianquan03_jiemian181819ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan03_jiemian18181Rect);
            ui_zhuangshixianquan03_jiemian18181 = new Scale9Image(ui_zhuangshixianquan03_jiemian181819ScaleTexture);
            ui_zhuangshixianquan03_jiemian18181.x = 181;
            ui_zhuangshixianquan03_jiemian18181.y = 81;
            ui_zhuangshixianquan03_jiemian18181.width = 410;
            ui_zhuangshixianquan03_jiemian18181.height = 190;
            this.addQuiackChild(ui_zhuangshixianquan03_jiemian18181);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian19494Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian194949ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian19494Rect);
            ui_zhuangshixianquan01_jiemian19494 = new Scale9Image(ui_zhuangshixianquan01_jiemian194949ScaleTexture);
            ui_zhuangshixianquan01_jiemian19494.x = 194;
            ui_zhuangshixianquan01_jiemian19494.y = 94;
            ui_zhuangshixianquan01_jiemian19494.width = 384;
            ui_zhuangshixianquan01_jiemian19494.height = 164;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian19494);
            texture =assetMgr.getTexture('ui_zhishijiantou01_tubiao');
            image = new Image(texture);
            image.x = 356;
            image.y = 130;
            image.width = 61;
            image.height = 53;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 203;
            image.y = 97;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 569;
            image.y = 97;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 203;
            image.y = 255;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 569;
            image.y = 255;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian201216Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian2012169ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian201216Rect);
            ui_zhuangshixianquan02_jiemian201216 = new Scale9Image(ui_zhuangshixianquan02_jiemian2012169ScaleTexture);
            ui_zhuangshixianquan02_jiemian201216.x = 201;
            ui_zhuangshixianquan02_jiemian201216.y = 216;
            ui_zhuangshixianquan02_jiemian201216.width = 373;
            ui_zhuangshixianquan02_jiemian201216.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian201216);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian201215Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian2012159ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian201215Rect);
            ui_zhuangshixianquan02_jiemian201215 = new Scale9Image(ui_zhuangshixianquan02_jiemian2012159ScaleTexture);
            ui_zhuangshixianquan02_jiemian201215.x = 201;
            ui_zhuangshixianquan02_jiemian201215.y = 215;
            ui_zhuangshixianquan02_jiemian201215.width = 373;
            ui_zhuangshixianquan02_jiemian201215.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian201215);
            texture = assetMgr.getTexture('ui_daojukuangdi');
            bg_but = new Button(texture);
            bg_but.name= 'bg_but';
            bg_but.x = 642;
            bg_but.y = 129;
            bg_but.width = 98;
            bg_but.height = 98;
            this.addQuiackChild(bg_but);
            texture = assetMgr.getTexture('icon_20001')
            icon = new Image(texture);
            icon.x = 647;
            icon.y = 134;
            icon.width = 89;
            icon.height = 89;
            this.addQuiackChild(icon);
            icon.touchable = false;
            texture = assetMgr.getTexture('ui_daojukuang01')
            quality = new Image(texture);
            quality.x = 642;
            quality.y = 129;
            quality.width = 98;
            quality.height = 98;
            this.addQuiackChild(quality);
            quality.touchable = false;
            advanceNum = new TextField(112,31,'','',24,0x00FF00,false);
            advanceNum.touchable = false;
            advanceNum.hAlign= 'center';
            advanceNum.text= '';
            advanceNum.x = 634;
            advanceNum.y = 227;
            this.addQuiackChild(advanceNum);
            advanceGlod = new TextField(89,31,'','',24,0x00FF00,false);
            advanceGlod.touchable = false;
            advanceGlod.hAlign= 'center';
            advanceGlod.text= '';
            advanceGlod.x = 814;
            advanceGlod.y = 208;
            this.addQuiackChild(advanceGlod);
            advanceNumTitle = new TextField(109,27,'','',18,0xFFFFFF,false);
            advanceNumTitle.touchable = false;
            advanceNumTitle.hAlign= 'center';
            advanceNumTitle.text= '';
            advanceNumTitle.x = 634;
            advanceNumTitle.y = 99;
            this.addQuiackChild(advanceNumTitle);
            advanceGlodTitle = new TextField(50,31,'','',18,0xFFFFFF,false);
            advanceGlodTitle.touchable = false;
            advanceGlodTitle.hAlign= 'center';
            advanceGlodTitle.text= '';
            advanceGlodTitle.x = 769;
            advanceGlodTitle.y = 208;
            this.addQuiackChild(advanceGlodTitle);
            maxTis2 = new TextField(279,81,'','',30,0xFFFFFF,false);
            maxTis2.touchable = false;
            maxTis2.hAlign= 'center';
            maxTis2.text= '';
            maxTis2.x = 634;
            maxTis2.y = 138;
            this.addQuiackChild(maxTis2);
            hero_name0 = new TextField(110,28,'','',21,0xFFFFFF,false);
            hero_name0.touchable = false;
            hero_name0.hAlign= 'center';
            hero_name0.text= '';
            hero_name0.x = 213;
            hero_name0.y = 221;
            this.addQuiackChild(hero_name0);
            hero_jie0 = new TextField(35,31,'','',24,0x00FF00,false);
            hero_jie0.touchable = false;
            hero_jie0.hAlign= 'left';
            hero_jie0.text= '';
            hero_jie0.x = 324;
            hero_jie0.y = 220;
            this.addQuiackChild(hero_jie0);
            hero_name1 = new TextField(110,28,'','',21,0xFFFFFF,false);
            hero_name1.touchable = false;
            hero_name1.hAlign= 'center';
            hero_name1.text= '';
            hero_name1.x = 427;
            hero_name1.y = 221;
            this.addQuiackChild(hero_name1);
            hero_jie1 = new TextField(35,31,'','',24,0x00FF00,false);
            hero_jie1.touchable = false;
            hero_jie1.hAlign= 'left';
            hero_jie1.text= '';
            hero_jie1.x = 537;
            hero_jie1.y = 220;
            this.addQuiackChild(hero_jie1);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 567;
            image.y = 102;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 205;
            image.y = 102;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 567;
            image.y = 247;
            image.width = 8;
            image.height = 33;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 205;
            image.y = 247;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_world_nandusuo')
            lock = new Image(texture);
            lock.x = 452;
            lock.y = 128;
            lock.width = 59;
            lock.height = 67;
            this.addQuiackChild(lock);
            lock.touchable = false;
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian160272Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian1602729ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian160272Rect);
            ui_zhuangshixianquan02_jiemian160272 = new Scale9Image(ui_zhuangshixianquan02_jiemian1602729ScaleTexture);
            ui_zhuangshixianquan02_jiemian160272.x = 160;
            ui_zhuangshixianquan02_jiemian160272.y = 272;
            ui_zhuangshixianquan02_jiemian160272.width = 772;
            ui_zhuangshixianquan02_jiemian160272.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian160272);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage0Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage09ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage0Rect);
            bgImage0 = new Scale9Image(bgImage09ScaleTexture);
            bgImage0.x = 203;
            bgImage0.y = 312;
            bgImage0.width = 220;
            bgImage0.height = 34;
            this.addQuiackChild(bgImage0);
            texture =assetMgr.getTexture('ui_gongji01_tubiao');
            image = new Image(texture);
            image.x = 187;
            image.y = 309;
            image.width = 38;
            image.height = 38;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage1Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage19ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage1Rect);
            bgImage1 = new Scale9Image(bgImage19ScaleTexture);
            bgImage1.x = 203;
            bgImage1.y = 358;
            bgImage1.width = 220;
            bgImage1.height = 34;
            this.addQuiackChild(bgImage1);
            texture =assetMgr.getTexture('ui_shengming01_tubiao');
            image = new Image(texture);
            image.x = 187;
            image.y = 357;
            image.width = 38;
            image.height = 38;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage2Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage29ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage2Rect);
            bgImage2 = new Scale9Image(bgImage29ScaleTexture);
            bgImage2.x = 434;
            bgImage2.y = 283;
            bgImage2.width = 491;
            bgImage2.height = 135;
            this.addQuiackChild(bgImage2);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 168;
            image.y = 278;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 925;
            image.y = 278;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 168;
            image.y = 423;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 925;
            image.y = 423;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            attackValue = new TextField(90,32,'','',24,0xFFFFFF,false);
            attackValue.touchable = false;
            attackValue.hAlign= 'center';
            attackValue.text= '';
            attackValue.x = 220;
            attackValue.y = 313;
            this.addQuiackChild(attackValue);
            attackAddValue = new TextField(90,32,'','',24,0x00FF00,false);
            attackAddValue.touchable = false;
            attackAddValue.hAlign= 'center';
            attackAddValue.text= '';
            attackAddValue.x = 328;
            attackAddValue.y = 313;
            this.addQuiackChild(attackAddValue);
            add_0 = new TextField(20,32,'','',24,0x00FF00,false);
            add_0.touchable = false;
            add_0.hAlign= 'center';
            add_0.text= '+';
            add_0.x = 309;
            add_0.y = 313;
            this.addQuiackChild(add_0);
            hpValue = new TextField(90,32,'','',24,0xFFFFFF,false);
            hpValue.touchable = false;
            hpValue.hAlign= 'center';
            hpValue.text= '';
            hpValue.x = 220;
            hpValue.y = 359;
            this.addQuiackChild(hpValue);
            hpAddValue = new TextField(90,32,'','',24,0x00FF00,false);
            hpAddValue.touchable = false;
            hpAddValue.hAlign= 'center';
            hpAddValue.text= '';
            hpAddValue.x = 328;
            hpAddValue.y = 359;
            this.addQuiackChild(hpAddValue);
            add_1 = new TextField(20,32,'','',24,0x00FF00,false);
            add_1.touchable = false;
            add_1.hAlign= 'center';
            add_1.text= '+';
            add_1.x = 309;
            add_1.y = 359;
            this.addQuiackChild(add_1);
            defendValue = new TextField(60,32,'','',24,0xFFFFFF,false);
            defendValue.touchable = false;
            defendValue.hAlign= 'center';
            defendValue.text= '';
            defendValue.x = 531;
            defendValue.y = 290;
            this.addQuiackChild(defendValue);
            defendAddValue = new TextField(60,32,'','',24,0x00FF00,false);
            defendAddValue.touchable = false;
            defendAddValue.hAlign= 'center';
            defendAddValue.text= '';
            defendAddValue.x = 615;
            defendAddValue.y = 290;
            this.addQuiackChild(defendAddValue);
            add_2 = new TextField(20,31,'','',24,0x00FF00,false);
            add_2.touchable = false;
            add_2.hAlign= 'center';
            add_2.text= '+';
            add_2.x = 593;
            add_2.y = 290;
            this.addQuiackChild(add_2);
            defend = new TextField(80,32,'','',24,0xFFCC99,false);
            defend.touchable = false;
            defend.hAlign= 'center';
            defend.text= '';
            defend.x = 449;
            defend.y = 290;
            this.addQuiackChild(defend);
            hitValue = new TextField(60,31,'','',24,0xFFFFFF,false);
            hitValue.touchable = false;
            hitValue.hAlign= 'center';
            hitValue.text= '';
            hitValue.x = 531;
            hitValue.y = 319;
            this.addQuiackChild(hitValue);
            hitAddValue = new TextField(60,32,'','',24,0x00FF00,false);
            hitAddValue.touchable = false;
            hitAddValue.hAlign= 'center';
            hitAddValue.text= '';
            hitAddValue.x = 615;
            hitAddValue.y = 319;
            this.addQuiackChild(hitAddValue);
            add_3 = new TextField(20,31,'','',24,0x00FF00,false);
            add_3.touchable = false;
            add_3.hAlign= 'center';
            add_3.text= '+';
            add_3.x = 593;
            add_3.y = 319;
            this.addQuiackChild(add_3);
            hit = new TextField(80,32,'','',24,0xFFCC99,false);
            hit.touchable = false;
            hit.hAlign= 'center';
            hit.text= '';
            hit.x = 449;
            hit.y = 319;
            this.addQuiackChild(hit);
            critValue = new TextField(60,31,'','',24,0xFFFFFF,false);
            critValue.touchable = false;
            critValue.hAlign= 'center';
            critValue.text= '';
            critValue.x = 531;
            critValue.y = 348;
            this.addQuiackChild(critValue);
            critAddValue = new TextField(60,32,'','',24,0x00FF00,false);
            critAddValue.touchable = false;
            critAddValue.hAlign= 'center';
            critAddValue.text= '';
            critAddValue.x = 615;
            critAddValue.y = 348;
            this.addQuiackChild(critAddValue);
            add_4 = new TextField(20,31,'','',24,0x00FF00,false);
            add_4.touchable = false;
            add_4.hAlign= 'center';
            add_4.text= '+';
            add_4.x = 593;
            add_4.y = 348;
            this.addQuiackChild(add_4);
            crit = new TextField(80,32,'','',24,0xFFCC99,false);
            crit.touchable = false;
            crit.hAlign= 'center';
            crit.text= '';
            crit.x = 449;
            crit.y = 348;
            this.addQuiackChild(crit);
            anitCritValue = new TextField(60,31,'','',24,0xFFFFFF,false);
            anitCritValue.touchable = false;
            anitCritValue.hAlign= 'center';
            anitCritValue.text= '';
            anitCritValue.x = 531;
            anitCritValue.y = 377;
            this.addQuiackChild(anitCritValue);
            anitCritAddValue = new TextField(60,32,'','',24,0x00FF00,false);
            anitCritAddValue.touchable = false;
            anitCritAddValue.hAlign= 'center';
            anitCritAddValue.text= '';
            anitCritAddValue.x = 615;
            anitCritAddValue.y = 377;
            this.addQuiackChild(anitCritAddValue);
            add_5 = new TextField(20,31,'','',24,0x00FF00,false);
            add_5.touchable = false;
            add_5.hAlign= 'center';
            add_5.text= '+';
            add_5.x = 593;
            add_5.y = 377;
            this.addQuiackChild(add_5);
            anitCrit = new TextField(80,32,'','',24,0xFFCC99,false);
            anitCrit.touchable = false;
            anitCrit.hAlign= 'center';
            anitCrit.text= '';
            anitCrit.x = 449;
            anitCrit.y = 377;
            this.addQuiackChild(anitCrit);
            punctureValue = new TextField(60,32,'','',24,0xFFFFFF,false);
            punctureValue.touchable = false;
            punctureValue.hAlign= 'center';
            punctureValue.text= '';
            punctureValue.x = 762;
            punctureValue.y = 290;
            this.addQuiackChild(punctureValue);
            punctureAddValue = new TextField(60,32,'','',24,0x00FF00,false);
            punctureAddValue.touchable = false;
            punctureAddValue.hAlign= 'center';
            punctureAddValue.text= '';
            punctureAddValue.x = 846;
            punctureAddValue.y = 290;
            this.addQuiackChild(punctureAddValue);
            add_6 = new TextField(20,31,'','',24,0x00FF00,false);
            add_6.touchable = false;
            add_6.hAlign= 'center';
            add_6.text= '+';
            add_6.x = 824;
            add_6.y = 290;
            this.addQuiackChild(add_6);
            puncture = new TextField(80,32,'','',24,0xFFCC99,false);
            puncture.touchable = false;
            puncture.hAlign= 'center';
            puncture.text= '';
            puncture.x = 680;
            puncture.y = 290;
            this.addQuiackChild(puncture);
            dodgeValue = new TextField(60,32,'','',24,0xFFFFFF,false);
            dodgeValue.touchable = false;
            dodgeValue.hAlign= 'center';
            dodgeValue.text= '';
            dodgeValue.x = 762;
            dodgeValue.y = 319;
            this.addQuiackChild(dodgeValue);
            dodgeAddValue = new TextField(60,32,'','',24,0x00FF00,false);
            dodgeAddValue.touchable = false;
            dodgeAddValue.hAlign= 'center';
            dodgeAddValue.text= '';
            dodgeAddValue.x = 846;
            dodgeAddValue.y = 319;
            this.addQuiackChild(dodgeAddValue);
            add_7 = new TextField(20,31,'','',24,0x00FF00,false);
            add_7.touchable = false;
            add_7.hAlign= 'center';
            add_7.text= '+';
            add_7.x = 824;
            add_7.y = 319;
            this.addQuiackChild(add_7);
            dodge = new TextField(80,32,'','',24,0xFFCC99,false);
            dodge.touchable = false;
            dodge.hAlign= 'center';
            dodge.text= '';
            dodge.x = 680;
            dodge.y = 319;
            this.addQuiackChild(dodge);
            critPercentageValue = new TextField(60,32,'','',24,0xFFFFFF,false);
            critPercentageValue.touchable = false;
            critPercentageValue.hAlign= 'center';
            critPercentageValue.text= '';
            critPercentageValue.x = 762;
            critPercentageValue.y = 348;
            this.addQuiackChild(critPercentageValue);
            critPercentageAddValue = new TextField(60,32,'','',24,0x00FF00,false);
            critPercentageAddValue.touchable = false;
            critPercentageAddValue.hAlign= 'center';
            critPercentageAddValue.text= '';
            critPercentageAddValue.x = 846;
            critPercentageAddValue.y = 348;
            this.addQuiackChild(critPercentageAddValue);
            add_8 = new TextField(20,31,'','',24,0x00FF00,false);
            add_8.touchable = false;
            add_8.hAlign= 'center';
            add_8.text= '+';
            add_8.x = 824;
            add_8.y = 348;
            this.addQuiackChild(add_8);
            critPercentage = new TextField(80,32,'','',24,0xFFCC99,false);
            critPercentage.touchable = false;
            critPercentage.hAlign= 'center';
            critPercentage.text= '';
            critPercentage.x = 680;
            critPercentage.y = 348;
            this.addQuiackChild(critPercentage);
            toughnessValue = new TextField(60,32,'','',24,0xFFFFFF,false);
            toughnessValue.touchable = false;
            toughnessValue.hAlign= 'center';
            toughnessValue.text= '';
            toughnessValue.x = 762;
            toughnessValue.y = 377;
            this.addQuiackChild(toughnessValue);
            toughnessAddValue = new TextField(60,32,'','',24,0x00FF00,false);
            toughnessAddValue.touchable = false;
            toughnessAddValue.hAlign= 'center';
            toughnessAddValue.text= '';
            toughnessAddValue.x = 846;
            toughnessAddValue.y = 377;
            this.addQuiackChild(toughnessAddValue);
            add_9 = new TextField(20,31,'','',24,0x00FF00,false);
            add_9.touchable = false;
            add_9.hAlign= 'center';
            add_9.text= '+';
            add_9.x = 824;
            add_9.y = 377;
            this.addQuiackChild(add_9);
            toughness = new TextField(80,32,'','',24,0xFFCC99,false);
            toughness.touchable = false;
            toughness.hAlign= 'center';
            toughness.text= '';
            toughness.x = 680;
            toughness.y = 377;
            this.addQuiackChild(toughness);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 922;
            image.y = 284;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 170;
            image.y = 284;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 922;
            image.y = 416;
            image.width = 8;
            image.height = 33;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 170;
            image.y = 416;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            bg_but.dispose();
            super.dispose();
        
}
    }
}
