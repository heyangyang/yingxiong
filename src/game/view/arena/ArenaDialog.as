package game.view.arena {
    import com.langue.Langue;

    import game.view.arena.view.RankView;
    import game.view.arena.view.ReportView;
    import game.view.arena.view.RuleView;
    import game.view.viewBase.ArenaDialogBase;

    import starling.display.DisplayObjectContainer;

    /**
     * 角斗场
     * @author Samuel
     *
     */
    public class ArenaDialog extends ArenaDialogBase {
        public function ArenaDialog() {
            super();
        }

        override protected function init():void {
            _closeButton = btn_close;
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
        }

        override protected function listTabButton():Array {
            var lables:Array = Langue.getLans("arenaMenuText");
            tab_1.text = lables[0];
            tab_2.text = lables[1];
            tab_3.text = lables[2];
            tab_4.text = lables[3];
            return [tab_1, tab_2, tab_3, tab_4];
        }

        override protected function listTabReference():Array {
            return [game.view.arena.view.RankView, game.view.arena.view.ReportView, game.view.arena.view.ConvertView, game.view.arena.view.RuleView];
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            if (parameter && parameter is int) {
                defaultSelect = parameter as int;
            }
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}
