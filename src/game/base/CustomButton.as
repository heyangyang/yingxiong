package game.base
{
import com.sound.SoundManager;

import flash.geom.Rectangle;

import starling.display.DisplayObject;
import starling.display.DisplayObjectContainer;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

/** Dispatched when the user triggers the button. Bubbles. */
[Event(name="triggered", type="starling.events.Event")]
public class CustomButton extends DisplayObjectContainer
{
    private static const MAX_DRAG_DIST:Number=50;
    protected var mContents:Sprite;
    private var mScaleWhenDown:Number;
    private var mAlphaWhenDisabled:Number;
    private var mEnabled:Boolean;
    private var mIsDown:Boolean;
    private var mUseHandCursor:Boolean;

    /** Creates a button with textures for up- and down-state or text. */
    public function CustomButton()
    {
        mScaleWhenDown= 0.9;
        mAlphaWhenDisabled=0.5;
        mEnabled=true;
        mIsDown=false;
        mUseHandCursor=true;

        mContents=new Sprite();
        super.addQuiackChild(mContents);
        addEventListener(TouchEvent.TOUCH, onTouch);
    }

    private function resetContents():void
    {
        mIsDown=false;
        mContents.x=mContents.y=0;
        mContents.scaleX=mContents.scaleY=1.0;
    }

    public function onTouch(event:TouchEvent):void
    {
        var touch:Touch=event.getTouch(this);
        if (!mEnabled || touch == null)
            return;

        if (touch.phase == TouchPhase.BEGAN && !mIsDown)
        {
            mContents.scaleX=mContents.scaleY=mScaleWhenDown;
            mContents.x=(1.0 - mScaleWhenDown) / 2.0 * this.width;
            mContents.y=(1.0 - mScaleWhenDown) / 2.0 * this.height;
            mIsDown=true;
            SoundManager.instance.playSound("UI_click");
        }
        else if (touch.phase == TouchPhase.MOVED && mIsDown)
        {
            var buttonRect:Rectangle=getBounds(stage);

            if (touch.globalX < buttonRect.x - MAX_DRAG_DIST || touch.globalY < buttonRect.y - MAX_DRAG_DIST || touch.globalX > buttonRect.x + buttonRect.width + MAX_DRAG_DIST || touch.globalY > buttonRect.y + buttonRect.height + MAX_DRAG_DIST)
            {
                resetContents();
            }
        }
        else if (touch.phase == TouchPhase.ENDED && mIsDown)
        {
            resetContents();
            dispatchEventWith(Event.TRIGGERED, true);
        }
    }

    /** Indicates if the button can be triggered. */
    public function get enabled():Boolean
    {
        return mEnabled;
    }

    public function set enabled(value:Boolean):void
    {
        if (mEnabled != value)
        {
            mEnabled=value;
            mContents.alpha=value ? 1.0 : mAlphaWhenDisabled;
            resetContents();

            if(mEnabled)
                addEventListener(TouchEvent.TOUCH, onTouch);
            else
                removeEventListener(TouchEvent.TOUCH, onTouch);
        }
    }

    override public function addQuiackChild(child:DisplayObject):void
    {
        mContents.addQuiackChild(child);
    }
    override public function addQuiackChildAt(child:DisplayObject, index:int):DisplayObject
    {
        return mContents.addQuiackChildAt(child,index);
    }
    override public function removeQuickChild(child:DisplayObject):void
    {
       mContents.removeQuickChild(child);
    }
    override  public function clearChild():void
    {
        mContents.clearChild();
    }

    override public function get numChildren():int
    {
        return mContents.numChildren;
    }
    override public function contains(child:DisplayObject):Boolean
    {
        return mContents.contains(child);
    }

    override public function getChildByName(name:String):DisplayObject
    {
        return mContents.getChildByName(name);
    }

    override public function removeChild(child:DisplayObject, dispose:Boolean=false):DisplayObject
    {
        return mContents.removeChild(child,dispose);
    }

    override public function removeChildAt(index:int, dispose:Boolean=false):DisplayObject
    {
        return mContents.removeChildAt(index,dispose);
    }

    override public function getChildAt(index:int):DisplayObject
    {
        return mContents.getChildAt(index);
    }

    override public function getChildIndex(child:DisplayObject):int
    {
        return mContents.getChildIndex(child);
    }

    override public function setChildIndex(child:DisplayObject, index:int):void
    {
        return mContents.setChildIndex(child,index);
    }

    override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
    {
        return mContents.swapChildren(child1,child2);
    }
    override public function swapChildrenAt(index1:int, index2:int):void
    {
        return mContents.swapChildrenAt(index1,index2);
    }

    override public function sortChildren(compareFunction:Function):void
    {
        return mContents.sortChildren(compareFunction);
    }

    override public function removeChildren(beginIndex:int=0, endIndex:int=-1, dispose:Boolean=false):void
    {
        return mContents.removeChildren(beginIndex,endIndex,dispose);
    }
}
}
