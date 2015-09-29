package game.base
{
    import com.view.View;

    import feathers.dragDrop.IDragSource;

    import starling.display.Image;
    import starling.textures.Texture;

    public class DragImage extends View implements IDragSource
    {
        private var _image:Image=null;
        private var _texture:Texture;

        public function DragImage(texture:Texture)
        {
            _texture=texture;
            super();
        }

        override protected function init():void
        {
            _image=new Image(_texture);
            addChild(_image);
        }

        public function set texture(value:Texture):void
        {
            _texture=value;
            if (_image == null)
            {
                _image=new Image(value);
                addChild(_image);
            }
            else
            {
                _image.texture=value;
            }
        }

        override public function dispose():void
        {
            _image.removeFromParent(true);
            _texture=null;
            super.dispose();
        }
    }
}
