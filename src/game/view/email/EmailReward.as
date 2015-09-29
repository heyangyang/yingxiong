package game.view.email {
    import com.langue.Langue;
    import com.view.View;

    import game.data.Goods;
    import game.data.HeroData;
    import game.data.RoleShow;
    import game.manager.AssetMgr;
    import game.net.data.vo.mailItems;
    import game.view.uitils.Res;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.text.TextField;

    /**
     * 邮件物品奖励
     * @author hyy
     */
    public class EmailReward extends View {
        private var view:Sprite;
        private var bgBtn:Button;
        private var icon:Image;
        private var _quality:Image;
        private var _hun:Image;
        private var text_num:TextField;

        public function EmailReward(view:Sprite, isAutoInit:Boolean = false) {
            super(isAutoInit);
            this.view = view;

            this.bgBtn = view.getChildByName("bg") as Button;
            this.icon = view.getChildByName("icon") as Image;
            this._quality = view.getChildByName("quality") as Image;
            this._hun = view.getChildByName("hun") as Image;
            _hun.visible = false;
            this.text_num = view.getChildByName("txt_num") as TextField;

            bgBtn.container.addChild(icon);
            bgBtn.container.addChild(_quality);
            bgBtn.container.addChild(_hun);
            bgBtn.container.addChild(text_num);
        }

        public function set data(data:Object):void {
            var item:mailItems = data as mailItems;
            var icon_type:String = "ui_button_mail";
            var type:int = item ? item.type : 0;

            view.visible = _quality.visible = visible = data != null;
            _quality.texture = Res.instance.getQualityToolTexture(0);
            text_num.text = (item ? "x " + item.num : "");

            /*	# 1=金币,
               # 2=钻石,
               # 3=幸运星,
               # 5=英雄,
               # 7=疲劳值,
             # 大于100 = 物品ID*/
            switch (type) {
                case 0:
                    icon_type = "ui_button_mail";
                    break;
                case 1:
                    icon_type = Res.instance.getCommTextures(10);
                    break;
                case 2:
                    icon_type = Res.instance.getCommTextures(11);
                    break;
                case 3:
                    icon_type = Res.instance.getCommTextures(12);
                    break;
                case 5:
                    var heroData:HeroData = HeroData.hero.getValue(item.num);
                    if (heroData == null) {
                        addTips(Langue.getLangue("NO_HERO_Value") + item.custom); //没有该英雄
                        break;
                    }
                    icon_type = (RoleShow.hash.getValue(heroData.show) as RoleShow).photo;
                    _quality.texture = Res.instance.getQualityHeroTexture(item.custom);
                    text_num.text = "x 1";
                    break;
                default:
                    var goods:Goods = (Goods.goods.getValue(item.type) as Goods);
                    if (goods == null) {
                        addTips(Langue.getLangue("NO_Goods_Value") + item.type); //没有该物品
                        break;
                    }

                    icon_type = goods.picture;
                    if (goods.type > 30000 && goods.type < 40000 || goods.type < 100 && goods.type != 5) {
                        if (goods.type < 100 && goods.type != 5) {
                            _hun.visible = false;
                        } else {
                            _hun.visible = true;
                        }
                        _quality.texture = Res.instance.getQualityToolTexture(0);
                    } else {
                        _quality.texture = Res.instance.getQualityToolTexture(goods.quality);
                    }
                    break;
            }
            icon.texture = AssetMgr.instance.getTexture(icon_type);
            icon.visible = data == "1" ? true : item;
        }
    }
}
