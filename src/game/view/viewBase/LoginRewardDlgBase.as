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

    public class LoginRewardDlgBase extends TabDialog
    {
        public var ui_tanchukuangdi01_jiemian014:Scale9Image;
        public var btn_close:Button;
        public var list_award:List;
        public var ui_zhuangshixianquan02_jiemian58147:Scale9Image;
        public var text_currDay:TextField;
        public var Day:TextField;
        public var text_currDayNum:TextField;
        public var btn_day1:Button;
        public var btn_day2:Button;
        public var btn_day3:Button;
        public var btn_day4:Button;
        public var btn_day5:Button;
        public var btn_day7:Button;
        public var btn_day6:Button;

        public function LoginRewardDlgBase()
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
            ui_tanchukuangdi01_jiemian014.width = 960;
            ui_tanchukuangdi01_jiemian014.height = 580;
            this.addQuiackChild(ui_tanchukuangdi01_jiemian014);
            texture =assetMgr.getTexture('ui_taitoudi01_jiemian');
            image = new Image(texture);
            image.x = 120;
            image.y = 10;
            image.width = 720;
            image.height = 56;
            image.smoothing= Constants.NONE;
            this.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_mingzidi01');
            image = new Image(texture);
            image.x = 254;
            image.y = 20;
            image.width = 452;
            image.height = 37;
            image.smoothing= Constants.NONE;
            this.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_guanbi01_anniu');
            btn_close = new Button(texture);
            btn_close.name= 'btn_close';
            btn_close.x = 866;
            btn_close.width = 72;
            btn_close.height = 76;
            this.addQuiackChild(btn_close);
            texture =assetMgr.getTexture('ui_qiandao_taitou_wenzi');
            image = new Image(texture);
            image.x = 423;
            image.y = 20;
            image.width = 115;
            image.height = 37;
            image.smoothing= Constants.NONE;
            this.addQuiackChild(image);
            list_award = new List();
            list_award.x = 70;
            list_award.y = 382;
            list_award.width = 820;
            list_award.height = 140;
            this.addQuiackChild(list_award);
            texture = assetMgr.getTexture('ui_zhuangshixianquan02_jiemian');
            var ui_zhuangshixianquan02_jiemian58147Rect:Rectangle = new Rectangle(3,0,3,1);
            var ui_zhuangshixianquan02_jiemian581479ScaleTexture:Scale9Textures = new Scale9Textures(texture,ui_zhuangshixianquan02_jiemian58147Rect);
            ui_zhuangshixianquan02_jiemian58147 = new Scale9Image(ui_zhuangshixianquan02_jiemian581479ScaleTexture);
            ui_zhuangshixianquan02_jiemian58147.x = 58;
            ui_zhuangshixianquan02_jiemian58147.y = 147;
            ui_zhuangshixianquan02_jiemian58147.width = 844;
            ui_zhuangshixianquan02_jiemian58147.height = 2;
            this.addQuiackChild(ui_zhuangshixianquan02_jiemian58147);
            text_currDay = new TextField(130,31,'','',24,0xFFFFFF,false);
            text_currDay.touchable = false;
            text_currDay.hAlign= 'right';
            text_currDay.text= '';
            text_currDay.x = 371;
            text_currDay.y = 104;
            this.addQuiackChild(text_currDay);
            Day = new TextField(80,31,'','',24,0xFFFFFF,false);
            Day.touchable = false;
            Day.hAlign= 'left';
            Day.text= '';
            Day.x = 560;
            Day.y = 104;
            this.addQuiackChild(Day);
            text_currDayNum = new TextField(50,38,'','',30,0x00FF00,false);
            text_currDayNum.touchable = false;
            text_currDayNum.hAlign= 'center';
            text_currDayNum.text= '';
            text_currDayNum.x = 506;
            text_currDayNum.y = 101;
            this.addQuiackChild(text_currDayNum);
            texture = assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            btn_day1 = new Button(texture);
            btn_day1.name= 'btn_day1';
            btn_day1.x = 39;
            btn_day1.y = 171;
            btn_day1.width = 124;
            btn_day1.height = 184;
            this.addQuiackChild(btn_day1);
            texture =assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            image = new Image(texture);
            image.width = 162;
            image.height = 240;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day1.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_tubiao_zhuxianpilaozhi_xiao_jian');
            image = new Image(texture);
            image.x = 22;
            image.y = 19;
            image.width = 114;
            image.height = 34;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day1.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi1')
            image = new Image(texture);
            image.name= 'openBox';
            image.x = 19;
            image.y = 62;
            image.width = 116;
            image.height = 116;
            btn_day1.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi2')
            image = new Image(texture);
            image.name= 'closeBox1';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day1.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi')
            image = new Image(texture);
            image.name= 'closeBox';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day1.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_world_nandusuo')
            image = new Image(texture);
            image.name= 'Lock';
            image.x = 40;
            image.y = 111;
            image.width = 59;
            image.height = 67;
            btn_day1.addQuiackChild(image);
            image.touchable = false;
            textField = new TextField(104,25,'','',21,0x00FF00,false);
            textField.touchable = false;
            textField.x = 26;
            textField.y = 24;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'text_Day';
            btn_day1.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_gongyong_jianglilingqu')
            image = new Image(texture);
            image.name= 'CanReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 36;
            btn_day1.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_reward_yilingqu')
            image = new Image(texture);
            image.name= 'stopReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 37;
            btn_day1.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            btn_day2 = new Button(texture);
            btn_day2.name= 'btn_day2';
            btn_day2.x = 165;
            btn_day2.y = 171;
            btn_day2.width = 124;
            btn_day2.height = 184;
            this.addQuiackChild(btn_day2);
            texture =assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            image = new Image(texture);
            image.width = 162;
            image.height = 240;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day2.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_tubiao_zhuxianpilaozhi_xiao_jian');
            image = new Image(texture);
            image.x = 22;
            image.y = 19;
            image.width = 114;
            image.height = 34;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day2.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi1')
            image = new Image(texture);
            image.name= 'openBox';
            image.x = 19;
            image.y = 62;
            image.width = 116;
            image.height = 116;
            btn_day2.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi2')
            image = new Image(texture);
            image.name= 'closeBox1';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day2.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi')
            image = new Image(texture);
            image.name= 'closeBox';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day2.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_world_nandusuo')
            image = new Image(texture);
            image.name= 'Lock';
            image.x = 40;
            image.y = 111;
            image.width = 59;
            image.height = 67;
            btn_day2.addQuiackChild(image);
            image.touchable = false;
            textField = new TextField(104,25,'','',21,0x00FF00,false);
            textField.touchable = false;
            textField.x = 26;
            textField.y = 24;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'text_Day';
            btn_day2.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_gongyong_jianglilingqu')
            image = new Image(texture);
            image.name= 'CanReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 36;
            btn_day2.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_reward_yilingqu')
            image = new Image(texture);
            image.name= 'stopReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 37;
            btn_day2.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            btn_day3 = new Button(texture);
            btn_day3.name= 'btn_day3';
            btn_day3.x = 292;
            btn_day3.y = 171;
            btn_day3.width = 124;
            btn_day3.height = 184;
            this.addQuiackChild(btn_day3);
            texture =assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            image = new Image(texture);
            image.width = 162;
            image.height = 240;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day3.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_tubiao_zhuxianpilaozhi_xiao_jian');
            image = new Image(texture);
            image.x = 22;
            image.y = 19;
            image.width = 114;
            image.height = 34;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day3.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi1')
            image = new Image(texture);
            image.name= 'openBox';
            image.x = 19;
            image.y = 62;
            image.width = 116;
            image.height = 116;
            btn_day3.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi2')
            image = new Image(texture);
            image.name= 'closeBox1';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day3.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi')
            image = new Image(texture);
            image.name= 'closeBox';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day3.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_world_nandusuo')
            image = new Image(texture);
            image.name= 'Lock';
            image.x = 40;
            image.y = 111;
            image.width = 59;
            image.height = 67;
            btn_day3.addQuiackChild(image);
            image.touchable = false;
            textField = new TextField(104,25,'','',21,0x00FF00,false);
            textField.touchable = false;
            textField.x = 26;
            textField.y = 24;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'text_Day';
            btn_day3.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_gongyong_jianglilingqu')
            image = new Image(texture);
            image.name= 'CanReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 36;
            btn_day3.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_reward_yilingqu')
            image = new Image(texture);
            image.name= 'stopReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 37;
            btn_day3.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            btn_day4 = new Button(texture);
            btn_day4.name= 'btn_day4';
            btn_day4.x = 418;
            btn_day4.y = 171;
            btn_day4.width = 124;
            btn_day4.height = 184;
            this.addQuiackChild(btn_day4);
            texture =assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            image = new Image(texture);
            image.width = 162;
            image.height = 240;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day4.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_tubiao_zhuxianpilaozhi_xiao_jian');
            image = new Image(texture);
            image.x = 22;
            image.y = 19;
            image.width = 114;
            image.height = 34;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day4.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi1')
            image = new Image(texture);
            image.name= 'openBox';
            image.x = 19;
            image.y = 62;
            image.width = 116;
            image.height = 116;
            btn_day4.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi2')
            image = new Image(texture);
            image.name= 'closeBox1';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day4.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi')
            image = new Image(texture);
            image.name= 'closeBox';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day4.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_world_nandusuo')
            image = new Image(texture);
            image.name= 'Lock';
            image.x = 40;
            image.y = 111;
            image.width = 59;
            image.height = 67;
            btn_day4.addQuiackChild(image);
            image.touchable = false;
            textField = new TextField(104,25,'','',21,0x00FF00,false);
            textField.touchable = false;
            textField.x = 26;
            textField.y = 24;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'text_Day';
            btn_day4.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_gongyong_jianglilingqu')
            image = new Image(texture);
            image.name= 'CanReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 36;
            btn_day4.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_reward_yilingqu')
            image = new Image(texture);
            image.name= 'stopReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 37;
            btn_day4.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            btn_day5 = new Button(texture);
            btn_day5.name= 'btn_day5';
            btn_day5.x = 544;
            btn_day5.y = 171;
            btn_day5.width = 124;
            btn_day5.height = 184;
            this.addQuiackChild(btn_day5);
            texture =assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            image = new Image(texture);
            image.width = 162;
            image.height = 240;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day5.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_tubiao_zhuxianpilaozhi_xiao_jian');
            image = new Image(texture);
            image.x = 22;
            image.y = 19;
            image.width = 114;
            image.height = 34;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day5.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi1')
            image = new Image(texture);
            image.name= 'openBox';
            image.x = 19;
            image.y = 62;
            image.width = 116;
            image.height = 116;
            btn_day5.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi2')
            image = new Image(texture);
            image.name= 'closeBox1';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day5.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi')
            image = new Image(texture);
            image.name= 'closeBox';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day5.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_world_nandusuo')
            image = new Image(texture);
            image.name= 'Lock';
            image.x = 40;
            image.y = 111;
            image.width = 59;
            image.height = 67;
            btn_day5.addQuiackChild(image);
            image.touchable = false;
            textField = new TextField(104,25,'','',21,0x00FF00,false);
            textField.touchable = false;
            textField.x = 26;
            textField.y = 24;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'text_Day';
            btn_day5.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_gongyong_jianglilingqu')
            image = new Image(texture);
            image.name= 'CanReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 36;
            btn_day5.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_reward_yilingqu')
            image = new Image(texture);
            image.name= 'stopReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 37;
            btn_day5.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            btn_day7 = new Button(texture);
            btn_day7.name= 'btn_day7';
            btn_day7.x = 797;
            btn_day7.y = 171;
            btn_day7.width = 124;
            btn_day7.height = 184;
            this.addQuiackChild(btn_day7);
            texture =assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            image = new Image(texture);
            image.width = 162;
            image.height = 240;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day7.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_tubiao_zhuxianpilaozhi_xiao_jian');
            image = new Image(texture);
            image.x = 22;
            image.y = 19;
            image.width = 114;
            image.height = 34;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day7.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi1')
            image = new Image(texture);
            image.name= 'openBox';
            image.x = 19;
            image.y = 62;
            image.width = 116;
            image.height = 116;
            btn_day7.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi2')
            image = new Image(texture);
            image.name= 'closeBox1';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day7.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi')
            image = new Image(texture);
            image.name= 'closeBox';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day7.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_world_nandusuo')
            image = new Image(texture);
            image.name= 'Lock';
            image.x = 40;
            image.y = 111;
            image.width = 59;
            image.height = 67;
            btn_day7.addQuiackChild(image);
            image.touchable = false;
            textField = new TextField(104,25,'','',21,0x00FF00,false);
            textField.touchable = false;
            textField.x = 26;
            textField.y = 24;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'text_Day';
            btn_day7.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_gongyong_jianglilingqu')
            image = new Image(texture);
            image.name= 'CanReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 36;
            btn_day7.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_reward_yilingqu')
            image = new Image(texture);
            image.name= 'stopReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 37;
            btn_day7.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            btn_day6 = new Button(texture);
            btn_day6.name= 'btn_day6';
            btn_day6.x = 670;
            btn_day6.y = 171;
            btn_day6.width = 124;
            btn_day6.height = 184;
            this.addQuiackChild(btn_day6);
            texture =assetMgr.getTexture('ui_button_zhuxianfubenpaizidi');
            image = new Image(texture);
            image.width = 162;
            image.height = 240;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day6.addQuiackChild(image);
            texture =assetMgr.getTexture('ui_tubiao_zhuxianpilaozhi_xiao_jian');
            image = new Image(texture);
            image.x = 22;
            image.y = 19;
            image.width = 114;
            image.height = 34;
            image.touchable = false;
            image.smoothing= Constants.smoothing;
            btn_day6.addQuiackChild(image);
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi1')
            image = new Image(texture);
            image.name= 'openBox';
            image.x = 19;
            image.y = 62;
            image.width = 116;
            image.height = 116;
            btn_day6.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi2')
            image = new Image(texture);
            image.name= 'closeBox1';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day6.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_shangcheng_jinxiangzi')
            image = new Image(texture);
            image.name= 'closeBox';
            image.x = 29;
            image.y = 86;
            image.width = 94;
            image.height = 84;
            btn_day6.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_world_nandusuo')
            image = new Image(texture);
            image.name= 'Lock';
            image.x = 40;
            image.y = 111;
            image.width = 59;
            image.height = 67;
            btn_day6.addQuiackChild(image);
            image.touchable = false;
            textField = new TextField(104,25,'','',21,0x00FF00,false);
            textField.touchable = false;
            textField.x = 26;
            textField.y = 24;
            textField.hAlign= 'center';
            textField.text= '';
            textField.name= 'text_Day';
            btn_day6.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_gongyong_jianglilingqu')
            image = new Image(texture);
            image.name= 'CanReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 36;
            btn_day6.addQuiackChild(image);
            image.touchable = false;
            texture = assetMgr.getTexture('ui_reward_yilingqu')
            image = new Image(texture);
            image.name= 'stopReceive';
            image.x = 33;
            image.y = 99;
            image.width = 87;
            image.height = 37;
            btn_day6.addQuiackChild(image);
            image.touchable = false;
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_close.dispose();
            list_award.dispose();
            btn_day1.dispose();
            btn_day2.dispose();
            btn_day3.dispose();
            btn_day4.dispose();
            btn_day5.dispose();
            btn_day7.dispose();
            btn_day6.dispose();
            super.dispose();
        
}
    }
}
