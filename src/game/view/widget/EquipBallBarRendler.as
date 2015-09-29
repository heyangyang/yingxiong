package game.view.widget {
    import game.data.Goods;
    import game.data.WidgetData;
    import game.manager.AssetMgr;
    import game.net.data.vo.MagicBallVO;
    import game.view.viewBase.EquipBallBarRendlerBase;

    import starling.display.Image;

    public class EquipBallBarRendler extends EquipBallBarRendlerBase {
        public function EquipBallBarRendler(scale:Number = 0.6) {
            super();
            this.scaleX = this.scaleY = scale;
        }

        public function updata(widgetData:WidgetData):void {
            var sockets:Vector.<MagicBallVO> = widgetData.sockets;
            var socketsNum:int = widgetData.socketsNum;
            for (var i:int = 0; i < 5; i++) {
                var no:Image = this["no_" + i] as Image;
                var ad:Image = this["ad_" + i] as Image;
                if ((i + 1) > socketsNum) {
                    no.texture = AssetMgr.instance.getTexture("ui_bukaifang");
                    ad.visible = false;
                    no.visible = true;
                } else {
                    ad.visible = true;
                    no.visible = false;
                }

                if (i < sockets.length) {
                    var vo:MagicBallVO = sockets[i];
                    var goods:Goods = Goods.goods.getValue(vo.id);
                    no.texture = AssetMgr.instance.getTexture(goods.picture);
                    no.width = no.height = 90;
                    no.x = -18 + (52 * i);
                    no.y = -23;
                    ad.visible = false;
                    no.visible = true;
                }
            }

//			for (var i:int=0; i < 5; i++)
//			{
//				var no:Image=this["no_" + i] as Image;
//				var ad:Image=this["ad_" + i] as Image;
//				if ((i + 1) > socketsNum)
//				{
//					no.texture=AssetMgr.instance.getTexture("ui_bukaifang");
//					no.width=no.height=42;
//					no.x=4.5;
//					no.y=5;
//					ad.visible=false;
//					no.visible=true;
//				}
//				else
//				{
//					ad.visible=true;
//					no.visible=false;
//				}
//				
//				if (i < sockets.length)
//				{
//					var vo:MagicBallVO=sockets[i];
//					var goods:Goods=Goods.goods.getValue(vo.id);
//					no.texture=AssetMgr.instance.getTexture(goods.picture);
//					no.width=no.height=86;
//					no.x=-16;
//					no.y=-20;
//					no.visible=true;
//					ad.visible=false;
//				}
//				
//			}
//			
        }

    }
}
