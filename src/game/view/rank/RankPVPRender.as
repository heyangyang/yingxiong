/**
 * Created by Administrator on 2014/10/3 0003.
 */
package game.view.rank {
    import com.langue.Langue;
    import com.utils.NumberDisplay;
    
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.net.data.vo.RankInfo;
    import game.view.uitils.Res;
    import game.view.viewBase.RankPVPRenderBase;
    
    import starling.display.Image;
    import starling.textures.Texture;

    public class RankPVPRender extends RankPVPRenderBase {
        private var rankInfo:RankInfo;
        private var _head:Image;
        private var _indexNumber:NumberDisplay;

        public function RankPVPRender() {
            super();
            userName.fontName = "";
            bgImage1.alpha = 0.5;
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (!value) {
                return;
            }
            rankInfo = value as RankInfo;

            var child:Image = this.getChildByName("icon_icon") as Image;
            if (child) {
                child.visible = false;
            }

            if (_indexNumber) {
                _indexNumber.visible = false;
            }
            icon.texture = Res.instance.getRolePhoto(rankInfo.picture);

            if (rankInfo.index > 3) {
                if (!_indexNumber) {
                    _indexNumber = NumberDisplay.create(AssetMgr.instance, "ui_paihangshuzi_", 26, NumberDisplay.CENTER);
                    _indexNumber.x = 54;
                    _indexNumber.y = 20;
                    addQuiackChild(_indexNumber);
                }
                _indexNumber.number = rankInfo.index;
                _indexNumber.visible = true;
            } else {
                var texture:Texture = AssetMgr.instance.getTexture("ui_paihangshuzi_01_0" + rankInfo.index);
                if (!child) {
                    child = new Image(texture);
                    child.name = "icon_icon";
                    child.x = 32;
                    child.y = 18;
                    this.addQuiackChild(child);
                }
                child.texture = texture;
                child.visible = true;
            }

            if (rankInfo.index > 50) {
                _indexNumber.visible = false;
                txt_rank.text = Langue.getLangue("NO_List_RANK"); //未上榜
                valueTxt.text = GameMgr.instance.honor + "";
                userName.text = rankInfo.name;
            } else {
                valueTxt.text = rankInfo.attr.toString();
                userName.text = rankInfo.name;
            }
        }

        override public function dispose():void {
            rankInfo = null;
            _head && _head.removeFromParent(true);
            _indexNumber && _indexNumber.removeFromParent(true);
            super.dispose();
        }
    }
}
