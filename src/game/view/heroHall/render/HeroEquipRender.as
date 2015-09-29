package game.view.heroHall.render {
    import com.view.base.event.EventType;
    import com.view.base.event.ViewDispatcher;

    import game.data.WidgetData;
    import game.manager.AssetMgr;
    import game.view.uitils.Res;
    import game.view.viewBase.HeroEquipRenderBase;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.events.Event;

    /**
     * 英雄人物身上装备
     * @author Samuel
     */
    public class HeroEquipRender extends HeroEquipRenderBase {
        private var selectedAnimation:SpriterClip;

        public function HeroEquipRender(sp:SpriterClip) {
            super();
            selectedAnimation = sp;
            but_bg.container.addQuiackChild(tag_equip);
            but_bg.container.addQuiackChild(ico_equip);
            but_bg.container.addQuiackChild(quality);
            but_bg.container.addQuiackChild(txt_level);
            but_bg.container.addQuiackChild(tag_add);
            but_bg.addEventListener(Event.TRIGGERED, onClick);
        }

        protected function onClick(event:Event):void {
            ViewDispatcher.dispatch(EventType.UPDATE_BODYEQUIP_SELECTED, data);
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (value == null) {
                return;
            }
            var widget:WidgetData = value as WidgetData;
            //强化等级
            txt_level.text = (widget.level > 0 ? "+" + widget.level : "");
            //装备图标
            if (widget.picture) {
                ico_equip.texture = AssetMgr.instance.getTexture(widget.picture);
            }
            ico_equip.visible = widget.picture != null;
            tag_equip.visible = !ico_equip.visible;
            //装备类型
            tag_equip.texture = Res.instance.getTypeEquipTexture(widget.sort);
            //装备品质
            if (widget.type < 100) {
                quality.texture = Res.instance.getQualityToolTexture(0);
            } else {
                quality.texture = Res.instance.getQualityToolTexture(widget.quality);
            }
            tag_add.visible = widget.hasBestEquip;
        }

        override public function set isSelected(value:Boolean):void {
            super.isSelected = value;
            if (!value || (owner && owner.isScrolling))
                return;
            if (value && data.id > 0) {
                Starling.juggler.add(selectedAnimation);
                selectedAnimation.x = quality.width >> 1;
                selectedAnimation.y = quality.height >> 1;
                addQuiackChild(selectedAnimation);
            }
        }

        override public function dispose():void {
            super.dispose();
        }
    }
}


