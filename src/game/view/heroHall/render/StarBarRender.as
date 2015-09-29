package game.view.heroHall.render {
    import game.manager.AssetMgr;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;

    /**
     * 星级条
     * @author Samuel
     *
     */
    public class StarBarRender extends Sprite {
        public function StarBarRender() {
            super();
        }

        /**
         * 传入星级
         * @param value
         *
         */
        public function updataStar(value:uint, scale:Number = 1, showType:uint = 1):void {
            while (this.numChildren > 0) {
                this.getChildAt(0).removeFromParent(true);
            }

            var star:Image = null;
            var textrue:Texture = null;
            var i:int = 0;
            if (showType == 3 || showType == 4) {

                textrue = AssetMgr.instance.getTexture("ui_xingyunxing02_tubiao");
                for (i = 0; i < 5; i++) {
                    star = new Image(textrue);
                    star.scaleX = scale;
                    star.scaleY = scale;
                    if (showType == 3) {
                        star.x = i * (star.width - 4);
                    } else if (showType == 4) {
                        star.y = i * star.height;
                    }
                    star.touchable = false;
                    addQuiackChild(star);
                }
            }

            if (value > 0) {
                textrue = AssetMgr.instance.getTexture("ui_xingyunxing01_tubiao");
                for (i = 0; i < value; i++) {
                    star = new Image(textrue);
                    star.scaleX = scale;
                    star.scaleY = scale;
                    if (showType == 1 || showType == 3) {
                        star.x = i * (star.width - 4);
                    } else if (showType == 2) {
                        star.y = i * star.height;
                    } else if (showType == 4) {
                        star.y = (4 - i) * star.height;
                    }
                    star.touchable = false;
                    addQuiackChild(star);
                }
            }
        }

        public function offsetXY(offsetX:Number, offsetY:Number):void {
            this.x = offsetX;
            this.y = offsetY;
        }

        override public function dispose():void {
            super.dispose();
        }

    }
}
