package game.view.heroHall.render {
    import com.utils.Constants;
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import flash.geom.Point;

    import feathers.controls.Scroller;
    import feathers.dragDrop.DragData;
    import feathers.dragDrop.DragDropManager;
    import feathers.dragDrop.IDragSource;
    import feathers.events.DragDropEvent;

    import game.data.HeroData;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.manager.HeroDataMgr;
    import game.view.uitils.Res;
    import game.view.viewBase.HeroIcoRenderBase;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    /**
     * 英雄头像render
     * @author hyy
     *
     */
    public class HeroIconRender extends HeroIcoRenderBase implements IDragSource {
        private static var curr_target:HeroIconRender;
        private static var curr_point:Point;
        private var selectedAnimation:SpriterClip;
        private var star:StarBarRender;
        private var heroData:HeroData;
        private var isDraging:Boolean;
        public var isCurrent:Boolean;
        private var _isStar:Boolean = false;

        public function HeroIconRender(animation:SpriterClip = null, isDragEnable:Boolean = false, star:Boolean = false) {
            super();
            selectedAnimation = animation;
            _isStar = star;
            tag_bg.touchable = true;
            this.isDragEnable = isDragEnable;

            tag_bg.container.addQuiackChild(ico_head);
            tag_bg.container.addQuiackChild(quality);
            tag_bg.container.addQuiackChild(tag_battle);
            tag_bg.container.addQuiackChild(textLv);
            tag_bg.container.addQuiackChild(txt_desopen);
            tag_bg.container.addQuiackChild(txt_open);
        }

        override public function set data(value:Object):void {
            super.data = value;
            heroData = value as HeroData;

            tag_battle.visible = heroData && heroData.seat > 0;
            txt_open.visible = heroData && heroData.id == -1;
            txt_desopen.visible = heroData && heroData.id == -1;
            quality.visible = heroData && heroData.quality > 0;
            ico_head.texture = Res.instance.getHeroIconTexture(0);
            star && star.removeFromParent();
            if (!isSelected) {
                selectedAnimation && selectedAnimation.removeFromParent();
            }
            if (heroData == null) {
                return;
            }
            if (heroData.id == -1) {
                txt_open.text = HeroDataMgr.instance.hash.size() + "/" + GameMgr.instance.hero_gridCount;
            }

            if (heroData.quality > 0) {
                quality.texture = Res.instance.getQualityHeroTexture(heroData.quality);
                tag_bg.upState = AssetMgr.instance.getTexture("ui_daojukuangdi");
            }
            textLv.text = heroData.level.toString();
            if (heroData.level <= 0) {
                textLv.text = "";
            }
            ico_head.texture = Res.instance.getHeroIconTexture(heroData.show);
            star = new StarBarRender();
            star.updataStar(heroData.foster, 0.9);
            tag_bg.container.addQuiackChild(star);
            star.x = (quality.width - star.width) >> 1;
            star.y = quality.height - star.height - 6;
            if (!_isStar) {
                star.visible = true;
            } else {
                star.visible = false;
            }
        }

        override public function set isSelected(value:Boolean):void {
            super.isSelected = value;
            if (!value || data == null || data.id == 0 || (owner && owner.isScrolling)) {
                return;
            }

            if (data.id > 0 && value) {
                selectedAnimation.play("effect_012");
                selectedAnimation.animation.looping = true;
                Starling.juggler.add(selectedAnimation);
                selectedAnimation.x = quality.width / 2;
                selectedAnimation.y = quality.height / 2;
                addChild(selectedAnimation);
            } else {
                selectedAnimation && selectedAnimation.removeFromParent();
                isSelected = false;
            }
        }

        public function set isDragEnable(value:Boolean):void {
            if (value) {
                this.addEventListener(TouchEvent.TOUCH, touchHandler);
                this.addEventListener(DragDropEvent.DRAG_COMPLETE, dragCompleteHandler);
            } else {
                this.removeEventListener(TouchEvent.TOUCH, touchHandler);
                this.removeEventListener(DragDropEvent.DRAG_COMPLETE, dragCompleteHandler);
            }
        }

        private function touchHandler(event:TouchEvent):void {
            if (DragDropManager.isDragging || heroData == null || heroData.id == 0 || heroData.seat > 0) {
                return;
            }

            if (!isDraging) {
                var touch:Touch = event.getTouch(this);
                if (touch == null) {
                    return;
                }

                if (touch.phase == TouchPhase.MOVED) {
                    if (curr_point == null) {
                        curr_point = this.localToGlobal(new Point());
                    }

                    if (touch.globalY - curr_point.y <= 0) {
                        isDraging = true;
                        var dragData:DragData = new DragData();
                        if (curr_target == null) {
                            curr_target = new HeroIconRender(selectedAnimation);
                            curr_target.touchable = false;
                        }
                        curr_target.data = heroData;
                        dragData.setDataForFormat("hero", heroData);
                        curr_target.scaleX = curr_target.scaleY = Constants.scale;
                        DragDropManager.startDrag(this, touch, dragData, curr_target, -(quality.width * .5), -(quality.height * .5));
                        owner.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
                        owner.stopScrolling();
                    }
                } else if (touch.phase == TouchPhase.ENDED) {
                    isDraging = false;
                }
                return;
            }
            isDraging = false;
        }

        private function dragCompleteHandler(event:DragDropEvent, dragData:DragData):void {
            owner.horizontalScrollPolicy = Scroller.SCROLL_POLICY_ON;
            if (HeroDataMgr.instance.isMaxBattle) {
                ViewDispatcher.dispatch(EventType.UPDATE_HERO_LIST_STATUS, -1);
            }
        }

        override public function dispose():void {
            isDragEnable = false;
            selectedAnimation && selectedAnimation.removeFromParent();
            star && star.removeFromParent(true);
            star = null;
            selectedAnimation = null;
            heroData = null;
            super.dispose();
        }
    }
}


