package game.view.rank.ui {
    import com.utils.Constants;

    import game.base.JTSprite;
    import game.manager.AssetMgr;

    import starling.display.Button;
    import starling.display.Image;
    import starling.text.TextField;
    import starling.textures.Texture;

    public class JTUIHeroProperty extends JTSprite {
        public var attackIconButton:Button;
        public var hpIconButton:Button;
        public var defenseValueTxt:TextField;
        public var hitValueTxt:TextField;
        public var CritValueTxt:TextField;
        public var freeBurstValueTxt:TextField;
        public var punctureValueTxt:TextField;
        public var duckValueTxt:TextField;
        public var StrongstormValulTxt:TextField;
        public var toughnessValueTxt:TextField;
        public var hpTxt:TextField;
        public var attackTxt:TextField;
        public var defenseTxt:TextField;
        public var hitTxt:TextField;
        public var CritTxt:TextField;
        public var freeBurstTxt:TextField;
        public var punctureTxt:TextField;
        public var duckTxt:TextField;
        public var StrongstormTxt:TextField;
        public var toughnessTxt:TextField;
        public var skillTitleTxt:TextField;

        public function JTUIHeroProperty() {
            var attackIconTexture:Texture = AssetMgr.instance.getTexture('ui_tubiao_gongjilitubiao');
            attackIconButton = new Button(attackIconTexture);
            attackIconButton.x = 71;
            attackIconButton.y = 53;
            this.addQuiackChild(attackIconButton);
            var hpIconTexture:Texture = AssetMgr.instance.getTexture('ui_tubiao_xueliangtubiao');
            hpIconButton = new Button(hpIconTexture);
            hpIconButton.x = 59;
            hpIconButton.y = 94;
            this.addQuiackChild(hpIconButton);
            defenseValueTxt = new TextField(83, 26, '', '', 18, 0x1A1A1A, false);
            defenseValueTxt.touchable = false;
            defenseValueTxt.hAlign = 'left';
            defenseValueTxt.x = 78;
            defenseValueTxt.y = 135;
            this.addQuiackChild(defenseValueTxt);
            hitValueTxt = new TextField(82, 26, '', '', 18, 0x1A1A1A, false);
            hitValueTxt.touchable = false;
            hitValueTxt.hAlign = 'left';
            hitValueTxt.x = 78;
            hitValueTxt.y = 163;
            this.addQuiackChild(hitValueTxt);
            CritValueTxt = new TextField(82, 26, '', '', 18, 0x1A1A1A, false);
            CritValueTxt.touchable = false;
            CritValueTxt.hAlign = 'left';
            CritValueTxt.x = 78;
            CritValueTxt.y = 192;
            this.addQuiackChild(CritValueTxt);
            freeBurstValueTxt = new TextField(81, 26, '', '', 18, 0x1A1A1A, false);
            freeBurstValueTxt.touchable = false;
            freeBurstValueTxt.hAlign = 'left';
            freeBurstValueTxt.x = 78;
            freeBurstValueTxt.y = 220;
            this.addQuiackChild(freeBurstValueTxt);
            punctureValueTxt = new TextField(95, 26, '', '', 18, 0x1A1A1A, false);
            punctureValueTxt.touchable = false;
            punctureValueTxt.hAlign = 'left';
            punctureValueTxt.x = 226;
            punctureValueTxt.y = 135;
            this.addQuiackChild(punctureValueTxt);
            duckValueTxt = new TextField(95, 26, '', '', 18, 0x1A1A1A, false);
            duckValueTxt.touchable = false;
            duckValueTxt.hAlign = 'left';
            duckValueTxt.x = 225;
            duckValueTxt.y = 163;
            this.addQuiackChild(duckValueTxt);
            StrongstormValulTxt = new TextField(95, 26, '', '', 18, 0x1A1A1A, false);
            StrongstormValulTxt.touchable = false;
            StrongstormValulTxt.hAlign = 'left';
            StrongstormValulTxt.x = 225;
            StrongstormValulTxt.y = 192;
            this.addQuiackChild(StrongstormValulTxt);
            toughnessValueTxt = new TextField(95, 26, '', '', 18, 0x1A1A1A, false);
            toughnessValueTxt.touchable = false;
            toughnessValueTxt.hAlign = 'left';
            toughnessValueTxt.x = 227;
            toughnessValueTxt.y = 220;
            this.addQuiackChild(toughnessValueTxt);
            var ui_gongyong_shuxingwenzidi9197Texture:Texture = AssetMgr.instance.getTexture('ui_gongyong_shuxingwenzidi');
            var ui_gongyong_shuxingwenzidi9197Image:Image = new Image(ui_gongyong_shuxingwenzidi9197Texture);
            ui_gongyong_shuxingwenzidi9197Image.x = 91;
            ui_gongyong_shuxingwenzidi9197Image.y = 97;
            ui_gongyong_shuxingwenzidi9197Image.width = 172;
            ui_gongyong_shuxingwenzidi9197Image.height = 27;
            ui_gongyong_shuxingwenzidi9197Image.smoothing = Constants.smoothing;
            ui_gongyong_shuxingwenzidi9197Image.touchable = false;
            this.addQuiackChild(ui_gongyong_shuxingwenzidi9197Image);
            hpTxt = new TextField(180, 31, '', '', 22, 0xFFFFFF, false);
            hpTxt.touchable = false;
            hpTxt.hAlign = 'center';
            hpTxt.x = 77;
            hpTxt.y = 97;
            this.addQuiackChild(hpTxt);
            var ui_gongyong_shuxingwenzidi9157Texture:Texture = AssetMgr.instance.getTexture('ui_gongyong_shuxingwenzidi');
            var ui_gongyong_shuxingwenzidi9157Image:Image = new Image(ui_gongyong_shuxingwenzidi9157Texture);
            ui_gongyong_shuxingwenzidi9157Image.x = 91;
            ui_gongyong_shuxingwenzidi9157Image.y = 57;
            ui_gongyong_shuxingwenzidi9157Image.width = 172;
            ui_gongyong_shuxingwenzidi9157Image.height = 27;
            ui_gongyong_shuxingwenzidi9157Image.smoothing = Constants.smoothing;
            ui_gongyong_shuxingwenzidi9157Image.touchable = false;
            this.addQuiackChild(ui_gongyong_shuxingwenzidi9157Image);
            attackTxt = new TextField(180, 31, '', '', 22, 0xFFFFFF, false);
            attackTxt.touchable = false;
            attackTxt.hAlign = 'center';
            attackTxt.x = 78;
            attackTxt.y = 57;
            this.addQuiackChild(attackTxt);
            defenseTxt = new TextField(70, 26, '', '', 18, 0x1A1A1A, false);
            defenseTxt.touchable = false;
            defenseTxt.hAlign = 'right';
            defenseTxt.x = 8;
            defenseTxt.y = 135;
            this.addQuiackChild(defenseTxt);
            hitTxt = new TextField(71, 26, '', '', 18, 0x1A1A1A, false);
            hitTxt.touchable = false;
            hitTxt.hAlign = 'right';
            hitTxt.x = 7;
            hitTxt.y = 163;
            this.addQuiackChild(hitTxt);
            CritTxt = new TextField(71, 26, '', '', 18, 0x1A1A1A, false);
            CritTxt.touchable = false;
            CritTxt.hAlign = 'right';
            CritTxt.x = 8;
            CritTxt.y = 192;
            this.addQuiackChild(CritTxt);
            freeBurstTxt = new TextField(71, 26, '', '', 18, 0x1A1A1A, false);
            freeBurstTxt.touchable = false;
            freeBurstTxt.hAlign = 'right';
            freeBurstTxt.x = 8;
            freeBurstTxt.y = 220;
            this.addQuiackChild(freeBurstTxt);
            punctureTxt = new TextField(60, 26, '', '', 18, 0x1A1A1A, false);
            punctureTxt.touchable = false;
            punctureTxt.hAlign = 'right';
            punctureTxt.x = 165;
            punctureTxt.y = 135;
            this.addQuiackChild(punctureTxt);
            duckTxt = new TextField(61, 27, '', '', 18, 0x1A1A1A, false);
            duckTxt.touchable = false;
            duckTxt.hAlign = 'right';
            duckTxt.x = 165;
            duckTxt.y = 163;
            this.addQuiackChild(duckTxt);
            StrongstormTxt = new TextField(59, 26, '', '', 18, 0x1A1A1A, false);
            StrongstormTxt.touchable = false;
            StrongstormTxt.hAlign = 'right';
            StrongstormTxt.x = 166;
            StrongstormTxt.y = 192;
            this.addQuiackChild(StrongstormTxt);
            toughnessTxt = new TextField(61, 26, '', '', 18, 0x1A1A1A, false);
            toughnessTxt.touchable = false;
            toughnessTxt.hAlign = 'right';
            toughnessTxt.x = 165;
            toughnessTxt.y = 220;
            this.addQuiackChild(toughnessTxt);
            skillTitleTxt = new TextField(151, 37, '', '', 30, 0x593F1F, false);
            skillTitleTxt.touchable = false;
            skillTitleTxt.hAlign = 'center';
            skillTitleTxt.x = 91;
            skillTitleTxt.y = 10;
            this.addQuiackChild(skillTitleTxt);

        }

        override public function dispose():void {
            attackIconButton.dispose();
            hpIconButton.dispose();
            super.dispose();

        }

    }
}