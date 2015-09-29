package game.view.picture {
    import game.data.HeroData;
    import game.data.RoleShow;
    import game.data.Val;
    import game.manager.AssetMgr;
    import game.view.viewBase.PictureRenderBase;

    import starling.display.Image;
    import starling.filters.ColorMatrixFilter;

    public class PictureRender extends PictureRenderBase {
        private var photo:Image;

        override public function set data(value:Object):void {
            super.data = value;
            var heroData:HeroData = value as HeroData;
            if (heroData == null) {
                return;
            }
            txt_name.text = heroData.name;

            if (!photo) {
                photo = new Image(AssetMgr.instance.getTexture((RoleShow.hash.getValue(heroData.show) as RoleShow).photo));
                bg.container.addQuiackChildAt(photo, 1);
                bg.container.addQuiackChild(ico_hero);
                bg.container.addQuiackChild(txt_name);
            } else {
                photo.texture = AssetMgr.instance.getTexture((RoleShow.hash.getValue(heroData.show) as RoleShow).photo);
            }
//            tag.visible = heroData.isNew == 1;
//            ico_no.visible = !heroData.isGet;
            this.filter = new ColorMatrixFilter(heroData.isGet ? null : Val.filter);
        }
    }
}
