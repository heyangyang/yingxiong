/**
 * Created by Administrator on 2014/11/7 0007.
 */
package game.view.tavern.data {
import com.singleton.Singleton;

import flash.utils.getTimer;

import game.net.data.c.CHerosoul;
import game.net.message.base.Message;

import starling.animation.IAnimatable;
import starling.core.Starling;
import starling.text.TextField;

public class DestinyCoinFlash {
    public function DestinyCoinFlash() {
    }
    private var _coinFlashCD:IAnimatable;


    public static function get instance() : DestinyCoinFlash
    {
        return Singleton.getInstance(DestinyCoinFlash) as DestinyCoinFlash;
    }

    private var _lastTime:int = 0;
    private var _cd:int;
    private var _txt:TextField;
    public function isTimeout():Boolean
    {
        var t:int=_cd - (getTimer() - _lastTime) / 1000;
        return t <= 0;
    }

    public function resume(txt:TextField):void
    {
		_txt = txt;
        _coinFlashCD =  Starling.juggler.repeatCall(updateCoinTime, 1,0,_txt,_cd,_lastTime);
    }

    public function stop():void
    {
        Starling.juggler.remove(_coinFlashCD);
        _coinFlashCD = null;
    }
    public function play(text:TextField,time:int):void
    {
       if(_coinFlashCD)
       {
           Starling.juggler.remove(_coinFlashCD);
       }
        _lastTime = getTimer();
        _cd = time;
        _txt = text;
        _coinFlashCD =  Starling.juggler.repeatCall(updateCoinTime, 1,0,_txt,_cd + 10,_lastTime);
    }


    private function updateCoinTime(text:TextField,time:int,lastTime:int):void
    {
        var num:String;
        var num1:String;
        var t:int=time - (getTimer() - lastTime) / 1000;

        if (t > 0)
        {
            num=t % 60 >= 10 ? t % 60 + "" : "0" + t % 60; //秒
            num1=(t / 60 >> 0) % 60 + "";
            if (text)
            {
                text.text="" + (t / 60 / 60 >> 0) + ":" + num1 + ":" + num + "";
            }
        }
        else
        {
            var cmd:CHerosoul = new CHerosoul();
            cmd.type = 0;
            Message.sendMessage(cmd);
            Starling.juggler.remove(_coinFlashCD);
            text.text="00:00:00";
        }
    }
}
}
