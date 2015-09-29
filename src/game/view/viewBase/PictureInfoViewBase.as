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

    public class PictureInfoViewBase extends Dialog
    {
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;
        public var ui_zhuangshixianquan03_jiemian592350:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian606364:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian610401:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian610402:Scale9Image;
        public var ui_zhuangshixianquan03_jiemian44350:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian58364:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian62401:Scale9Image;
        public var ui_zhuangshixianquan02_jiemian62402:Scale9Image;
        public var ui_zhuangshixianquan03_jiemian28960:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian303103:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian303182:Scale9Image;
        public var ui_zhuangshixianquan01_jiemian303261:Scale9Image;
        public var skill_0:Image;
        public var skill_1:Image;
        public var skill_2:Image;
        public var txt_des1:TextField;
        public var txt_des2:TextField;
        public var txt_weapon:TextField;
        public var txt_pos:TextField;
        public var txt_des:TextField;
        public var txtSkill_0:TextField;
        public var txtSkill_1:TextField;
        public var txtSkill_2:TextField;

        public function PictureInfoViewBase()
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
            ui_tipstanchukuangdi01_jiemian00.width = 950;
            ui_tipstanchukuangdi01_jiemian00.height = 540;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            texture = assetMgr.getTexture('ui_zhuangshixianquan03_jiemian');
            var ui_zhuangshixianquan03_jiemian592350Rect:Rectangle = new Rectangle(30,30,10,10);
            var ui_zhuangshixianquan03_jiemian5923509ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan03_jiemian592350Rect);
            ui_zhuangshixianquan03_jiemian592350 = new Scale9Image(ui_zhuangshixianquan03_jiemian5923509ScaleTexture);
            ui_zhuangshixianquan03_jiemian592350.x = 592;
            ui_zhuangshixianquan03_jiemian592350.y = 350;
            ui_zhuangshixianquan03_jiemian592350.width = 312;
            ui_zhuangshixianquan03_jiemian592350.height = 142;
            this.addQuiackChild(ui_zhuangshixianquan03_jiemian592350);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian606364Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian6063649ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian606364Rect);
            ui_zhuangshixianquan01_jiemian606364 = new Scale9Image(ui_zhuangshixianquan01_jiemian6063649ScaleTexture);
            ui_zhuangshixianquan01_jiemian606364.x = 606;
            ui_zhuangshixianquan01_jiemian606364.y = 364;
            ui_zhuangshixianquan01_jiemian606364.width = 284;
            ui_zhuangshixianquan01_jiemian606364.height = 114;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian606364);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian610401Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian6104019ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian610401Rect);
            ui_zhuangshixianquan02_jiemian610401 = new Scale9Image(ui_zhuangshixianquan02_jiemian6104019ScaleTexture);
            ui_zhuangshixianquan02_jiemian610401.x = 610;
            ui_zhuangshixianquan02_jiemian610401.y = 401;
            ui_zhuangshixianquan02_jiemian610401.width = 276;
            ui_zhuangshixianquan02_jiemian610401.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian610401);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 615;
            image.y = 367;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 881;
            image.y = 367;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 690;
            image.y = 400;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 796;
            image.y = 400;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_yingxiongtexing_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 692;
            image.y = 371;
            image.width = 102;
            image.height = 31;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian610402Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian6104029ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian610402Rect);
            ui_zhuangshixianquan02_jiemian610402 = new Scale9Image(ui_zhuangshixianquan02_jiemian6104029ScaleTexture);
            ui_zhuangshixianquan02_jiemian610402.x = 610;
            ui_zhuangshixianquan02_jiemian610402.y = 402;
            ui_zhuangshixianquan02_jiemian610402.width = 276;
            ui_zhuangshixianquan02_jiemian610402.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian610402);
            texture = assetMgr.getTexture('ui_zhuangshixianquan03_jiemian');
            var ui_zhuangshixianquan03_jiemian44350Rect:Rectangle = new Rectangle(30,30,10,10);
            var ui_zhuangshixianquan03_jiemian443509ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan03_jiemian44350Rect);
            ui_zhuangshixianquan03_jiemian44350 = new Scale9Image(ui_zhuangshixianquan03_jiemian443509ScaleTexture);
            ui_zhuangshixianquan03_jiemian44350.x = 44;
            ui_zhuangshixianquan03_jiemian44350.y = 350;
            ui_zhuangshixianquan03_jiemian44350.width = 550;
            ui_zhuangshixianquan03_jiemian44350.height = 142;
            this.addQuiackChild(ui_zhuangshixianquan03_jiemian44350);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian58364Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian583649ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian58364Rect);
            ui_zhuangshixianquan01_jiemian58364 = new Scale9Image(ui_zhuangshixianquan01_jiemian583649ScaleTexture);
            ui_zhuangshixianquan01_jiemian58364.x = 58;
            ui_zhuangshixianquan01_jiemian58364.y = 364;
            ui_zhuangshixianquan01_jiemian58364.width = 522;
            ui_zhuangshixianquan01_jiemian58364.height = 114;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian58364);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian62401Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian624019ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian62401Rect);
            ui_zhuangshixianquan02_jiemian62401 = new Scale9Image(ui_zhuangshixianquan02_jiemian624019ScaleTexture);
            ui_zhuangshixianquan02_jiemian62401.x = 62;
            ui_zhuangshixianquan02_jiemian62401.y = 401;
            ui_zhuangshixianquan02_jiemian62401.width = 514;
            ui_zhuangshixianquan02_jiemian62401.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian62401);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 67;
            image.y = 367;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 571;
            image.y = 367;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian62402Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian624029ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian62402Rect);
            ui_zhuangshixianquan02_jiemian62402 = new Scale9Image(ui_zhuangshixianquan02_jiemian624029ScaleTexture);
            ui_zhuangshixianquan02_jiemian62402.x = 62;
            ui_zhuangshixianquan02_jiemian62402.y = 402;
            ui_zhuangshixianquan02_jiemian62402.width = 514;
            ui_zhuangshixianquan02_jiemian62402.height = 1;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian62402);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 278;
            image.y = 400;
            image.width = 33;
            image.height = 8;
            image.scaleX = -1;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 384;
            image.y = 400;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_yingxiongjianjie_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 281;
            image.y = 371;
            image.width = 102;
            image.height = 31;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan03_jiemian');
            var ui_zhuangshixianquan03_jiemian28960Rect:Rectangle = new Rectangle(30,30,10,10);
            var ui_zhuangshixianquan03_jiemian289609ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan03_jiemian28960Rect);
            ui_zhuangshixianquan03_jiemian28960 = new Scale9Image(ui_zhuangshixianquan03_jiemian289609ScaleTexture);
            ui_zhuangshixianquan03_jiemian28960.x = 289;
            ui_zhuangshixianquan03_jiemian28960.y = 60;
            ui_zhuangshixianquan03_jiemian28960.width = 614;
            ui_zhuangshixianquan03_jiemian28960.height = 290;
            this.addQuiackChild(ui_zhuangshixianquan03_jiemian28960);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 312;
            image.y = 77;
            image.width = 33;
            image.height = 8;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 880;
            image.y = 77;
            image.width = 33;
            image.height = 8;
            image.scaleX = -0.9999847412109375;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian303103Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian3031039ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian303103Rect);
            ui_zhuangshixianquan01_jiemian303103 = new Scale9Image(ui_zhuangshixianquan01_jiemian3031039ScaleTexture);
            ui_zhuangshixianquan01_jiemian303103.x = 303;
            ui_zhuangshixianquan01_jiemian303103.y = 103;
            ui_zhuangshixianquan01_jiemian303103.width = 586;
            ui_zhuangshixianquan01_jiemian303103.height = 75;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian303103);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian303182Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian3031829ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian303182Rect);
            ui_zhuangshixianquan01_jiemian303182 = new Scale9Image(ui_zhuangshixianquan01_jiemian3031829ScaleTexture);
            ui_zhuangshixianquan01_jiemian303182.x = 303;
            ui_zhuangshixianquan01_jiemian303182.y = 182;
            ui_zhuangshixianquan01_jiemian303182.width = 586;
            ui_zhuangshixianquan01_jiemian303182.height = 75;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian303182);
            texture = assetMgr.getTexture('ui_zhuangshixianquan01_jiemian');
            var ui_zhuangshixianquan01_jiemian303261Rect:Rectangle = new Rectangle(12,12,20,20);
            var ui_zhuangshixianquan01_jiemian3032619ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan01_jiemian303261Rect);
            ui_zhuangshixianquan01_jiemian303261 = new Scale9Image(ui_zhuangshixianquan01_jiemian3032619ScaleTexture);
            ui_zhuangshixianquan01_jiemian303261.x = 303;
            ui_zhuangshixianquan01_jiemian303261.y = 261;
            ui_zhuangshixianquan01_jiemian303261.width = 586;
            ui_zhuangshixianquan01_jiemian303261.height = 75;
            this.addQuiackChild(ui_zhuangshixianquan01_jiemian303261);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 563;
            image.y = 100;
            image.width = 33;
            image.height = 8;
            image.scaleX = -0.9999847412109375;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen01_jiemian');
            image = new Image(texture);
            image.x = 629;
            image.y = 100;
            image.width = 33;
            image.height = 8;
            image.scaleY = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_jineng_xiaotaitou_wenzi');
            image = new Image(texture);
            image.x = 570;
            image.y = 74;
            image.width = 53;
            image.height = 30;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 69;
            image.y = 372;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_jinengkuangdi01')
            skill_0 = new Image(texture);
            skill_0.x = 313;
            skill_0.y = 119;
            skill_0.width = 46;
            skill_0.height = 46;
            this.addQuiackChild(skill_0);
            skill_0.touchable = false;
            texture = assetMgr.getTexture('ui_jinengkuangdi01')
            skill_1 = new Image(texture);
            skill_1.x = 314;
            skill_1.y = 197;
            skill_1.width = 46;
            skill_1.height = 46;
            this.addQuiackChild(skill_1);
            skill_1.touchable = false;
            texture = assetMgr.getTexture('ui_jinengkuangdi01')
            skill_2 = new Image(texture);
            skill_2.x = 314;
            skill_2.y = 276;
            skill_2.width = 46;
            skill_2.height = 46;
            this.addQuiackChild(skill_2);
            skill_2.touchable = false;
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 879;
            image.y = 372;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 569;
            image.y = 372;
            image.width = 8;
            image.height = 33;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_zhuangshihuawen02_jiemian');
            image = new Image(texture);
            image.x = 617;
            image.y = 372;
            image.width = 8;
            image.height = 33;
            image.scaleX = -1;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            this.addQuiackChild(image);
            txt_des1 = new TextField(110,32,'','',24,0xFFFFFF,false);
            txt_des1.touchable = false;
            txt_des1.hAlign= 'center';
            txt_des1.text= '';
            txt_des1.x = 612;
            txt_des1.y = 408;
            this.addQuiackChild(txt_des1);
            txt_des2 = new TextField(110,32,'','',24,0xFFFFFF,false);
            txt_des2.touchable = false;
            txt_des2.hAlign= 'center';
            txt_des2.text= '';
            txt_des2.x = 612;
            txt_des2.y = 443;
            this.addQuiackChild(txt_des2);
            txt_weapon = new TextField(158,32,'','',24,0xFF33FF,false);
            txt_weapon.touchable = false;
            txt_weapon.hAlign= 'center';
            txt_weapon.text= '';
            txt_weapon.x = 724;
            txt_weapon.y = 443;
            this.addQuiackChild(txt_weapon);
            txt_pos = new TextField(158,32,'','',24,0xFF6600,false);
            txt_pos.touchable = false;
            txt_pos.hAlign= 'center';
            txt_pos.text= '';
            txt_pos.x = 724;
            txt_pos.y = 408;
            this.addQuiackChild(txt_pos);
            txt_des = new TextField(514,60,'','',24,0xFFFFFF,false);
            txt_des.touchable = false;
            txt_des.hAlign= 'left';
            txt_des.text= '';
            txt_des.x = 62;
            txt_des.y = 410;
            this.addQuiackChild(txt_des);
            txtSkill_0 = new TextField(512,62,'','',24,0xFFFFFF,false);
            txtSkill_0.touchable = false;
            txtSkill_0.hAlign= 'left';
            txtSkill_0.text= '';
            txtSkill_0.x = 366;
            txtSkill_0.y = 110;
            this.addQuiackChild(txtSkill_0);
            txtSkill_1 = new TextField(512,62,'','',24,0xFFFFFF,false);
            txtSkill_1.touchable = false;
            txtSkill_1.hAlign= 'left';
            txtSkill_1.text= '';
            txtSkill_1.x = 366;
            txtSkill_1.y = 189;
            this.addQuiackChild(txtSkill_1);
            txtSkill_2 = new TextField(512,62,'','',24,0xFFFFFF,false);
            txtSkill_2.touchable = false;
            txtSkill_2.hAlign= 'left';
            txtSkill_2.text= '';
            txtSkill_2.x = 366;
            txtSkill_2.y = 268;
            this.addQuiackChild(txtSkill_2);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
