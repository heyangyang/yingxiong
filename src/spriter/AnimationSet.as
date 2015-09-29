package spriter
{
    import spriter.core.Animation;
    import spriter.core.ChildReference;
    import spriter.core.Mainline;
    import spriter.core.MainlineKey;
    import spriter.core.Timeline;
    import spriter.core.TimelineKey;

    public class AnimationSet
    {

        public static function generateXML(data:XML):Object
        {
            var animationsByName:Object=AnimationPool.instance.pool[data];
            if (animationsByName)
            {
                return animationsByName;
            }
            animationsByName={};
            AnimationPool.instance.pool[data]=animationsByName;
            var anim:Animation;
            var mainlineKeys:Vector.<MainlineKey>;
            var mainlineKey:MainlineKey;
            var timelineKeys:Vector.<TimelineKey>;
            var timelineKey:TimelineKey;

            var animation:XMLList=data.entity.animation;
            for each (var animData:XML in animation)
            {
                anim=new Animation();
                anim.id=animData.@id;
                anim.name=animData.@name;
                anim.length=animData.@length;
                anim.looping=(animData.@looping == undefined || animData.@looping == true);
                var timelineList:Vector.<Timeline>=anim.timelineList;
                var timelineListCount:int=0;
                //Add timelines
                var timeline:XMLList=animData.timeline;
                for each (var timelineData:XML in timeline)
                {
                    timelineKeys=new <TimelineKey>[];
                    var keyCount:int=0;
                    var timeLine:Timeline=new Timeline();
                    timeLine.keys=timelineKeys;
                    timeLine.id=timelineData.@id;
                    timelineList[timelineListCount++]=timeLine;
                    //Add TimelineKeys
                    var timelineDataKey:XMLList=timelineData.key;
                    for each (var keyData:XML in timelineDataKey)
                    {
                        timelineKey=new TimelineKey();

                        timelineKey.id=keyData.@id;
                        timelineKey.time=keyData.@time;
                        timelineKey.spin=keyData.@spin;

                        //Check whether it's a bone (Assume: if not an object, it must be a bone)
                        var isBone:Boolean=false;
                        var childData:XML=keyData..object[0];
                        if (!childData)
                        {
                            childData=keyData..bone[0];
                            isBone=true;
                        }
                        if (!childData || childData.@file == undefined)
                        {
                            continue;
                        }

                        timelineKey.x=childData.@x;
                        timelineKey.y=childData.@y;
                        timelineKey.angle=childData.@angle;
                        timelineKey.alpha=(childData.@a == undefined) ? 1 : childData.@a;

                        //Convert to flash degrees (spriters uses 0-360, flash used 0-180 and -180 to -1)
                        var rotation:Number=timelineKey.angle;
                        if (rotation >= 180)
                        {
                            rotation=360 - rotation;
                        }
                        else
                        {
                            rotation=-rotation;
                        }
                        timelineKey.angle=rotation;

                        //Ignore bones
                        if (!isBone)
                        {
                            var xml:XMLList=data.folder.(@id == childData.@folder).file.(@id == childData.@file);
                            var pieceName:String=xml.@name;
                            var pieceWidth:int=xml.@width;
                            var pieceHeight:int=xml.@height;
                            timelineKey.pivotX=(childData.@pivot_x == undefined) ? 0 : childData.@pivot_x;
                            timelineKey.pivotY=(childData.@pivot_y == undefined) ? 1 : childData.@pivot_y;

                            pieceName=pieceName.split(".")[0];
                            //Strip preceding classes (Spriter is injecting them for no reason. Bug?)
                            if (pieceName.substr(0, 1) == "/")
                            {
                                pieceName=pieceName.substr(1);
                            }
                            timelineKey.pieceName=pieceName;
                            timelineKey.pixelPivotX=pieceWidth * timelineKey.pivotX;
                            timelineKey.pixelPivotY=pieceHeight * (1 - timelineKey.pivotY);
                        }
                        timelineKey.scaleX=(childData.@scale_x == undefined) ? 1 : childData.@scale_x;
                        timelineKey.scaleY=(childData.@scale_y == undefined) ? 1 : childData.@scale_y;

                        timelineKeys[keyCount++]=timelineKey;
                    }
                }

                //Add Mainline
                mainlineKeys=new <MainlineKey>[];
                var mainlinekey:XMLList=animData.mainline.key;
                var countmainlineKey:int=0;
                for each (var mainKey:XML in mainlinekey)
                {

                    //Add Main Keyframes
                    mainlineKey=new MainlineKey();
                    mainlineKey.id=mainKey.@id;
                    mainlineKey.time=mainKey.@time;
                    mainlineKeys[countmainlineKey++]=mainlineKey;
                    //Add Object to KeyFrame
//                    var object_ref:XMLList = mainKey.object_ref;
//                    mainlineKey.refs = object_ref;

                    mainlineKey.refs=new <ChildReference>[];
                    for each (var refData:XML in mainKey.object_ref)
                    {
                        var ref:ChildReference=new ChildReference();
                        ref.id=refData.@id;
                        ref.timeline=refData.@timeline; //timelineId
                        ref.key=refData.@key; //timelineKey
                        ref.zIndex=refData.@z_index;
                        mainlineKey.refs.push(ref);
                    }
                }

                //A bit of a hack to support Animation Looping...
                if (anim.looping && anim.length > mainlineKey.time)
                {
                    //Automatically insert a new MainLineKey at the very end of the animation,
                    var endKey:MainlineKey=new MainlineKey();
                    endKey.time=anim.length;
                    endKey.id=mainlineKey.id + 1;
                    //Use the references from the first frame to create the looping effect
                    endKey.refs=mainlineKeys[0].refs;
                    mainlineKeys.push(endKey);
                }
                var mainline:Mainline=new Mainline();
                mainline.keys=mainlineKeys;
                anim.mainline=mainline;
                animationsByName[anim.name]=anim;
            }

            return animationsByName;
        }
    }
}


