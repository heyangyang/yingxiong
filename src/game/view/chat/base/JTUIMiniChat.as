package game.view.chat.base {
    import game.base.JTSprite;
    import game.manager.AssetMgr;

    import starling.display.Button;
    import starling.textures.Texture;

    public class JTUIMiniChat extends JTSprite {
        public static var btn_maxButton:Button;

        public function JTUIMiniChat() {
            var btn_maxTexture:Texture = AssetMgr.instance.getTexture('icon_liaotian_tubiao');
            btn_maxButton = new Button(btn_maxTexture);
            btn_maxButton.x = -5;
            btn_maxButton.width = 80;
            btn_maxButton.height = 98;
            addChild(btn_maxButton);
        }

        override public function dispose():void {
            btn_maxButton.dispose();
            super.dispose();
        }
    }
}
