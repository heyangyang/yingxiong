package game.base {
    import com.dialog.DialogMgr;

    import game.data.Goods;
    import game.data.IconData;
    import game.manager.AssetMgr;
    import game.view.goodsGuide.EquipInfoDlg;

    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;

    /**
     * 图标基本类
     * @author Samuel
     *
     */
    public class BaseIcon extends Sprite {
        /**数据*/
        private var _data:IconData = null;
        /**图片资源管理*/
        private var _asset:AssetMgr = AssetMgr.instance;

        public var but_bg:Button = null;
        public var iconImage:Image = null;
        public var qualityImage:Image = null;
        public var hun:Image = null;
        public var text_Num:TextField = null;
        public var text_Name:TextField = null;

        public function BaseIcon(value:IconData) {
            _data = value;
            super();
            initView();
        }

        /**生成视图*/
        protected function initView():void {
            if (data == null) {
                return;
            }

            //背景底图
            if (data.bg != "") {
                if (but_bg == null) {
                    but_bg = new Button(_asset.getTexture(data.bg));
                    addQuiackChild(but_bg);
                } else {
                    but_bg.upState = _asset.getTexture(data.bg);
                }
            } else {
                but_bg && but_bg.removeFromParent(true);
                but_bg = null;
            }

            //物品图标
            if (data.IconTrue != "") {
                if (iconImage == null) {
                    iconImage = new Image(_asset.getTexture(data.IconTrue));
                    addQuiackChild(iconImage);
                } else {
                    iconImage.texture = _asset.getTexture(data.IconTrue);
                }
            } else {
                iconImage && iconImage.removeFromParent(true);
                iconImage = null;
            }


            //物品背景品质框
            if (data.QualityTrue != "") {
                if (qualityImage == null) {
                    qualityImage = new Image(_asset.getTexture(data.QualityTrue));
                    addQuiackChild(qualityImage);
                } else {
                    qualityImage.texture = _asset.getTexture(data.QualityTrue);
                }
            } else {
                qualityImage && qualityImage.removeFromParent(true);
                qualityImage = null;
            }

            //英雄魂
            if (data.hun != "") {
                if (hun == null) {
                    hun = new Image(_asset.getTexture(data.hun));
                    addQuiackChild(hun);
                } else {
                    hun.texture = _asset.getTexture(data.hun);
                }
            } else {
                hun && hun.removeFromParent(true);
                hun = null;
            }

            //物品数量
            if (data.Num != "") {
                if (text_Num == null) {
                    text_Num = new TextField(75, 30, '', '', 21, 0xE6E5D1, false);
                    text_Num.touchable = false;
                    text_Num.hAlign = 'left';
                    text_Num.text = data.Num.toString();
                } else {
                    text_Num.text = data.Num.toString();
                }
            }

            //物品名字
            if (data.Name != "") {
                if (text_Name == null) {
                    text_Name = new TextField(140, 30, '', '', 21, 0xE6E5D1, false);
                    text_Name.touchable = false;
                    text_Name.hAlign = 'center';
                    text_Name.text = data.Name;
                } else {
                    text_Name.text = data.Name;
                }
            }

            if (iconImage) {
                but_bg.container.addChild(iconImage);
            }

            if (qualityImage) {
                but_bg.container.addChild(qualityImage);
            }

            if (hun) {
                if (data.IconType < 40000 && data.IconType > 30000) {
                    but_bg.container.addChild(hun);
                    hun.visible = data.hunModel;
                } else {
                    hun.visible = !data.hunModel;
                }
            }

            if (text_Num) {
                but_bg.container.addChild(text_Num);
            }

            if (text_Name) {
                but_bg.container.addChild(text_Name);
            }

            if (data.ButtonModel) {
                this.touchable = true;
                this.addEventListener(TouchEvent.TOUCH, clickHandler);
            } else {
                this.touchable = false;
            }

            adjustUI();
        }


        /**调整UI*/
        private function adjustUI():void {
            if (iconImage) {
                iconImage.x = ((qualityImage != null ? qualityImage.width : 98) - iconImage.width) >> 1;
                iconImage.y = ((qualityImage != null ? qualityImage.height : 98) - iconImage.height) >> 1;
            }
            if (hun) {
                hun.x = 57;
                hun.y = 12;
            }

            if (text_Num) {
                text_Num.x = 10;
                if (iconImage) {
                    text_Num.y = iconImage.y + (iconImage.height - text_Num.height);
                } else {
                    text_Num.y = 60;
                }
            }

            if (text_Name) {
                if (iconImage) {
                    text_Name.x = iconImage.x + (iconImage.width - text_Name.width) >> 1;
                    text_Name.y = iconImage.y + (iconImage.height - text_Name.height) + 35;
                } else {
                    text_Name.x = -26;
                    text_Name.y = 110;
                }
            }
        }

        /**点击回调函数*/
        private function clickHandler(e:TouchEvent):void {
            var touch:Touch = e.getTouch(stage);
            if (touch == null) {
                return;
            }
            switch (touch.phase) {
                case TouchPhase.BEGAN:
                    switch (data.IconType) {
                        case data.IconType: //物品
                            var itemData:Goods = Goods.goods.getValue(data.IconId);
                            if (itemData != null) {
                                itemData = itemData.clone() as Goods;
                                itemData.drop_location = "";
                                itemData.isPack = false;
                                DialogMgr.instance.isVisibleDialogs(true);
                                DialogMgr.instance.open(EquipInfoDlg, itemData);
                            }
                            break;
                        default:
                            break;
                    }
                    break;
            }
        }

        /**更新数据*/
        public function updata(value:IconData):void {
            if (value != null) {
                _data = value;
                initView();
            } else {
                removeIcon();
            }
        }

        /**移除图标*/
        private function removeIcon():void {
            while (this.numChildren > 0) {
                this.getChildAt(0).removeFromParent(true);
            }
        }

        /**获取图标数据*/
        public function get data():IconData {
            return _data;
        }

        /**释放销毁*/
        override public function dispose():void {
            removeIcon();
            super.dispose();
            _data = null;
            text_Num = null;
            text_Name = null;
            qualityImage = null;
            iconImage = null;
        }
    }
}

