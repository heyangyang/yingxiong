package game.view.goodsGuide.view {
    import com.langue.Langue;
    import com.utils.ObjectUtil;
    import com.view.base.event.EventType;

    import flash.geom.Rectangle;

    import feathers.controls.Scroller;
    import feathers.controls.renderers.IListItemRenderer;
    import feathers.data.ListCollection;
    import feathers.layout.TiledColumnsLayout;
    import feathers.layout.TiledRowsLayout;

    import game.data.ForgeData;
    import game.data.Goods;
    import game.data.HeroData;
    import game.hero.AnimationCreator;
    import game.manager.AssetMgr;
    import game.manager.GameMgr;
    import game.net.data.IData;
    import game.net.data.s.SForge;
    import game.net.data.vo.forgeDoneIds;
    import game.net.message.EquipMessage;
    import game.view.goodsGuide.ObtainHeroAnimation;
    import game.view.goodsGuide.render.GoodsDropGuideRender;
    import game.view.uitils.Res;
    import game.view.viewBase.GoodsGuideForgeViewBase;

    import spriter.SpriterClip;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.Sprite;
    import starling.events.Event;

    /**
     * 合成界面
     * @author hyy
     *
     */
    public class GoodsGuideForgeView extends GoodsGuideForgeViewBase {
        private var curr_forgeData:ForgeData;
        private var container:Sprite;

        public function GoodsGuideForgeView() {
            super();
            btnok_Scale9Button.text = Langue.getLangue("forge");
            container = new Sprite();
            addChild(container);
            container.x = 28;
            container.y = 192;
            container.addChild(view_drop);
            view_drop.x = view_drop.y = 0;
            container.clipRect = new Rectangle(0, 0, 370, 350);
            grid.touchable = false;
            grid.ico_equip.visible = false;
            container.visible = false;

            const listLayout:TiledColumnsLayout = new TiledColumnsLayout();
            listLayout.horizontalGap = 10;
            listLayout.useSquareTiles = false;
            listLayout.useVirtualLayout = true;
            listLayout.tileVerticalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
            listLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_equip.layout = listLayout;
            list_equip.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_equip.itemRendererFactory = itemRendererFactory;

            const listdropLayout:TiledRowsLayout = new TiledRowsLayout();
            listdropLayout.verticalGap = 10;
            listdropLayout.useSquareTiles = false;
            listdropLayout.useVirtualLayout = true;
            listdropLayout.tileVerticalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
            listdropLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
            list_drop.layout = listdropLayout;
            list_drop.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
            list_drop.itemRendererFactory = itemDropRendererFactory;
        }

        private function itemRendererFactory():IListItemRenderer {
            const renderer:GoodsGuideGrid = new GoodsGuideGrid();
            renderer.setSize(98, 132);
            return renderer;
        }

        private function itemDropRendererFactory():IListItemRenderer {
            const renderer:GoodsDropGuideRender = new GoodsDropGuideRender();
            renderer.setSize(350, 130);
            return renderer;
        }

        public function set data(goods:Goods):void {
            this.curr_forgeData = ForgeData.hash.getValue(goods.type);
            grid.data = goods;
            grid.txt_name.text = goods.name;
            if (goods.tab == 2 && goods.sort == 4) {
                grid.txt_level.text = goods.level + Langue.getLangue("level"); //获取宝珠的等级
            } else {
                grid.txt_level.visible = "";
            }
            list_equip.dataProvider = new ListCollection(curr_forgeData.getForgeList());

            container.visible = false;
            btnok_Scale9Button.visible = true;
            grid.visible = true;
            list_equip.y = 219;

            if (goods.type > 30000 && goods.type < 40000) {
                var hero:HeroData = HeroData.hero.getValue(goods.type) as HeroData;
                grid.ico_equip.texture = Res.instance.getHeroIconTexture(hero.show);
                grid.hun.visible = true;
            } else {
                grid.ico_equip.texture = AssetMgr.instance.getTexture(goods.picture);
                grid.hun.visible = false;
            }
            grid.ico_equip.visible = true;

            if (goods.type > 30000 && goods.type < 40000 || goods.type < 100 && goods.type != 5) {
                grid.ico_quality.texture = Res.instance.getQualityToolTexture(0);
            } else {
                grid.ico_quality.texture = Res.instance.getQualityToolTexture(goods.quality);
            }
        }

        override protected function addListenerHandler():void {
            this.addViewListener(btnok_Scale9Button, Event.TRIGGERED, onClick);
            this.addContextListener(EventType.NOTIFY_FORGE_EQUIP, onForgeNotify);
            this.addContextListener(EventType.SELECTED_GOODS_GUIDE, onChange);
            this.addContextListener(SForge.CMD + "", handleSForgeNotification);
        }

        public function handleSForgeNotification(event:Event, sforge:SForge):void {
            var props:Vector.<IData> = sforge.ids;
            var len:int = props.length;

            for (var i:int = 0; i < len; ++i) {
                var forgeDoneData:forgeDoneIds = props[i] as forgeDoneIds;
                if (0 == forgeDoneData.type) {
                    var animatio:SpriterClip = AnimationCreator.instance.create("effect_020", AssetMgr.instance);
                    animatio.play("effect_020");
                    animatio.animation.looping = false;
                    Starling.juggler.add(animatio);
                    ObjectUtil.setToCenter(grid, animatio);
                    animatio.x = 210;
                    animatio.y = 105;
                    addQuiackChild(animatio);

                    animatio.animationComplete.addOnce(function(sp:SpriterClip):void {
                        sp.stop();
                        Starling.juggler.remove(sp);
                        sp.dispose();
                        ObtainHeroAnimation.add(forgeDoneData.id);
                    })
                }
                onForgeNotify();
            }
        }

        /**
         * 合成返回
         */
        private function onForgeNotify():void {
            list_equip.dataViewPort.dataProvider_refreshItemHandler();
        }

        private function onChange(evt:Event, render:GoodsGuideGrid):void {
            var tag:DisplayObject = view_drop.getChildByName("tag");
            tag.x = render.x + render.width * .5 - tag.width * .5;
            var goods:Goods = render.data as Goods;
            list_drop.dataProvider = new ListCollection(goods.getDropLocationList());
            container.visible = true;

            if (!btnok_Scale9Button.visible) {
                return;
            }
            btnok_Scale9Button.visible = false;
            grid.visible = false;
            view_drop.y = 330;
            tween(list_equip, 0.2, {y: 65});
            tween(view_drop, 0.2, {y: 0});
        }

        private function onClick():void {
            var tip_msg:String = getTipMsg();
            if (tip_msg != "") {
                addTips(tip_msg);
                return;
            }
            curr_forgeData.unEquip();
            EquipMessage.sendForgeGoods(curr_forgeData.id);
        }

        /**
         * 获得提示信息
         * @return
         *
         */
        public function getTipMsg():String {
            if (!curr_forgeData) {
                return getLangue("SELECTED_FORAGE_PROP");
            }

            if (curr_forgeData.moneyTyep == 1 && GameMgr.instance.coin < curr_forgeData.price) {
                return getLangue("notEnoughCoin");
            }

            if (curr_forgeData.moneyTyep == 2 && GameMgr.instance.diamond < curr_forgeData.price) {
                return getLangue("diamendNotEnough");
            }

            if (!curr_forgeData.isCanForge) {
                return getLangue("NOT_ENOUGH");
            }
            return "";
        }

        override public function dispose():void {
            ObtainHeroAnimation.remove();
            super.dispose();
            curr_forgeData = null;
        }

    }
}
