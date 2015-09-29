/**
 * Created by Administrator on 2014/10/1.
 */
package game.view.rank {
    import com.langue.Langue;
    import com.utils.NumberDisplay;

    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.net.data.vo.RankInfo;
    import game.view.viewBase.RankRichRenderBase;

    import starling.display.Image;
    import starling.textures.Texture;

    /**
     *(排行榜)自己的排名
     * @author Administrator
     *
     */
    public class RankRichRender extends RankRichRenderBase {
        private var rankInfo:RankInfo;
        private var _head:Image;
        private var _indexNumber:NumberDisplay;

        public function RankRichRender() {
            super();
            bgImage1.alpha = 0.5;
            userName.fontName = "";
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (!value) {
                return;
            }

            var child:Image = this.getChildByName("icon_icon") as Image;
            if (child) {
                child.visible = false;
            }

            if (_indexNumber) {
                _indexNumber.visible = false;
            }

            rankInfo = value as RankInfo;
            icon.texture = AssetMgr.instance.getTexture("ui_pvp_renwutouxiang" + rankInfo.picture);

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
				valueTxt.text = GameMgr.instance.diamond + "";
				userName.text = rankInfo.name;
            }else {
				valueTxt.text = rankInfo.attr.toString();
				userName.text = rankInfo.name;
			}
           
        }
    }
}
