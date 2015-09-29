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
    import feathers.controls.renderers.DefaultListItemRenderer;

    public class VipRenderBase extends DefaultListItemRenderer
    {
        public var txt_vip:TextField;
        public var txt_vipLevel1:TextField;
        public var txt_vipLevel2:TextField;
        public var txt_des17:TextField;
        public var txt_best:TextField;
        public var txt_des5:TextField;
        public var txt_des10:TextField;
        public var txt_speed:TextField;
        public var txt_des6:TextField;
        public var txt_des2:TextField;
        public var txt_day:TextField;
        public var txt_des7:TextField;
        public var txt_chat:TextField;
        public var txt_des8:TextField;
        public var txt_des9:TextField;
        public var txt_des13:TextField;
        public var txt_des15:TextField;
        public var txt_tired:TextField;
        public var txt_des14:TextField;
        public var txt_des16:TextField;
        public var txt_jingji:TextField;

        public function VipRenderBase()
        {
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            txt_vip = new TextField(254,49,'','',30,0xFFCC00,false);
            txt_vip.touchable = false;
            txt_vip.hAlign= 'center';
            txt_vip.text= '';
            txt_vip.x = 252;
            this.addQuiackChild(txt_vip);
            txt_vipLevel1 = new TextField(70,43,'','',26,0xECAA3A,false);
            txt_vipLevel1.touchable = false;
            txt_vipLevel1.hAlign= 'left';
            txt_vipLevel1.text= '';
            txt_vipLevel1.y = 52;
            this.addQuiackChild(txt_vipLevel1);
            txt_vipLevel2 = new TextField(178,43,'','',26,0xECAA3A,false);
            txt_vipLevel2.touchable = false;
            txt_vipLevel2.hAlign= 'left';
            txt_vipLevel2.text= '';
            txt_vipLevel2.y = 111;
            this.addQuiackChild(txt_vipLevel2);
            txt_des17 = new TextField(66,43,'','',26,0xF4FC11,false);
            txt_des17.touchable = false;
            txt_des17.hAlign= 'center';
            txt_des17.text= '';
            txt_des17.x = 73;
            txt_des17.y = 52;
            this.addQuiackChild(txt_des17);
            txt_best = new TextField(520,43,'','',24,0xECAA3A,false);
            txt_best.touchable = false;
            txt_best.hAlign= 'left';
            txt_best.text= '';
            txt_best.x = 229;
            txt_best.y = 52;
            this.addQuiackChild(txt_best);
            txt_des5 = new TextField(177,43,'','',26,0xECAA3A,false);
            txt_des5.touchable = false;
            txt_des5.hAlign= 'left';
            txt_des5.text= '';
            txt_des5.y = 169;
            this.addQuiackChild(txt_des5);
            txt_des10 = new TextField(58,43,'','',26,0x66FF00,false);
            txt_des10.touchable = false;
            txt_des10.hAlign= 'left';
            txt_des10.text= '';
            txt_des10.y = 279;
            this.addQuiackChild(txt_des10);
            txt_speed = new TextField(52,43,'','',26,0xFFFF00,false);
            txt_speed.touchable = false;
            txt_speed.hAlign= 'center';
            txt_speed.text= '';
            txt_speed.x = 180;
            txt_speed.y = 169;
            this.addQuiackChild(txt_speed);
            txt_des6 = new TextField(71,43,'','',26,0xECAA3A,false);
            txt_des6.touchable = false;
            txt_des6.hAlign= 'left';
            txt_des6.text= '';
            txt_des6.x = 236;
            txt_des6.y = 169;
            this.addQuiackChild(txt_des6);
            txt_des2 = new TextField(82,43,'','',26,0xECAA3A,false);
            txt_des2.touchable = false;
            txt_des2.hAlign= 'center';
            txt_des2.text= '';
            txt_des2.x = 143;
            txt_des2.y = 52;
            this.addQuiackChild(txt_des2);
            txt_day = new TextField(566,43,'','',24,0xECAA3A,false);
            txt_day.touchable = false;
            txt_day.hAlign= 'left';
            txt_day.text= '';
            txt_day.x = 183;
            txt_day.y = 111;
            this.addQuiackChild(txt_day);
            txt_des7 = new TextField(177,43,'','',26,0xECAA3A,false);
            txt_des7.touchable = false;
            txt_des7.hAlign= 'left';
            txt_des7.text= '';
            txt_des7.y = 224;
            this.addQuiackChild(txt_des7);
            txt_chat = new TextField(46,43,'','',26,0xFFFF00,false);
            txt_chat.touchable = false;
            txt_chat.hAlign= 'center';
            txt_chat.text= '';
            txt_chat.x = 180;
            txt_chat.y = 224;
            this.addQuiackChild(txt_chat);
            txt_des8 = new TextField(64,43,'','',26,0xECAA3A,false);
            txt_des8.touchable = false;
            txt_des8.hAlign= 'left';
            txt_des8.text= '';
            txt_des8.x = 231;
            txt_des8.y = 224;
            this.addQuiackChild(txt_des8);
            txt_des9 = new TextField(108,43,'','',26,0xECAA3A,false);
            txt_des9.touchable = false;
            txt_des9.hAlign= 'center';
            txt_des9.text= '';
            txt_des9.x = 60;
            txt_des9.y = 279;
            this.addQuiackChild(txt_des9);
            txt_des13 = new TextField(88,43,'','',26,0x66FF00,false);
            txt_des13.touchable = false;
            txt_des13.hAlign= 'center';
            txt_des13.text= '';
            txt_des13.x = 174;
            txt_des13.y = 279;
            this.addQuiackChild(txt_des13);
            txt_des15 = new TextField(64,43,'','',26,0xECAA3A,false);
            txt_des15.touchable = false;
            txt_des15.hAlign= 'left';
            txt_des15.text= '';
            txt_des15.x = 317;
            txt_des15.y = 279;
            this.addQuiackChild(txt_des15);
            txt_tired = new TextField(44,43,'','',26,0xFFFF00,false);
            txt_tired.touchable = false;
            txt_tired.hAlign= 'center';
            txt_tired.text= '';
            txt_tired.x = 267;
            txt_tired.y = 279;
            this.addQuiackChild(txt_tired);
            txt_des14 = new TextField(145,43,'','',26,0xECAA3A,false);
            txt_des14.touchable = false;
            txt_des14.hAlign= 'center';
            txt_des14.text= '';
            txt_des14.x = 352;
            txt_des14.y = 279;
            this.addQuiackChild(txt_des14);
            txt_des16 = new TextField(64,43,'','',26,0xECAA3A,false);
            txt_des16.touchable = false;
            txt_des16.hAlign= 'left';
            txt_des16.text= '';
            txt_des16.x = 554;
            txt_des16.y = 279;
            this.addQuiackChild(txt_des16);
            txt_jingji = new TextField(51,43,'','',26,0xFFFF00,false);
            txt_jingji.touchable = false;
            txt_jingji.hAlign= 'center';
            txt_jingji.text= '';
            txt_jingji.x = 500;
            txt_jingji.y = 279;
            this.addQuiackChild(txt_jingji);
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
    }
}
