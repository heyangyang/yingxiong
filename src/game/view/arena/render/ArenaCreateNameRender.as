package game.view.arena.render {
    import game.data.GamePhotoData;
    import game.view.uitils.Res;
    import game.view.viewBase.ArenaCreateNameRenderBase;

    public class ArenaCreateNameRender extends ArenaCreateNameRenderBase {
        private var _picture:int;

        public function ArenaCreateNameRender() {
            super();
            ico_hero.container.addQuiackChild(head);
            ico_hero.container.addQuiackChild(mask);
        }

        override public function set data(value:Object):void {
            super.data = value;
            var photoData:GamePhotoData = value as GamePhotoData;
            picture = (GamePhotoData.hashMapPhoto.getValue(photoData.id) as GamePhotoData).picture; //人物头像
        }

        public function set picture(value:int):void {
            _picture = value;
            head.texture = Res.instance.getRolePhoto(value);
        }

        public function get picture():int {
            return _picture;
        }

    }
}
