package spriter {
    import com.utils.Constants;

    import flash.utils.Dictionary;

    import org.osflash.signals.Signal;

    import spriter.core.Animation;
    import spriter.core.ChildReference;
    import spriter.core.MainlineKey;
    import spriter.core.Timeline;
    import spriter.core.TimelineKey;

    import starling.animation.IAnimatable;
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     *
     * @author joy
     */
    public class SpriterClip extends Sprite implements IAnimatable {
        /**
         *
         * @default
         */
        protected static var TO_RADS:Number = Math.PI / 180;

        /**
         *
         * @default
         */
        protected var frameIndex:int = 0;
        /**
         *
         * @default
         */
        protected var frame:MainlineKey;
        /**
         *
         * @default
         */
        protected var nextFrame:MainlineKey;

        /**
         *
         * @default
         */
        protected var callbackList:Vector.<Callback>;
        /**
         *
         * @default
         */
        protected var swapHash:Object;
        /**
         *
         * @default
         */
        protected var imagesByTimeline:Object;
        /**
         *
         * @default
         */
        protected var imagesByName:Object;
        /**
         *
         * @default
         */
        protected var texturesByName:Object;
        /**
         *
         * @default
         */
        protected var texturesByImage:Dictionary;
        /**
         *
         * @default
         */
        protected var childImages:Vector.<Image>;

        /**
         *
         * @default
         */
        protected var _isPlaying:Boolean;
        /**
         *
         * @default
         */
        protected var currentColor:Number;

        /**
         *
         * @default
         */
        public var textureAtlas:TextureAtlas;
        /**
         *
         * @default
         */
        public var animations:Object;
        /**
         *
         * @default
         */
        public var animation:Animation;
        /**
         * 动画播放完成回调
         * @default
         */
        public var animationComplete:Signal;
        /**
         *
         * @default
         */
        public var position:Number;
        /**
         *
         * @default
         */
        public var animationWidth:Number;
        /**
         *
         * @default
         */
        public var animationHeight:Number;

        /**
         *
         * @default
         */
        protected var timelineId:int;
        /**
         *
         * @default
         */
        protected var textures:Vector.<Texture>;
        /**
         *
         * @default
         */
        protected var firstRun:Boolean;
        /**
         *
         * @default
         */
        protected var minX:int;
        /**
         *
         * @default
         */
        protected var minY:int;
        /**
         *
         * @default
         */
        protected var r:Number;
        /**
         *
         * @default
         */
        protected var child:TimelineKey;
        /**
         *
         * @default
         */
        protected var nextChild:TimelineKey;

        /**
         *
         * @default
         */
        protected var i:int;
        /**
         *
         * @default
         */
        protected var l:int;
        /**
         *
         * @default
         */
        protected var startTime:int;
        /**
         *
         * @default
         */
        protected var endTime:int;
        /**
         *
         * @default
         */
        protected var lerpAmount:Number;
        /**
         *
         * @default
         */
        protected var timeline:Timeline;
        /**
         *
         * @default
         */
        protected var key:TimelineKey;
        /**
         *
         * @default
         */
        protected var spinDir:int;
        /**
         *
         * @default
         */
        protected var angle1:Number;
        /**
         *
         * @default
         */
        protected var angle2:Number;
        /**
         *
         * @default
         */
        protected var rangeValue:Number;
        /**
         *
         * @default
         */
        protected var nameHash:String;
        /**
         *
         * @default
         */
        protected var tmpNameHash:String;
        /**
         *
         * @default
         */
        protected var clearChildren:Boolean;
        /**
         *
         * @default
         */
        protected var advanceFrame:Boolean;

        /**
         *
         * @param animations
         * @param textureAtlas
         *  @param recycleModule
         */

        public function SpriterClip(animations:Object, textureAtlas:TextureAtlas) {
            this.textureAtlas = textureAtlas;
            this.animations = animations;
            callbackList = new <Callback>[];
            swapHash = {};
            imagesByTimeline = {};
            texturesByName = {};
            imagesByName = {};
            texturesByImage = new Dictionary(true);
            childImages = new <Image>[];

            animationComplete = new Signal(SpriterClip);
            this.touchable = false;
        }

        /**
         * 往动画帧里添加回调
         * @param callback
         * @param time
         * @param addOnce
         */
        public function addCallback(callback:Function, time:int, addOnce:Boolean = true):void {
            if (time > animation.length) {
                time = animation.length;
            }
            callbackList.push(new Callback(callback, Math.min(time, animation.length), addOnce));
        }

        /**
         *
         * @return
         */
        public function get isPlaying():Boolean {
            return _isPlaying;
        }


        /**
         *
         * @param name
         * @param startPosition
         * @param clearCallbacks
         */
        public function play(name:String, startPosition:int = 0, clearCallbacks:Boolean = false):void {
            if (!animations) {
                return
            }
            if (!animations[name]) {
                return;
            }
            var ani:Animation = animations[name];
            if (!ani) {
                throw(new Error("[SpriterSprite] Unable to find animation name: " + name));
                return;
            }
            animation = ani;
            position = startPosition;

            //Empty the callback list
            if (clearCallbacks) {
                callbackList.length = 0;
            }

            _isPlaying = true;
            frameIndex = -1;
            var keys:Vector.<MainlineKey> = animation.mainline.keys;
            frame = keys[0];
            if (keys.length > 1) {
                nextFrame = keys[1];
            }
            update(0, true);
        }

        /**
         *
         */
        public function stop():void {
            _isPlaying = false;
        }

        /** Hook for Starling Juggler Interface **/
        public function advanceTime(time:Number):void {
            update(time * 1000);
        }

//        private var _timer:int;

        /**
         *
         * @param elapsed
         * @param forceNextFrame
         */
        public function update(elapsed:int = 0, forceNextFrame:Boolean = false):void {
            if (!_isPlaying) {
                return;
            }

            // Exit if we're not currently playing
            position += elapsed * Constants.speed;
            if (callbackList.length > 0) {
                updateCallbacks();
            }

            minX = minY = int.MAX_VALUE;
            startTime = frame.time;
            endTime = nextFrame ? nextFrame.time : 0;

            if (endTime == 0 || endTime > animation.length) {
                endTime = animation.length;
            }

            //Determine whether we need to advance a frame
            advanceFrame = false;
            //Clip is just starting...
            if (position == 0 || frameIndex == -1) {
                advanceFrame = true;
            }
            //Key frame has been passed
            if (position > endTime) {
                advanceFrame = true;
                //Reached the end of the timeline, don't advance keyFrame
                if (frameIndex == animation.mainline.keys.length - 2) {
                    advanceFrame = false;
                }
            }
            //Animation has completed, or Explicit override
            if (position > animation.length || forceNextFrame) {
                advanceFrame = true;
            }

            if (advanceFrame) {
                //Advance playhead
                var mainlinekeyslength:int = animation.mainline.keys.length;
                if (frameIndex < mainlinekeyslength - 2) {
                    if (frameIndex == -1) {
                        frameIndex = 0;
                    }

                    var k:Vector.<MainlineKey> = animation.mainline.keys;
                    while (k[frameIndex].time < position) {
                        frameIndex++;
                        if (frameIndex > mainlinekeyslength - 2) {
                            frameIndex = mainlinekeyslength - 2;
                            break;
                        }
                    }
                    if (animation.mainline.keys[frameIndex].time > position) {
                        frameIndex--;
                    }
                } else {
                    frameIndex = 0;
                }

                //trace("ADVANCE FRAME: " + position);
                //Animation complete?
                if (position > animation.length) {
                    position = 0;

                    var callbackListLen:int = callbackList.length;
                    for (i = 0; i < callbackListLen; i++) {
                        var call:Callback = callbackList[i];
                        call.called = false;
                    }

                    //Loop or stop pakying...
                    if (animation.looping) {
                        frameIndex = 0;
                    } else {
                        _isPlaying = false;
                    }
                    animationComplete.dispatch(this);
                    if (!_isPlaying) {
                        return;
                    }
                }

                if (frameIndex > 0 || animation.looping) {
                    frame = animation.mainline.keys[frameIndex];
                    if (animation.mainline.keys.length > frameIndex + 1) {
                        nextFrame = animation.mainline.keys[frameIndex + 1];
                    }
                    startTime = frame.time;
                    endTime = nextFrame ? nextFrame.time : 0;
                    if (endTime == 0) {
                        endTime = animation.length;
                    }
                }
                firstRun = this.numChildren == 0;
//                firstRun= 0
//                container.reset();
                //Optimization, check whether we need to remove any children?
                optimizedRemoveChildren();
                childImages.length = 0;
                var refs:Vector.<ChildReference> = frame.refs;
                var len:int = refs.length;
                var childNum:int = 0;
                for (i = 0, l = len; i < l; i++) {
                    timelineId = refs[i].timeline;
                    if (animation.timelineList[timelineId].keys.length == 0) {
                        continue;
                    }
                    child = animation.timelineList[timelineId].keys[frame.refs[i].key];

                    if (!child.pieceName) {
                        continue;
                    }

                    //Create one image/timeline, and cache it off.
                    var image:Image = imagesByTimeline[timelineId];
                    if (!image) {
                        image = createImageByName(child.pieceName);
                        imagesByTimeline[timelineId] = image;
                    }
//                childImages.push(image);
                    childImages[childNum++] = image;
                    //Add the child to displayList if it isn't already
                    if (!image.parent) {
//                        container.addQuiackChild(image);
                        this.addQuiackChild(image);
                    }
                    //Make sure the image has the textures it's supposed to (one timeline can have multiple images).
                    var texture:Texture = getTexture(child.pieceName);
                    if (texturesByImage[image] != texture) {
                        texturesByImage[image] = texture;
                        image.texture = texture;
                    }

                    image.pivotX = child.pixelPivotX;
                    image.pivotY = child.pixelPivotY;

                    image.x = child.x;
                    if (image.x < minX) {
                        minX = image.x;
                    }

                    image.y = -child.y;
                    if (image.y < minY) {
                        minY = image.y;
                    }

                    image.scaleX = child.scaleX;
                    image.scaleY = child.scaleY;
                    image.rotation = fixRotation(child.angle) * TO_RADS;
                }
                //Measure this animation
                if (frameIndex == 0 /*&& isNaN(animationWidth) && isNaN(animationWidth)*/) {
                    var minXt:int = minX * 2;
                    minXt = (minXt + (minXt >> 31)) ^ (minXt >> 31);
                    var minYt:int = minY * 2;
                    minYt = (minYt + (minYt >> 31)) ^ (minYt >> 31);
                    animationWidth = minXt + this.width;
                    animationHeight = minYt + this.height;
                }
            }

            //Small, Incremental interpolated update
            if (position < endTime) {
                spinDir = 0;
                len = frame.refs.length;
                for (i = 0, l = len; i < l; i++) {
                    //Get the most recent previous timeline for reference
                    timeline = animation.timelineList[frame.refs[i].timeline];
                    if (!timeline.keys.length) {
                        continue;
                    }

                    var lerpStart:Number = startTime;
                    var lerpEnd:Number = endTime;
                    child = null;
                    nextChild = null;
                    key = timeline.keys[0];
                    var keys:Vector.<TimelineKey> = timeline.keys;
                    //Find the previous and next key's for this particular timeline.
                    var keysLen:int = keys.length;
                    for (var i2:int = 0, l2:int = keysLen; i2 < l2; i2++) {
                        var timelineKey:TimelineKey = keys[i2];
                        //Looks for end frame
                        if (timelineKey.time > position) {
                            if (!nextChild) {
                                nextChild = timelineKey;
                                lerpEnd = timelineKey.time;
                            } else {
                                break;
                            }
                        }
                        //Look for start frame
                        if (timelineKey.time <= position) {
                            child = timelineKey;
                            lerpStart = timelineKey.time;
                        }
                    }
                    //If we couldn't find a next frame, this animation file is probably missing an endFrame. Substitute startFrame.
                    if (!nextChild) {
                        nextChild = keys[0];
                        lerpEnd = animation.length;
                    }

                    //Determine interpolation amount
                    lerpAmount = (position - lerpStart) / (lerpEnd - lerpStart);

                    image = imagesByTimeline[timeline.id];
                    if (!image) {
                        image = createImageByName(child.pieceName);
                        imagesByTimeline[timelineId] = image;
                    }

                    if (child.pixelPivotX != nextChild.pixelPivotX) {
                        image.pivotX = child.pixelPivotX + (nextChild.pixelPivotX - child.pixelPivotX) * lerpAmount;
                    }
                    if (child.pixelPivotY != nextChild.pixelPivotY) {
                        image.pivotY = child.pixelPivotY + (nextChild.pixelPivotY - child.pixelPivotY) * lerpAmount;
                    }

                    if (child.x != nextChild.x) {
                        image.x = child.x + (nextChild.x - child.x) * lerpAmount;
                    }
                    if (child.y != nextChild.y) {
                        image.y = -child.y - (nextChild.y - child.y) * lerpAmount;
                    }

                    if (child.scaleX != nextChild.scaleX) {
                        image.scaleX = child.scaleX + (nextChild.scaleX - child.scaleX) * lerpAmount;
                    }
                    if (child.scaleY != nextChild.scaleY) {
                        image.scaleY = child.scaleY + (nextChild.scaleY - child.scaleY) * lerpAmount;
                    }
                    //if (child.alpha != nextChild.alpha)
                    var ta:Number = child.alpha + (nextChild.alpha - child.alpha) * lerpAmount;
                    if (image.alpha != ta) {
                        image.alpha = ta;
                    }

                    if (child.angle != nextChild.angle) {
                        //Rotate to closest direction (ignore 'dir' for now, it's unsupported in the current Spriter A4 build)
                        angle1 = child.angle;
                        angle2 = nextChild.angle;
                        rangeValue = angle2 - angle1;
                        rangeValue = fixRotation(rangeValue);

                        r = angle1 + rangeValue * lerpAmount;
                        image.rotation = r * TO_RADS;
                    }
                }
            }

        }

        [Inline]
        /**
         *
         * @param rotation
         * @return
         */
        protected function fixRotation(rotation:Number):Number {
            if (rotation > 180) {
                rotation -= 360;
            } else if (rotation < -180) {
                rotation += 360;
            }
            return rotation;
        }

        [Inline]
        /**
         *
         */
        final protected function optimizedRemoveChildren():void {
            clearChildren = true;
            if (childImages.length > 0) {
                tmpNameHash = "";
                var len:int = childImages.length;
                for (i = 0, l = len; i < l; i++) {
                    tmpNameHash += childImages[i].name + "|";
                }
                if (tmpNameHash == nameHash && nameHash != "") {
                    clearChildren = false;
                }
                nameHash = tmpNameHash
            }
            if (clearChildren) {
                //trace("Remove Children");
                this.clearChild();
//                container.reset();

            }
        }

        [Inline]
        /**
         *处理回调
         */
        final protected function updateCallbacks():void {
            var len:int = callbackList.length;
            for (var i:int = len - 1; i >= 0; i--) {
                if (callbackList.length == 0) {
                    break;
                }
                var call:Callback = callbackList[i];
                if (call.time <= position && call.called != true) {
                    call.call();
                    if (call.addOnce) {
                        callbackList.splice(i, 1);
                    } else {
                        call.called = true;
                    }
                }
            }
        }

        [Inline]
        /**
         *
         * @param name
         * @return
         * @throws (newError("[SpriterSprite] ERROR: Unable to find a texture for piece named: "+name+". Make sure you've passed the correct folder prefix to your Animation Set (if you're using one)"))
         */
        protected function createImageByName(name:String):Image {

            //Check if there's an existing swap for this image
            var swapName:String = name;
            if (swapHash[name]) {
                swapName = swapHash[name];
            }
            //trace("[CreateImage] " + name);

            var texture:Texture = getTexture(swapName);
            //If we couldn't retrieve a swap, use the original as a fallback
            if (!texture) {
                texture = getTexture(name);
            }

            var image:Image = new Image(texture);
            //image.smoothing = TextureSmoothing.NONE;
            image.name = name;
            if (!isNaN(currentColor)) {
                image.color = currentColor;
            }
            imagesByName[name] = image;

            return image;
        }

        /**
         *
         * @param value
         */
//    public function setColor(value:Number):void
//    {
//        for (var name:String in imagesByName)
//        {
//            imagesByName[name].color=value;
//        }
//        currentColor=value;
//    }
        [Inline]
        /**
         *
         * @param name
         * @return
         */
        public function getTexture(name:String):Texture {
            if (!texturesByName[name]) {
                var textures:Vector.<Texture> = textureAtlas.getTextures(name);
                if (textures.length == 0) {
                    return null;
                }
                texturesByName[name] = textures[0];
            }
            return texturesByName[name];
        }

        /**
         *
         * @param name
         * @return
         */
//    public function getImage(name:String):Image
//    {
//        return imagesByName[name];
//    }

        /**
         *
         * @param piece
         * @param newPiece
         */
//    public function swapPiece(piece:String, newPiece:String):void
//    {
//        var newTex:Texture=getTexture(newPiece);
//        if (!newTex)
//        {
//            newTex=getTexture(newPiece);
//        } //Check for preceding forward slash, newer versions of Spriter seem to add this.
//        if (!newTex)
//        {
//            return;
//        } //Can't swap if we can't find this textures
//
//        for each(var image:Image in imagesByTimeline)
//        {
//            if (image.name == piece)
//            {
//                image.texture=newTex;
//            }
//        }
//    }


        /**
         *
         * @param piece
         * @param newTex
         */
        public function swapPieceByTex(piece:String, newTex:Texture):void {
            if (!newTex) {
                return;
            } //Can't swap if we can't find this textures

            for each (var image:Image in imagesByTimeline) {
                if (image.name == piece) {
                    image.texture = newTex;
                }
            }
        }

        /**
         *
         * @param piece
         */
        public function unswapPiece(piece:String):void {
            for each (var image:Image in imagesByTimeline) {
                if (image.name == piece) {
                    image.texture = getTexture(piece);
                }
            }
        }

        override public function dispose():void {

            for each (var image:Image in imagesByTimeline) {
                image.removeFromParent();
                image.dispose();
            }
            stop();
            Starling.juggler.remove(this);

            animations = null;
            animationComplete.removeAll();
            callbackList.length = 0;
            this.removeFromParent();
            super.dispose();

        }
    }
}
