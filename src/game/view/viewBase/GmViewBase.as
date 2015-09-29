package game.view.viewBase {
    import com.components.TabButton;
    import com.components.TabMenu;
    import com.dialog.Dialog;
    import com.utils.Constants;

    import flash.geom.Rectangle;

    import feathers.controls.TextInput;
    import feathers.display.Scale9Image;
    import feathers.textures.Scale9Textures;

    import game.manager.AssetMgr;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.textures.Texture;

    public class GmViewBase extends Dialog {
        public var info:TextField;
        public var btn_lookgoods:Button;
        public var btn_lookHero:Button;
        public var tab_exp:TabButton;
        public var tab_tired:TabButton;
        public var tab_diamond:TabButton;
        public var tab_goods:TabButton;
        public var tab_guan:TabButton;
        public var tab_mail:TabButton;
        public var tab_money:TabButton;
        public var tab_hero:TabButton;
        public var tab_vip:TabButton;
        public var btn_ok:Button;
        public var tabMenu_hero:TabMenu;
        public var view_type:Sprite;
        public var view_num:Sprite;
        public var view_quality:Sprite;
        public var btn_lookjingjie:Button;
        public var btn_lookGem:Button;
        public var btn_lookstrengthen:Button;
        public var btn_lookEquip:Button;
        public var txt_filter:TextInput;
        public var txt_des13:TextField;
        public var ui_tipstanchukuangdi01_jiemian00:Scale9Image;

        public function GmViewBase() {
            super(false);
            var texture:Texture;
            var textField:TextField;
            var input_txt:TextInput;
            var image:Image;
            var button:Button;
            var assetMgr:AssetMgr = AssetMgr.instance;
            texture = assetMgr.getTexture('ui_tipstanchukuangdi01_jiemian');
            var ui_tipstanchukuangdi01_jiemian00Rect:Rectangle = new Rectangle(68, 64, 6, 6);
            var ui_tipstanchukuangdi01_jiemian009ScaleTexture:Scale9Textures = new Scale9Textures(texture, ui_tipstanchukuangdi01_jiemian00Rect);
            ui_tipstanchukuangdi01_jiemian00 = new Scale9Image(ui_tipstanchukuangdi01_jiemian009ScaleTexture);
            ui_tipstanchukuangdi01_jiemian00.width = 840;
            ui_tipstanchukuangdi01_jiemian00.height = 600;
            this.addQuiackChild(ui_tipstanchukuangdi01_jiemian00);
            info = new TextField(722, 243, '', '', 20, 0x4D1F09, false);
            info.touchable = false;
            info.hAlign = 'left';
            info.text = '';
            info.x = 56;
            info.y = 280;
            this.addQuiackChild(info);
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            btn_lookgoods = new Button(texture);
            btn_lookgoods.name = 'btn_lookgoods';
            btn_lookgoods.x = 154;
            btn_lookgoods.y = 44;
            btn_lookgoods.width = 100;
            btn_lookgoods.height = 43;
            this.addQuiackChild(btn_lookgoods);
            btn_lookgoods.text = 'Material';
            btn_lookgoods.fontColor = 0xFFFFCC;
            btn_lookgoods.fontSize = 24;
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            btn_lookHero = new Button(texture);
            btn_lookHero.name = 'btn_lookHero';
            btn_lookHero.x = 52;
            btn_lookHero.y = 44;
            btn_lookHero.width = 100;
            btn_lookHero.height = 43;
            this.addQuiackChild(btn_lookHero);
            btn_lookHero.text = 'Hero';
            btn_lookHero.fontColor = 0xFFFFCC;
            btn_lookHero.fontSize = 24;
            tab_exp = new TabButton(assetMgr.getTexture('ui_hong03_01_anniu'), assetMgr.getTexture('ui_lv03_01_anniu'));
            tab_exp.x = 52;
            tab_exp.y = 100;
            tab_exp.width = 120;
            tab_exp.height = 51;
            this.addQuiackChild(tab_exp);
            tab_exp.text = 'EXP';
            tab_exp.fontColor = 0xFFFFCC;
            tab_exp.fontSize = 24;
            tab_tired = new TabButton(assetMgr.getTexture('ui_hong03_01_anniu'), assetMgr.getTexture('ui_lv03_01_anniu'));
            tab_tired.x = 181;
            tab_tired.y = 100;
            tab_tired.width = 120;
            tab_tired.height = 51;
            this.addQuiackChild(tab_tired);
            tab_tired.text = 'Fatigue';
            tab_tired.fontColor = 0xFFFFFF;
            tab_tired.fontSize = 26;
            tab_diamond = new TabButton(assetMgr.getTexture('ui_hong03_01_anniu'), assetMgr.getTexture('ui_lv03_01_anniu'));
            tab_diamond.x = 52;
            tab_diamond.y = 162;
            tab_diamond.width = 120;
            tab_diamond.height = 51;
            this.addQuiackChild(tab_diamond);
            tab_diamond.text = 'Diamond';
            tab_diamond.fontColor = 0xFFFFCC;
            tab_diamond.fontSize = 24;
            tab_goods = new TabButton(assetMgr.getTexture('ui_hong03_01_anniu'), assetMgr.getTexture('ui_lv03_01_anniu'));
            tab_goods.x = 436;
            tab_goods.y = 100;
            tab_goods.width = 120;
            tab_goods.height = 51;
            this.addQuiackChild(tab_goods);
            tab_goods.text = 'Items';
            tab_goods.fontColor = 0xFFFFCC;
            tab_goods.fontSize = 24;
            tab_guan = new TabButton(assetMgr.getTexture('ui_hong03_01_anniu'), assetMgr.getTexture('ui_lv03_01_anniu'));
            tab_guan.x = 559;
            tab_guan.y = 100;
            tab_guan.width = 120;
            tab_guan.height = 51;
            this.addQuiackChild(tab_guan);
            tab_guan.text = 'Points';
            tab_guan.fontColor = 0xFFFFCC;
            tab_guan.fontSize = 24;
            tab_mail = new TabButton(assetMgr.getTexture('ui_hong03_01_anniu'), assetMgr.getTexture('ui_lv03_01_anniu'));
            tab_mail.x = 308;
            tab_mail.y = 100;
            tab_mail.width = 120;
            tab_mail.height = 51;
            this.addQuiackChild(tab_mail);
            tab_mail.text = 'E-Mail';
            tab_mail.fontColor = 0xFFFFCC;
            tab_mail.fontSize = 24;
            tab_money = new TabButton(assetMgr.getTexture('ui_hong03_01_anniu'), assetMgr.getTexture('ui_lv03_01_anniu'));
            tab_money.x = 181;
            tab_money.y = 162;
            tab_money.width = 120;
            tab_money.height = 51;
            this.addQuiackChild(tab_money);
            tab_money.text = 'Gold';
            tab_money.fontColor = 0xFFFFCC;
            tab_money.fontSize = 24;
            tab_hero = new TabButton(assetMgr.getTexture('ui_hong03_01_anniu'), assetMgr.getTexture('ui_lv03_01_anniu'));
            tab_hero.x = 309;
            tab_hero.y = 162;
            tab_hero.width = 120;
            tab_hero.height = 51;
            this.addQuiackChild(tab_hero);
            tab_hero.text = 'Hero';
            tab_hero.fontColor = 0xFFFFCC;
            tab_hero.fontSize = 24;
            tab_vip = new TabButton(assetMgr.getTexture('ui_hong03_01_anniu'), assetMgr.getTexture('ui_lv03_01_anniu'));
            tab_vip.x = 435;
            tab_vip.y = 162;
            tab_vip.width = 120;
            tab_vip.height = 51;
            this.addQuiackChild(tab_vip);
            tab_vip.text = 'vip';
            tab_vip.fontColor = 0xFFFFCC;
            tab_vip.fontSize = 24;
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            btn_ok = new Button(texture);
            btn_ok.name = 'btn_ok';
            btn_ok.x = 674;
            btn_ok.y = 220;
            btn_ok.width = 120;
            btn_ok.height = 51;
            this.addQuiackChild(btn_ok);
            btn_ok.text = 'Send';
            btn_ok.fontColor = 0xFFFF00;
            btn_ok.fontSize = 24;
            tabMenu_hero = new TabMenu([tab_exp, tab_tired, tab_mail, tab_goods, tab_guan, tab_diamond, tab_money, tab_hero,
                                        tab_vip]);
            tabMenu_hero.x = 52;
            tabMenu_hero.y = 100;
            this.addQuiackChild(tabMenu_hero);
            view_type = new Sprite();
            view_type.x = 57;
            view_type.y = 232;
            view_type.width = 195;
            view_type.height = 33;
            this.addQuiackChild(view_type);
            view_type.name = 'view_type';
            texture = assetMgr.getTexture('ui_yingxionghundi_jindutiao');
            image = new Image(texture);
            image.x = 75;
            image.width = 120;
            image.height = 31;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            view_type.addQuiackChild(image);
            input_txt = new TextInput();
            input_txt.name = 'txt_input';
            input_txt.textEditorProperties.fontSize = 24;
            input_txt.text = '';
            input_txt.textEditorProperties.color = 0xFFFFFF;
            input_txt.x = 85;
            input_txt.width = 95;
            input_txt.height = 33;
            view_type.addQuiackChild(input_txt);
            textField = new TextField(68, 33, '', '', 20, 0xFFFFFF, false);
            textField.touchable = false;
            textField.hAlign = 'center';
            textField.text = 'Type';
            textField.name = 'txt_des1';
            view_type.addQuiackChild(textField);
            view_num = new Sprite();
            view_num.x = 259;
            view_num.y = 232;
            view_num.width = 195;
            view_num.height = 35;
            this.addQuiackChild(view_num);
            view_num.name = 'view_num';
            texture = assetMgr.getTexture('ui_yingxionghundi_jindutiao');
            image = new Image(texture);
            image.x = 75;
            image.width = 120;
            image.height = 31;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            view_num.addQuiackChild(image);
            input_txt = new TextInput();
            input_txt.name = 'txt_input';
            input_txt.textEditorProperties.fontSize = 24;
            input_txt.text = '';
            input_txt.textEditorProperties.color = 0xFFFFFF;
            input_txt.x = 85;
            input_txt.width = 95;
            input_txt.height = 33;
            view_num.addQuiackChild(input_txt);
            textField = new TextField(68, 35, '', '', 20, 0xFFFFFF, false);
            textField.touchable = false;
            textField.hAlign = 'center';
            textField.text = 'Nubmer';
            textField.name = 'txt_des2';
            view_num.addQuiackChild(textField);
            view_quality = new Sprite();
            view_quality.x = 469;
            view_quality.y = 232;
            view_quality.width = 195;
            view_quality.height = 33;
            this.addQuiackChild(view_quality);
            view_quality.name = 'view_quality';
            texture = assetMgr.getTexture('ui_yingxionghundi_jindutiao');
            image = new Image(texture);
            image.x = 75;
            image.width = 120;
            image.height = 31;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            view_quality.addQuiackChild(image);
            input_txt = new TextInput();
            input_txt.name = 'txt_input';
            input_txt.textEditorProperties.fontSize = 24;
            input_txt.text = '';
            input_txt.textEditorProperties.color = 0xFFFFFF;
            input_txt.x = 85;
            input_txt.width = 95;
            input_txt.height = 33;
            view_quality.addQuiackChild(input_txt);
            textField = new TextField(68, 33, '', '', 20, 0x000000, false);
            textField.touchable = false;
            textField.hAlign = 'center';
            textField.text = 'Quality';
            textField.name = 'txt_des3';
            view_quality.addQuiackChild(textField);
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            btn_lookjingjie = new Button(texture);
            btn_lookjingjie.name = 'btn_lookjingjie';
            btn_lookjingjie.x = 257;
            btn_lookjingjie.y = 44;
            btn_lookjingjie.width = 100;
            btn_lookjingjie.height = 43;
            this.addQuiackChild(btn_lookjingjie);
            btn_lookjingjie.text = 'Purify';
            btn_lookjingjie.fontColor = 0xFFFFCC;
            btn_lookjingjie.fontSize = 24;
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            btn_lookGem = new Button(texture);
            btn_lookGem.name = 'btn_lookGem';
            btn_lookGem.x = 361;
            btn_lookGem.y = 44;
            btn_lookGem.width = 100;
            btn_lookGem.height = 43;
            this.addQuiackChild(btn_lookGem);
            btn_lookGem.text = 'Gem';
            btn_lookGem.fontColor = 0xFFFFCC;
            btn_lookGem.fontSize = 24;
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            btn_lookstrengthen = new Button(texture);
            btn_lookstrengthen.name = 'btn_lookstrengthen';
            btn_lookstrengthen.x = 467;
            btn_lookstrengthen.y = 44;
            btn_lookstrengthen.width = 100;
            btn_lookstrengthen.height = 43;
            this.addQuiackChild(btn_lookstrengthen);
            btn_lookstrengthen.text = 'Stones';
            btn_lookstrengthen.fontColor = 0xFFFFCC;
            btn_lookstrengthen.fontSize = 24;
            texture = assetMgr.getTexture('ui_hong03_01_anniu');
            btn_lookEquip = new Button(texture);
            btn_lookEquip.name = 'btn_lookEquip';
            btn_lookEquip.x = 572;
            btn_lookEquip.y = 44;
            btn_lookEquip.width = 100;
            btn_lookEquip.height = 43;
            this.addQuiackChild(btn_lookEquip);
            btn_lookEquip.text = 'Equipment';
            btn_lookEquip.fontColor = 0xFFFFCC;
            btn_lookEquip.fontSize = 24;
            texture = assetMgr.getTexture('ui_yingxionghundi_jindutiao');
            image = new Image(texture);
            image.x = 680;
            image.y = 530;
            image.width = 120;
            image.height = 31;
            image.touchable = false;
            image.smoothing = Constants.smoothing;
            this.addQuiackChild(image);
            txt_filter = new TextInput();
            txt_filter.textEditorProperties.fontSize = 24;
            txt_filter.text = '';
            txt_filter.textEditorProperties.color = 0xFFFFFF;
            txt_filter.x = 702;
            txt_filter.y = 530;
            txt_filter.width = 95;
            txt_filter.height = 33;
            this.addQuiackChild(txt_filter);
            txt_des13 = new TextField(68, 33, '', '', 20, 0xFFFFFF, false);
            txt_des13.touchable = false;
            txt_des13.hAlign = 'center';
            txt_des13.text = 'Filter';
            txt_des13.x = 620;
            txt_des13.y = 530;
            this.addQuiackChild(txt_des13);
            init();
        }

        override public function dispose():void {
            btn_lookgoods.dispose();
            btn_lookHero.dispose();
            tab_exp.dispose();
            tab_tired.dispose();
            tab_diamond.dispose();
            tab_goods.dispose();
            tab_guan.dispose();
            tab_mail.dispose();
            tab_money.dispose();
            tab_hero.dispose();
            tab_vip.dispose();
            btn_ok.dispose();
            tabMenu_hero.dispose();
            view_type.dispose();
            view_num.dispose();
            view_quality.dispose();
            btn_lookjingjie.dispose();
            btn_lookGem.dispose();
            btn_lookstrengthen.dispose();
            btn_lookEquip.dispose();
            txt_filter.dispose();
            super.dispose();

        }
    }
}