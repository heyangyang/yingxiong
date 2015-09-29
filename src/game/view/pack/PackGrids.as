package game.view.pack {
    import game.manager.AssetMgr;
    import game.view.magicShop.data.RockTween;
    import game.view.uitils.Res;

    import starling.display.Sprite;
    import starling.textures.Texture;

    public class PackGrids extends Sprite {
        private var tweenList:Array = [];
        public var isTween:Boolean;

        public function PackGrids() {
            super();
            createGrids();
        }

        private function createGrids():void {
            var i:int = 1;
            var length:int = 21;
            var row:int = 1;
            var maxRow:int = 7;
            var initX:int = 165;
            var initY:int = 60;
            var ver:int = 1;
            var gap:int = 10;
            var gapY:int = 30;

            var texture:Texture = Res.instance.getQualityToolTexture(0);
            var grid:PackGrid;
            for (i; i <= length; i++) {
                if (row > maxRow) {
                    row = 1;
                    ver++;
                }
                grid = new PackGrid(texture);
                addChild(grid);
                if (row == 1) {
                    grid.x = initX + gap;
                } else {
                    grid.x = initX + (row * gap) + (grid.width * (row - 1));
                }

                if (ver == 1) {
                    grid.y = initY + gapY;
                } else {
                    grid.y = initY + (ver * gapY) + (grid.height * (ver - 1));
                }
                row++;
            }
        }

        public function addGoodIcon(dataList:Vector.<Object>, openGrid:int, pageIndex:int = 1):void {
            var qidian:int = (pageIndex - 1) * 21;
            var length:int = 21 * (pageIndex);
            var grid:PackGrid;

            for (var i:int = 0; i < numChildren; i++) {
                grid = getChildAt(i) as PackGrid;
                if (qidian < openGrid) {
                    grid.data = dataList[qidian];
                } else {
                    grid.off();
                }
                qidian++;
            }
        }

        public function tween():void {
            var grid:PackGrid;
            for (var i:int = 0; i < numChildren; i++) {
                grid = getChildAt(i) as PackGrid;
                if (grid.data) {
                    tweenList.push(new RockTween(grid));
                }
            }
            isTween = true;
        }

        public function stopTween():void {
            var tw:RockTween;
            for (var i:int = 0; i < tweenList.length; i++) {
                tw = tweenList[i];
                tw.stop();
            }
            tweenList = [];
            isTween = false;
        }

        public function get tweenLength():int {
            return tweenList.length;
        }
    }
}
