package game.dialog {
    import com.utils.Assets;
    import com.utils.Constants;
    import com.view.View;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.text.TextField;
    import starling.utils.deg2rad;
    import starling.utils.rad2deg;

    /**
     * 转圈圈的加载动画
     * @author Michael
     *
     */
    public class ShowLoader extends View {
        private var _load:Sprite;
        private var mask:Quad;
        private var txt:TextField;
        private var loadbg:Image;
        private static var _instance:ShowLoader;

        public function ShowLoader() {
            super();
        }

        override protected function init():void {
            mask = Assets.getImage(Assets.Alpha_Backgroud);
            mask.width = Constants.FullScreenWidth;
            mask.height = Constants.FullScreenHeight;
            mask.alpha = 0.1;
            mask.touchable = true;
            addQuiackChild(mask);

            _load = new Sprite();
            var load:Image = Assets.getImage(Assets.LoadingICO);
            _load.scaleX = _load.scaleY = Constants.scale;

            load.x = -load.width / 2;
            load.y = -load.height / 2;

            //网络加载圈的底
            loadbg = Assets.getImage(Assets.LoadingICO_BG);
            loadbg.scaleX = loadbg.scaleY = Constants.scale;
            loadbg.x = -loadbg.width / 2;
            loadbg.y = -loadbg.height / 2;
            addQuiackChild(loadbg);
            loadbg.visible = false;

            txt = new TextField(200, 24, "", "", 18, 0xffffff);
            txt.hAlign = 'center';
            _load.addQuiackChild(load);
            _load.touchable = false;
            addQuiackChild(txt);
            addQuiackChild(_load);
        }

        override public function move(x:Number, y:Number):void {
            y -= txt.height;
            load.x = x;
            load.y = y;

            loadbg.x = x - (loadbg.width) * .5;
            loadbg.y = y - loadbg.height * .5;

            txt.x = x - (txt.width) * .5;
            txt.y = loadbg.height + loadbg.y;
        }

        public function get load():Sprite {
            return _load;
        }

        public static function add(text:String = ""):void {
            if (_instance) {
                _instance.remove();
            }

            if (_instance == null) {
                _instance = new ShowLoader();
            }
            _instance.txt.text = text;
            _instance.move(.5 * (Starling.current.stage.stageWidth), .5 * (Starling.current.stage.stageHeight));
            Starling.current.stage.addChild(_instance);
            Starling.juggler.tween(_instance.load, 1.5, {repeatCount: 99999, rotation: deg2rad(360 + rad2deg(_instance.load.rotation))});
        }


        public function remove():void {
            Starling.juggler.removeTweens(load);
            removeFromParent();
        }

        public static function remove():void {
            if (_instance)
                _instance.remove();
        }
    }
}
