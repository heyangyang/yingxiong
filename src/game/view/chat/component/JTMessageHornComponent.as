package game.view.chat.component {
    import com.scene.SceneMgr;
    import com.utils.Constants;

    import flash.geom.Rectangle;
    import flash.text.TextFieldAutoSize;

    import game.common.JTGlobalFunction;
    import game.common.JTSession;
    import game.manager.AssetMgr;
    import game.net.data.s.SChat;
    import game.scene.GameLoadingScene;
    import game.view.viewBase.JTUIMessageNoticeBase;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

    /**
     * 喇叭横条
     * @author Administrator
     *
     */
    public class JTMessageHornComponent extends JTUIMessageNoticeBase {
        private static var notice:JTMessageHornComponent = null;
        private var container:Sprite = null;
        private static var messages:Vector.<SChat> = new Vector.<SChat>();
        private var isTween:Boolean = false;

        public function JTMessageHornComponent() {
            super();

        }

        override protected function init():void {
			txt_noticeTxt.touchable = bgImage.touchable = false;
			txt_noticeTxt.width = bgImage.width = Constants.virtualWidth;
            bgImage.alpha = 0.5;
			this.x = (Constants.virtualWidth - bgImage.width * Constants.scale) * .5;
			this.y = 90;

            this.removeChild(txt_noticeTxt);
            this.container = new Sprite();
            this.container.addChild(this.txt_noticeTxt);
            this.addChild(this.container);
            var horn_Texture:Texture = AssetMgr.instance.getTexture("ui_icon_chat1");
            var horn_Image:Image = new Image(horn_Texture);
            this.container.addChild(horn_Image);
            this.txt_noticeTxt.y = 0;
            //            this.txt_noticeTxt.isHtml = true;
            this.alpha = 0;
            this.clipRect = new Rectangle(0, 0, Constants.virtualWidth, bgImage.height);
            this.txt_noticeTxt.autoSize = TextFieldAutoSize.CENTER;
            this.txt_noticeTxt.autoScale = true;
            horn_Image.scaleX = .9;
            horn_Image.scaleY = .9;
            horn_Image.x = 0;
            horn_Image.y = 91 + horn_Image.height / 2 + 20;
            txt_noticeTxt.x = horn_Image.width + 5;
            this.container.x = Constants.FullScreenWidth;
        }

        public function initMessage(msg:SChat):void {
            this.alpha = 1;
            this.isTween = true;
            var content:String = msg.content;
            this.txt_noticeTxt.htmlText = "<font color='#33FCFC' face='方正综艺简体' size='32'><b>" + msg.name + "  </b></font>" + "<font color='#ff9900' face='方正综艺简体' size='32'><b>" + content + "</b></font>";
            Starling.juggler.tween(this.container, 20, {x: -txt_noticeTxt.textBounds.width, onComplete: onFinshTween});
        }

        private function onFinshTween():void {
            JTMessageHornComponent.close();

            if (messages.length > 0) {
                open(messages.shift());
            }
        }

        public function onReset():void {
            this.alpha = 0;
            this.isTween = false;
            this.container.x = Constants.FullScreenWidth;
            Starling.juggler.removeTweens(this.container);
        }

        public static function open(msg:SChat):void {
            if (SceneMgr.instance.getCurScene() is GameLoadingScene) {
                return;
            }

            if (!notice) {
                notice = new JTMessageHornComponent();
                JTGlobalFunction.autoAdaptiveSize(notice);
                JTSession.layerGlobal.addChild(notice);
            } else {
                JTMessageHornComponent.close(); // 出现重连时关掉喇叭消息
            }

            if (!notice.isTween) {
                notice.initMessage(msg);
            } else {
                messages.push(msg);
            }
        }

        public static function close():void {
            if (!notice) {
                return;
            }

            if (notice.alpha) {
                notice.onReset();
            }
        }
    }
}
