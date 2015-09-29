package game.view.chat.component {
    import feathers.controls.renderers.DefaultListItemRenderer;

    import starling.text.TextField;

    public class JTTextField extends DefaultListItemRenderer {
        private var text:TextField = null;

        public function JTTextField() {
            super();
            text = new TextField(760, 30, "");
//            text.isHtml = true;
            text.touchable = false;
            text.hAlign = 'left';
            this.addQuiackChild(text);
        }

        override public function set data(value:Object):void {
            super.data = value;

            if (value == null) {
                this.text.text = "";
                return;
            }
            var copy:String = (value + "");
            var lines:Array = copy.split(":CabbageWrom:");
            this.text.htmlText = lines[0];
        }

        override public function dispose():void {
            super.dispose();

            if (!text) {
                this.removeChild(text);
                text = null;
            }
        }
    }
}
