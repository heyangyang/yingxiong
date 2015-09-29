package game.view.email {
    import com.langue.Langue;

    import flash.text.TextFormat;

    import feathers.controls.ScrollText;
    import feathers.controls.Scroller;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledRowsLayout;

    import game.net.message.MailMessage;
    import game.view.viewBase.EmailDlgBase;

    import starling.display.DisplayObjectContainer;
    import starling.events.Event;

    /**
     * 邮件系统
     * @author lfr
     */
    public class EmailDlg extends EmailDlgBase {
        private var emailId:int;
        private var list_reward:Array = [];
        private const PAGE_COUNT:int = 3;
        private var data:Object;
        private var scrollBar:ScrollText;
        private var selectIndex:int;
        private var list_pos:Number = 0;

        public function EmailDlg() {
            super();
        }

        override protected function init():void {
            bgImage0.alpha = grid.alpha = 0.5;
            txt_des1.text = Langue.getLangue("theme"); //主题
            txt_des2.text = Langue.getLangue("Sender"); //发件人

            get__Scale9Button.text = getLangue("getGoods"); //收取，按钮名字
            _closeButton = btn_close; //设置关闭按钮
            get__Scale9Button.visible = false;

            scrollBar = new ScrollText();
            scrollBar.x = txt_des.x;
            scrollBar.y = txt_des.y;
            scrollBar.width = txt_des.width - 5;
            scrollBar.height = txt_des.height;

            var textFormat:TextFormat = new TextFormat(txt_des.fontName, txt_des.fontSize, txt_des.color);
            scrollBar.textFormat = textFormat;
            addChild(scrollBar);
            txt_des.removeFromParent(true);

            const listLayout:TiledRowsLayout = new TiledRowsLayout();
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_mail.layout = listLayout;
            list_mail.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_mail.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
            list_mail.itemRendererFactory = itemRendererFactory;

            var item:EmailReward;
            for (var i:int = 0; i < 3; i++) {
                item = new EmailReward(this["goods" + i]);
                addChild(item);
                list_reward.push(item);
            }
        }

        private function itemRendererFactory():IListItemRenderer {
            const renderer:EmailRenderItem = new EmailRenderItem();
            return renderer;
        }

        override protected function addListenerHandler():void {
            super.addListenerHandler();
            this.addViewListener(get__Scale9Button, Event.TRIGGERED, onGetGoods);
            this.addViewListener(list_mail, Event.CHANGE, onChange);
            this.addViewListener(list_mail, Event.SCROLL, onScroll);
            this.addContextListener(MailMessage.UPDATE_MAIL_LIST, onUpdateList);
            this.addContextListener(MailMessage.SELECT_MAIL, onSelectMail);
        }

        override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
            super.open(container, parameter, okFun, cancelFun);
            setToCenter();
            this.updateMailInfo(null);
            //请求邮件
            MailMessage.sendMailList();
        }

        /**
         * 更新列表事件
         * @param evt
         */
        private function onUpdateList(evt:Event):void {
            data = evt.data;
            updatePage();
        }

        /**
         * 根据当前页数刷新界面
         * @param tmp_page
         */
        private function updatePage():void {
            list_mail.dataProvider = new ListCollection(data);
            list_mail.selectedIndex = 0;
            list_mail.verticalScrollPosition = list_pos;
            if (list_mail.dataProvider.length > 0) {
                get__Scale9Button.visible = true;
            } else {
                get__Scale9Button.visible = false;
            }
        }

        /**
         * 选择上一封邮件
         * @param evt
         */
        private function onSelectMail(evt:Event):void {
            if (list_mail.dataProvider && list_mail.dataProvider.length > 0) {
                if (selectIndex >= data.length) {
                    selectIndex = data.length - 1;
                }
                list_mail.selectedIndex = selectIndex;
            }
        }

        /**
         * 领取邮件附件
         * @param e
         */
        private function onGetGoods(e:Event):void {
            if (emailId == 0) {
                addTips(Langue.getLangue("Please_Select_Mail")); //请选择邮件
                return;
            } else {
                get__Scale9Button.visible = true;
            }

            if (list_mail.selectedIndex != -1) {
                selectIndex = list_mail.selectedIndex;
            }

            if (get__Scale9Button.text == getLangue("getGoods")) {
                MailMessage.sendGetMailItmes(emailId);
            } else if (get__Scale9Button.text == getLangue("delete")) {
                MailMessage.sendDeleteMail(emailId);
            }
        }


        /**
         * 上一页
         * @param e
         */
        private function onPrev(e:Event):void {
            if (list_mail.isScrolling) {
                return;
            }
            list_mail.throwToPage(list_mail.horizontalPageIndex - 1 < 0 ? 0 : list_mail.horizontalPageIndex - 1, -1, 0.3);
        }

        /**
         * 下一页
         * @param e
         */
        private function onNext(e:Event):void {
            if (list_mail.isScrolling) {
                return;
            }
            list_mail.throwToPage(list_mail.horizontalPageIndex + 1 >= list_mail.horizontalPageCount ? list_mail.horizontalPageIndex : list_mail.horizontalPageIndex + 1,
                                  -1, 0.3);
        }

        /**
         * 选中邮件处理
         * @param e
         */
        private function onChange(e:Event):void {
            updateMailInfo(list_mail.selectedItem as MailData);
        }

        private function onScroll(e:Event):void {
            list_pos = list_mail.verticalScrollPosition;
        }

        /**
         * 更新右边邮件详细信息
         * @param mail
         */
        private function updateMailInfo(mail:MailData):void {
            emailId = mail ? mail.id : 0;
            scrollBar.text = mail ? mail.content : "";
            txt_sender.text = mail ? mail.from : "";
            txt_name.text = mail ? mail.from : "";

            var len:int = list_reward.length;
            var tmp_data:Object;
            var rewardCount:int = 0;

            for (var i:int = 0; i < len; i++) {
                tmp_data = (mail && mail.items.length - 1 >= i) ? mail.items[i] : null;
                list_reward[i].data = tmp_data;
                rewardCount += tmp_data ? 1 : 0;
            }
//            scrollBar.height = rewardCount > 0 ? 140 : 140;
//            grid.visible = rewardCount > 0;
            get__Scale9Button.text = mail == null || mail.items.length == 0 ? getLangue("delete") : getLangue("getGoods");

        }

        override public function dispose():void {
            super.dispose();

            for each (var mailData:MailData in data) {
                if (mailData) {
                    mailData.parent = null;
                }
            }
            list_reward = null;
            data = null;
        }

    }
}
