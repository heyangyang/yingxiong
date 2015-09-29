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
    import com.view.View;

    public class CityActiveBarBase extends View
    {
        public var btn_notice:Button;
        public var btn_vipReward:Button;
        public var btn_qindao:Button;
        public var btn_fristpay:Button;
        public var btn_pay:Button;
        public var btn_giftButton:Button;

        public function CityActiveBarBase()
        {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            texture = assetMgr.getTexture('icon_gonggao_tubiao');
            btn_notice = new Button(texture);
            btn_notice.name= 'btn_notice';
            btn_notice.x = 352;
            btn_notice.width = 68;
            btn_notice.height = 68;
            this.addQuiackChild(btn_notice);
            texture = assetMgr.getTexture('icon_viplibao_tubiao');
            btn_vipReward = new Button(texture);
            btn_vipReward.name= 'btn_vipReward';
            btn_vipReward.x = 264;
            btn_vipReward.width = 68;
            btn_vipReward.height = 68;
            this.addQuiackChild(btn_vipReward);
            texture = assetMgr.getTexture('icon_qiandao_tubiao');
            btn_qindao = new Button(texture);
            btn_qindao.name= 'btn_qindao';
            btn_qindao.x = 176;
            btn_qindao.width = 68;
            btn_qindao.height = 68;
            this.addQuiackChild(btn_qindao);
            texture = assetMgr.getTexture('icon_shouchong_tubiao');
            btn_fristpay = new Button(texture);
            btn_fristpay.name= 'btn_fristpay';
            btn_fristpay.width = 68;
            btn_fristpay.height = 68;
            this.addQuiackChild(btn_fristpay);
            texture = assetMgr.getTexture('icon_chongzhi_tubiao');
            btn_pay = new Button(texture);
            btn_pay.name= 'btn_pay';
            btn_pay.x = 88;
            btn_pay.width = 68;
            btn_pay.height = 68;
            this.addQuiackChild(btn_pay);
            texture = assetMgr.getTexture('icon_baoxiang_tubiao');
            btn_giftButton = new Button(texture);
            btn_giftButton.name= 'btn_giftButton';
            btn_giftButton.x = 440;
            btn_giftButton.width = 68;
            btn_giftButton.height = 68;
            this.addQuiackChild(btn_giftButton);
            init();
        }
        public function get assetMgr():AssetManager{return AssetMgr.instance;}
        override public function dispose():void
        {
            btn_notice.dispose();
            btn_vipReward.dispose();
            btn_qindao.dispose();
            btn_fristpay.dispose();
            btn_pay.dispose();
            btn_giftButton.dispose();
            super.dispose();
        
}
    }
}
