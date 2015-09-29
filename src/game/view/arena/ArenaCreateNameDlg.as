package game.view.arena {
    import com.langue.Langue;
    import com.langue.PlayerName;
    import com.langue.WordFilter;
    import com.utils.StringUtil;

    import flash.text.TextFormatAlign;

    import feathers.controls.Scroller;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.events.FeathersEventType;
    import feathers.layout.TiledColumnsLayout;
    import feathers.layout.TiledRowsLayout;

    import game.data.GamePhotoData;
    import game.manager.GameMgr;
    import game.net.message.RoleInfomationMessage;
    import game.view.arena.render.ArenaCreateNameRender;
    import game.view.viewBase.ArenaCreateNameDlgBase;

    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    /**
     * 竞技场注册
     * @author hyy
     *
     */
    public class ArenaCreateNameDlg extends ArenaCreateNameDlgBase {
        private var picture:int;

        public function ArenaCreateNameDlg() {
            super();
        }

        override protected function init():void {
            enableTween = true;
            const listLayout:TiledColumnsLayout = new TiledColumnsLayout();
            listLayout.horizontalGap = 20;
            listLayout.verticalGap = 8;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            listLayout.paging = TiledColumnsLayout.PAGING_HORIZONTAL;
            list_hero.layout = listLayout;
            list_hero.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_hero.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_hero.itemRendererFactory = itemRendererFactory;

            curr_hero.picture = GameMgr.instance.picture; //人物头像
            txt_input.textEditorProperties.textAlign = TextFormatAlign.CENTER;
            txt_input.textEditorProperties.fontFamily = "";
            txt_inputBtn.text = Langue.getLangue("text_ipunt_name");
            txt_inputBtn.touchable = true;
            title.text = Langue.getLangue("arena_create_name");
            btnRandom_Scale9Button.text = Langue.getLangue("text_random_name");
            okBtn_Scale9Button.text = Langue.getLangue("signRewardResignMsgOKText");

            clickBackroundClose();
        }

        private function itemRendererFactory():IListItemRenderer {
            const renderer:ArenaCreateNameRender = new ArenaCreateNameRender();
            renderer.setSize(84, 84);
            return renderer;
        }

        override protected function show():void {
            setToCenter();
            updateList();
            txt_input.setFocus();
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            this.addViewListener(list_hero, Event.CHANGE, onListClick);
            this.addViewListener(btnRandom_Scale9Button, Event.TRIGGERED, onRandom);
            this.addViewListener(okBtn_Scale9Button, Event.TRIGGERED, onOkClick);
            this.addViewListener(txt_input, FeathersEventType.FOCUS_IN, onGetFocusIn);
            this.addViewListener(txt_inputBtn, TouchEvent.TOUCH, onOneHandler);
        }

        private function onOneHandler(e:TouchEvent):void {
            var touch:Touch = e.getTouch(stage);
            if (touch == null)
                return;
            if (txt_inputBtn.visible) {
                if (touch.phase == TouchPhase.BEGAN) {
                    txt_input.text = "";
                    txt_input.maxChars = 10;
                    txt_inputBtn.visible = false;
                }
            }
        }

        /**
         * 更新列表
         */
        private function updateList():void {
            list_hero.dataProvider = new ListCollection(GamePhotoData.hashMapPhoto.values());
            list_hero.selectedIndex = 0;
        }

        /**
         * 头像选择
         * @param evt
         */
        private function onListClick(evt:Event):void {
            curr_hero.data = list_hero.selectedItem;
            picture = curr_hero.picture;
            onGetFocusIn();
        }

        /**
         * 随机名字
         */
        private function onRandom():void {
            var random:int = Math.random() * 2 + 1;
            var randmName:String;
            if (random == 1) {
                randmName = PlayerName.instance.getBoyName();
            } else if (random == 2) {
                randmName = PlayerName.instance.getGirlName();
            }
            txt_input.text = "";
            txt_input.maxChars = 10;
            txt_inputBtn.visible = false;
            txt_input.text = randmName;
        }

        private function onGetFocusIn():void {
            if (!txt_inputBtn.visible) {
                txt_input.selectRange(0, txt_input.text.length);
                txt_input.setFocus();
            }
        }

        private function onOkClick():void {
            var name:String = StringUtil.trim(txt_input.text);
            var font_count:int = StringUtil.charCount(name);
            if (font_count < 2) {
                addTips("nameShort");
                return;
            }

            else if (font_count > 6) {
                addTips("nameLong");
                return;
            }

            else if (WordFilter.instance.filter(name).indexOf("**") >= 0) {
                addTips("nameNoHarmonious");
                return;
            }
            RoleInfomationMessage.sendArenaRegister(name, picture);
        }
    }
}
