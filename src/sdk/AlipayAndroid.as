/**
 * Created by Administrator on 2014/10/20 0020.
 */
package sdk {
import game.view.viewBase.AlipayAndroidBase;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.display.DisplayObjectContainer;

import starling.events.Event;
import starling.utils.AssetManager;

public class AlipayAndroid extends AlipayAndroidBase {

    public static var  assets:AssetManager;
    public var onYinLan:ISignal;
    public var onAlipay:ISignal;

    public function AlipayAndroid() {
        super();


        yinlian.addEventListener(Event.TRIGGERED,onYinLianHdr)
        alipay.addEventListener(Event.TRIGGERED,onAlipayHdr)

        onYinLan = new Signal(AlipayAndroid);
        onAlipay = new Signal(AlipayAndroid);

        clickBackroundClose();
    }

    override public function open(container:DisplayObjectContainer, parameter:Object = null, okFun:Function = null, cancelFun:Function = null):void {
        super.open(container, parameter, okFun, cancelFun);

        setToCenter();
    }

    private function onAlipayHdr(event:Event):void {
        onAlipay.dispatch(this);
        close();
    }

    private function onYinLianHdr(event:Event):void {
        onYinLan.dispatch(this);
        close();
    }

    override public function dispose():void
    {
        super .dispose();
        assets.dispose();
    }

    override public function get assetMgr():AssetManager{return assets;}
}
}
