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
    import com.dialog.Dialog;

    public class HeroInfoDialogBase extends Dialog
    {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian4165:Scale9Image;
        public var ui_zhuangshixianquan03_jiemian4886:Scale9Image;
        public var bgImage2:Scale9Image;
        public var bgImage0:Scale9Image;
        public var bgImage1:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian41172:Scale9Image;
        public var joy:Image;
        public var ui_zhuangshixianquan02_jiemian41410:Scale9Image;
        public var heroBreak_Scale9Button:Scale9Button;
        public var skillDes:TextField;
        public var text_expert:TextField;
        public var text_HabitWeapon:TextField;
        public var text_HabitWeaponValue:TextField;
        public var text_expertValue:TextField;
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
        public var attackValue:TextField;
        public var attackAddValue:TextField;
        public var add_0:TextField;
        public var hpValue:TextField;
        public var hpAddValue:TextField;
        public var add_1:TextField;

        public function HeroInfoDialogBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var ui_tipstanchukuangdi01_jiemian00Rect:Rectangle = new Rectangle(68,64,6,6);
            var ui_tipstanchukuangdi01_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_tipstanchukuangdi01_jiemian00Rect);
            ui_tipstanchukuangdi01_jiemian00 = new Scale9Image(ui_tipstanchukuangdi01_jiemian009ScaleTexture);
            ui_tipstanchukuangdi01_jiemian00.width = 660;
            ui_tipstanchukuangdi01_jiemian00.height = 540;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 46;
            image.y = 35;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 616;
            image.y = 35;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_yingxiongjianjie_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 269;
            image.y = 37;
            image.width = 102;
            image.height = 31;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian4165Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian41659ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian4165Rect);
            ui_zhuangshixianquan02_jiemian4165 = new Scale9Image(ui_zhuangshixianquan02_jiemian41659ScaleTexture);
            ui_zhuangshixianquan02_jiemian4165.x = 41;
            ui_zhuangshixianquan02_jiemian4165.y = 65;
            ui_zhuangshixianquan02_jiemian4165.width = 580;
            ui_zhuangshixianquan02_jiemian4165.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian4165);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 268;
            image.y = 65;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 368;
            image.y = 65;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan03_jiemian');
            var ui_zhuangshixianquan03_jiemian4886Rect:Rectangle = new Rectangle(30,30,10,10);
            var ui_zhuangshixianquan03_jiemian48869ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan03_jiemian4886Rect);
            ui_zhuangshixianquan03_jiemian4886 = new Scale9Image(ui_zhuangshixianquan03_jiemian48869ScaleTexture);
            ui_zhuangshixianquan03_jiemian4886.x = 48;
            ui_zhuangshixianquan03_jiemian4886.y = 86;
            ui_zhuangshixianquan03_jiemian4886.width = 68;
            ui_zhuangshixianquan03_jiemian4886.height = 68;
            this.addQuiackChild(ui_zhuangshixianquan03_jiemian4886);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage2Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage29ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage2Rect);
            bgImage2 = new Scale9Image(bgImage29ScaleTexture);
            bgImage2.x = 33;
            bgImage2.y = 267;
            bgImage2.width = 594;
            bgImage2.height = 140;
            this.addQuiackChild(bgImage2);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage0Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage09ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage0Rect);
            bgImage0 = new Scale9Image(bgImage09ScaleTexture);
            bgImage0.x = 56;
            bgImage0.y = 187;
            bgImage0.width = 265;
            bgImage0.height = 34;
            this.addQuiackChild(bgImage0);
            texture =assetMgr.getTexture('ui_gongji01_tubiao');
            image = new Image(texture);
            image.x = 52;
            image.y = 184;
            image.width = 38;
            image.height = 38;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_dicengying02_jiemian');
            var bgImage1Rect:Rectangle = new Rectangle(12,12,20,20);
            var bgImage19ScaleTexture:Scale9Textures = new Scale9Textures(texture,bgImage1Rect);
            bgImage1 = new Scale9Image(bgImage19ScaleTexture);
            bgImage1.x = 56;
            bgImage1.y = 224;
            bgImage1.width = 265;
            bgImage1.height = 34;
            this.addQuiackChild(bgImage1);
            texture =assetMgr.getTexture('ui_shengming01_tubiao');
            image = new Image(texture);
            image.x = 52;
            image.y = 222;
            image.width = 38;
            image.height = 38;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian41172Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian411729ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian41172Rect);
            ui_zhuangshixianquan02_jiemian41172 = new Scale9Image(ui_zhuangshixianquan02_jiemian411729ScaleTexture);
            ui_zhuangshixianquan02_jiemian41172.x = 41;
            ui_zhuangshixianquan02_jiemian41172.y = 172;
            ui_zhuangshixianquan02_jiemian41172.width = 580;
            ui_zhuangshixianquan02_jiemian41172.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian41172);
            texture = assetMgr.getTexture('ui_texingtubiao_01')
            joy = new Image(texture);
            joy.x = 68;
            joy.y = 106;
            joy.width = 28;
            joy.height = 28;
            this.addQuiackChild(joy);
            joy.touchable = false;
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 614;
            image.y = 40;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 48;
            image.y = 40;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian41410Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian414109ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian41410Rect);
            ui_zhuangshixianquan02_jiemian41410 = new Scale9Image(ui_zhuangshixianquan02_jiemian414109ScaleTexture);
            ui_zhuangshixianquan02_jiemian41410.x = 41;
            ui_zhuangshixianquan02_jiemian41410.y = 410;
            ui_zhuangshixianquan02_jiemian41410.width = 580;
            ui_zhuangshixianquan02_jiemian41410.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian41410);
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            var heroBreak_Scale9ButtonRect:Rectangle = new Rectangle(29,16,58,31);
            heroBreak_Scale9Button = new Scale9Button(texture,heroBreak_Scale9ButtonRect);
            heroBreak_Scale9Button.x = 237;
            heroBreak_Scale9Button.y = 426;
            heroBreak_Scale9Button.width = 186;
            heroBreak_Scale9Button.height = 70;
            this.addQuiackChild(heroBreak_Scale9Button);
            heroBreak_Scale9Button.name = 'heroBreak_Scale9Button';
            heroBreak_Scale9Button.text= 'lable';
            heroBreak_Scale9Button.fontColor= 0xFFFFFF;
            heroBreak_Scale9Button.fontSize= 24;
            skillDes = new TextField(490,90,'','',24,0xFFFFFF,false);
            skillDes.touchable = false;
            skillDes.hAlign= 'left';
            skillDes.text= '';
            skillDes.x = 128;
            skillDes.y = 75;
            this.addQuiackChild(skillDes);
            text_expert = new TextField(140,32,'','',24,0xFFFFFF,false);
            text_expert.touchable = false;
            text_expert.hAlign= 'center';
            text_expert.text= '';
            text_expert.x = 347;
            text_expert.y = 188;
            this.addQuiackChild(text_expert);
            text_HabitWeapon = new TextField(140,32,'','',24,0xFFFFFF,false);
            text_HabitWeapon.touchable = false;
            text_HabitWeapon.hAlign= 'center';
            text_HabitWeapon.text= '';
            text_HabitWeapon.x = 347;
            text_HabitWeapon.y = 224;
            this.addQuiackChild(text_HabitWeapon);
            text_HabitWeaponValue = new TextField(160,32,'','',24,0xFF33FF,false);
            text_HabitWeaponValue.touchable = false;
            text_HabitWeaponValue.hAlign= 'center';
            text_HabitWeaponValue.text= '';
            text_HabitWeaponValue.x = 464;
            text_HabitWeaponValue.y = 224;
            this.addQuiackChild(text_HabitWeaponValue);
            text_expertValue = new TextField(160,32,'','',24,0xFF6600,false);
            text_expertValue.touchable = false;
            text_expertValue.hAlign= 'center';
            text_expertValue.text= '';
            text_expertValue.x = 464;
            text_expertValue.y = 188;
            this.addQuiackChild(text_expertValue);
            defendValue = new TextField(70,31,'','',24,0xFFFFFF,false);
            defendValue.touchable = false;
            defendValue.hAlign= 'center';
            defendValue.text= '';
            defendValue.x = 148;
            defendValue.y = 274;
            this.addQuiackChild(defendValue);
            defendAddValue = new TextField(70,31,'','',24,0x00FF00,false);
            defendAddValue.touchable = false;
            defendAddValue.hAlign= 'center';
            defendAddValue.text= '';
            defendAddValue.x = 248;
            defendAddValue.y = 274;
            this.addQuiackChild(defendAddValue);
            add_2 = new TextField(20,31,'','',24,0x00FF00,false);
            add_2.touchable = false;
            add_2.hAlign= 'center';
            add_2.text= '+';
            add_2.x = 222;
            add_2.y = 274;
            this.addQuiackChild(add_2);
            defend = new TextField(80,31,'','',24,0xFFCC99,false);
            defend.touchable = false;
            defend.hAlign= 'center';
            defend.text= '';
            defend.x = 66;
            defend.y = 274;
            this.addQuiackChild(defend);
            hitValue = new TextField(70,31,'','',24,0xFFFFFF,false);
            hitValue.touchable = false;
            hitValue.hAlign= 'center';
            hitValue.text= '';
            hitValue.x = 148;
            hitValue.y = 305;
            this.addQuiackChild(hitValue);
            hitAddValue = new TextField(70,31,'','',24,0x00FF00,false);
            hitAddValue.touchable = false;
            hitAddValue.hAlign= 'center';
            hitAddValue.text= '';
            hitAddValue.x = 248;
            hitAddValue.y = 305;
            this.addQuiackChild(hitAddValue);
            add_3 = new TextField(20,31,'','',24,0x00FF00,false);
            add_3.touchable = false;
            add_3.hAlign= 'center';
            add_3.text= '+';
            add_3.x = 222;
            add_3.y = 305;
            this.addQuiackChild(add_3);
            hit = new TextField(80,31,'','',24,0xFFCC99,false);
            hit.touchable = false;
            hit.hAlign= 'center';
            hit.text= '';
            hit.x = 66;
            hit.y = 305;
            this.addQuiackChild(hit);
            critValue = new TextField(70,31,'','',24,0xFFFFFF,false);
            critValue.touchable = false;
            critValue.hAlign= 'center';
            critValue.text= '';
            critValue.x = 148;
            critValue.y = 336;
            this.addQuiackChild(critValue);
            critAddValue = new TextField(70,31,'','',24,0x00FF00,false);
            critAddValue.touchable = false;
            critAddValue.hAlign= 'center';
            critAddValue.text= '';
            critAddValue.x = 248;
            critAddValue.y = 336;
            this.addQuiackChild(critAddValue);
            add_4 = new TextField(20,31,'','',24,0x00FF00,false);
            add_4.touchable = false;
            add_4.hAlign= 'center';
            add_4.text= '+';
            add_4.x = 222;
            add_4.y = 336;
            this.addQuiackChild(add_4);
            crit = new TextField(80,31,'','',24,0xFFCC99,false);
            crit.touchable = false;
            crit.hAlign= 'center';
            crit.text= '';
            crit.x = 66;
            crit.y = 336;
            this.addQuiackChild(crit);
            anitCritValue = new TextField(70,31,'','',24,0xFFFFFF,false);
            anitCritValue.touchable = false;
            anitCritValue.hAlign= 'center';
            anitCritValue.text= '';
            anitCritValue.x = 148;
            anitCritValue.y = 369;
            this.addQuiackChild(anitCritValue);
            anitCritAddValue = new TextField(70,31,'','',24,0x00FF00,false);
            anitCritAddValue.touchable = false;
            anitCritAddValue.hAlign= 'center';
            anitCritAddValue.text= '';
            anitCritAddValue.x = 248;
            anitCritAddValue.y = 369;
            this.addQuiackChild(anitCritAddValue);
            add_5 = new TextField(20,31,'','',24,0x00FF00,false);
            add_5.touchable = false;
            add_5.hAlign= 'center';
            add_5.text= '+';
            add_5.x = 222;
            add_5.y = 369;
            this.addQuiackChild(add_5);
            anitCrit = new TextField(80,31,'','',24,0xFFCC99,false);
            anitCrit.touchable = false;
            anitCrit.hAlign= 'center';
            anitCrit.text= '';
            anitCrit.x = 66;
            anitCrit.y = 369;
            this.addQuiackChild(anitCrit);
            punctureValue = new TextField(70,31,'','',24,0xFFFFFF,false);
            punctureValue.touchable = false;
            punctureValue.hAlign= 'center';
            punctureValue.text= '';
            punctureValue.x = 423;
            punctureValue.y = 274;
            this.addQuiackChild(punctureValue);
            punctureAddValue = new TextField(70,31,'','',24,0x00FF00,false);
            punctureAddValue.touchable = false;
            punctureAddValue.hAlign= 'center';
            punctureAddValue.text= '';
            punctureAddValue.x = 522;
            punctureAddValue.y = 274;
            this.addQuiackChild(punctureAddValue);
            add_6 = new TextField(20,31,'','',24,0x00FF00,false);
            add_6.touchable = false;
            add_6.hAlign= 'center';
            add_6.text= '+';
            add_6.x = 497;
            add_6.y = 274;
            this.addQuiackChild(add_6);
            puncture = new TextField(80,31,'','',24,0xFFCC99,false);
            puncture.touchable = false;
            puncture.hAlign= 'center';
            puncture.text= '';
            puncture.x = 341;
            puncture.y = 274;
            this.addQuiackChild(puncture);
            dodgeValue = new TextField(70,31,'','',24,0xFFFFFF,false);
            dodgeValue.touchable = false;
            dodgeValue.hAlign= 'center';
            dodgeValue.text= '';
            dodgeValue.x = 423;
            dodgeValue.y = 305;
            this.addQuiackChild(dodgeValue);
            dodgeAddValue = new TextField(70,31,'','',24,0x00FF00,false);
            dodgeAddValue.touchable = false;
            dodgeAddValue.hAlign= 'center';
            dodgeAddValue.text= '';
            dodgeAddValue.x = 522;
            dodgeAddValue.y = 305;
            this.addQuiackChild(dodgeAddValue);
            add_7 = new TextField(20,31,'','',24,0x00FF00,false);
            add_7.touchable = false;
            add_7.hAlign= 'center';
            add_7.text= '+';
            add_7.x = 497;
            add_7.y = 305;
            this.addQuiackChild(add_7);
            dodge = new TextField(80,31,'','',24,0xFFCC99,false);
            dodge.touchable = false;
            dodge.hAlign= 'center';
            dodge.text= '';
            dodge.x = 341;
            dodge.y = 305;
            this.addQuiackChild(dodge);
            critPercentageValue = new TextField(70,31,'','',24,0xFFFFFF,false);
            critPercentageValue.touchable = false;
            critPercentageValue.hAlign= 'center';
            critPercentageValue.text= '';
            critPercentageValue.x = 423;
            critPercentageValue.y = 336;
            this.addQuiackChild(critPercentageValue);
            critPercentageAddValue = new TextField(70,31,'','',24,0x00FF00,false);
            critPercentageAddValue.touchable = false;
            critPercentageAddValue.hAlign= 'center';
            critPercentageAddValue.text= '';
            critPercentageAddValue.x = 522;
            critPercentageAddValue.y = 336;
            this.addQuiackChild(critPercentageAddValue);
            add_8 = new TextField(20,31,'','',24,0x00FF00,false);
            add_8.touchable = false;
            add_8.hAlign= 'center';
            add_8.text= '+';
            add_8.x = 497;
            add_8.y = 336;
            this.addQuiackChild(add_8);
            critPercentage = new TextField(80,31,'','',24,0xFFCC99,false);
            critPercentage.touchable = false;
            critPercentage.hAlign= 'center';
            critPercentage.text= '';
            critPercentage.x = 341;
            critPercentage.y = 336;
            this.addQuiackChild(critPercentage);
            toughnessValue = new TextField(70,31,'','',24,0xFFFFFF,false);
            toughnessValue.touchable = false;
            toughnessValue.hAlign= 'center';
            toughnessValue.text= '';
            toughnessValue.x = 423;
            toughnessValue.y = 369;
            this.addQuiackChild(toughnessValue);
            toughnessAddValue = new TextField(70,31,'','',24,0x00FF00,false);
            toughnessAddValue.touchable = false;
            toughnessAddValue.hAlign= 'center';
            toughnessAddValue.text= '';
            toughnessAddValue.x = 522;
            toughnessAddValue.y = 369;
            this.addQuiackChild(toughnessAddValue);
            add_9 = new TextField(20,31,'','',24,0x00FF00,false);
            add_9.touchable = false;
            add_9.hAlign= 'center';
            add_9.text= '+';
            add_9.x = 497;
            add_9.y = 369;
            this.addQuiackChild(add_9);
            toughness = new TextField(80,31,'','',24,0xFFCC99,false);
            toughness.touchable = false;
            toughness.hAlign= 'center';
            toughness.text= '';
            toughness.x = 341;
            toughness.y = 369;
            this.addQuiackChild(toughness);
            attackValue = new TextField(100,32,'','',24,0xFFFFFF,false);
            attackValue.touchable = false;
            attackValue.hAlign= 'center';
            attackValue.text= '';
            attackValue.x = 92;
            attackValue.y = 188;
            this.addQuiackChild(attackValue);
            attackAddValue = new TextField(100,32,'','',24,0x00FF00,false);
            attackAddValue.touchable = false;
            attackAddValue.hAlign= 'center';
            attackAddValue.text= '';
            attackAddValue.x = 218;
            attackAddValue.y = 188;
            this.addQuiackChild(attackAddValue);
            add_0 = new TextField(20,31,'','',24,0x00FF00,false);
            add_0.touchable = false;
            add_0.hAlign= 'center';
            add_0.text= '+';
            add_0.x = 195;
            add_0.y = 188;
            this.addQuiackChild(add_0);
            hpValue = new TextField(100,32,'','',24,0xFFFFFF,false);
            hpValue.touchable = false;
            hpValue.hAlign= 'center';
            hpValue.text= '';
            hpValue.x = 92;
            hpValue.y = 225;
            this.addQuiackChild(hpValue);
            hpAddValue = new TextField(100,32,'','',24,0x00FF00,false);
            hpAddValue.touchable = false;
            hpAddValue.hAlign= 'center';
            hpAddValue.text= '';
            hpAddValue.x = 218;
            hpAddValue.y = 225;
            this.addQuiackChild(hpAddValue);
            add_1 = new TextField(20,31,'','',24,0x00FF00,false);
            add_1.touchable = false;
            add_1.hAlign= 'center';
            add_1.text= '+';
            add_1.x = 195;
            add_1.y = 225;
            this.addQuiackChild(add_1);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
