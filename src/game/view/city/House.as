/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-11-19
 * Time: 下午7:55
 * To change this template use File | Settings | File Templates.
 */
package game.view.city {
import flash.geom.Rectangle;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import spriter.SpriterClip;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.TextureAtlas;

public class House extends Sprite {
        private static const MAX_DRAG_DIST:Number = 0;
        public var onClick:ISignal;

        public var isScale:Boolean = true;

        private var mIsDown:Boolean;
        private var mbounds:Rectangle;
        private var _animationName:String;
        private var _clip:SpriterClip;

        public function House(animations:Object, textureAtlas:TextureAtlas, animationName:String) {
            super();
            _clip = new SpriterClip(animations, textureAtlas);
            _clip.play(animationName);
            _clip.animation.looping = true;
            addChild(_clip);
            _animationName = animationName;
            _clip.touchable = true;
            onClick = new Signal(House);
            addEventListener(TouchEvent.TOUCH, onTouch);
        }

        private function resetContents():void {
            mIsDown = false;
//        mBackground.texture = mUpState;
            this.x = this.y = 0;
            this.x = mbounds.x;
            this.y = mbounds.y;
            _clip.play(_animationName);
            _clip.animation.looping = true;
            this.scaleX = this.scaleY = 1.0;
        }

        public function play():void {
            Starling.juggler.add(_clip);
        }

        public function stop():void {
            Starling.juggler.remove(_clip);
        }

        private var _oldPos:int;

        private function onTouch(event:TouchEvent):void {
            var touch:Touch = event.getTouch(this);
            if (touch == null)
                return;

            if (touch.phase == TouchPhase.BEGAN && !mIsDown) {

                if (isScale) {
                    this.scaleX = this.scaleY = 0.95;
                    mbounds = new Rectangle(this.x, this.y, this.width, this.height);
                    this.x += 0.025 * mbounds.width;
                    this.y += 0.05 * mbounds.height;
                }
                _oldPos = touch.globalX;

                mIsDown = true;
            } else if (touch.phase == TouchPhase.MOVED && mIsDown) {

                if (Math.abs(touch.globalX - _oldPos) > 20) {
                    resetContents();
                }
            } else if (touch.phase == TouchPhase.ENDED && mIsDown) {
                resetContents();


                onClick.dispatch(this);
            }

        }

        override public function dispose():void {

            _clip.dispose();
            mIsDown=false;
            mbounds=null;
            _animationName="";
            _clip=null;
            super.dispose();
        }

    }
}
