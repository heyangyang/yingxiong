package game.view.replacePhotoList {
    import game.data.GamePhotoData;
    import game.view.uitils.Res;
    import game.view.viewBase.SinglePhotoViewBase;

    public class NewGamePhotoRender extends SinglePhotoViewBase {
        public function NewGamePhotoRender() {
            setSize(84, 84);
            potoBg.container.addChild(imagePh);
            potoBg.container.addChild(mask);
//            potoBg.container.addChild(imageVip);
//            potoBg.container.addChild(txt_Level);
        }

        override public function set data(value:Object):void {
            super.data = value;
            var photoData:GamePhotoData = value as GamePhotoData;
//            txt_Level.text = photoData.name + "";

            imagePh.texture = Res.instance.getRolePhoto((GamePhotoData.hashMapPhoto.getValue(photoData.id) as GamePhotoData).picture); //人物头像
//            imageVip.visible = false;
        }
    }
}
