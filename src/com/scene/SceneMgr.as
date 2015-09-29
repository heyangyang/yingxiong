package com.scene
{
import com.singleton.Singleton;
import com.utils.Constants;

import flash.geom.Rectangle;

import starling.display.DisplayObjectContainer;

/**
     * 场景管理
     * @author Michael
     *
     */
    public class SceneMgr
    {
        private var container:DisplayObjectContainer; //场景容器
        /**
         * 当前场景数据
         */
        public var sceneClass:Class;
        private var currScene:BaseScene;

        public function SceneMgr()
        {

        }

        public static function get instance():SceneMgr
        {
            return Singleton.getInstance(SceneMgr) as SceneMgr;
        }


        /**
         * 必须初始化
         * @param stage
         *
         */
        public function init(stage:DisplayObjectContainer):void
        {
            this.container=stage;
        }

        public function getCurScene():IScene
        {
            return currScene;
        }

        public function isScene(stateClass:Class):Boolean
        {
            return currScene is stateClass;
        }

        /**
         * 转换场景
         * @param stateName
         *
         */
        public function changeScene(stateClass:Class, param:Object=null):BaseScene
        {
            if (stateClass == null)
            {
                return currScene;
            }

            if (sceneClass == stateClass)
            {
                if(param) currScene.data=param;
                return currScene;
            }

            sceneClass=stateClass;

            if (currScene)
            {
                currScene.dispose();
            }

            currScene=new stateClass() as BaseScene;
            currScene.data=param;
            container.addChild(currScene);

            currScene.clipRect=new Rectangle(0, 0, Constants.virtualWidth, Constants.virtualHeight);
            currScene.scaleX=currScene.scaleY=Constants.scale;

            return currScene;
        }
/*
        private var isLoadRes:Boolean;
        public function LoadResChange(stateClass:Class,param:Object,assets:AssetManager,resArr:Array,callback:Function = null):BaseScene
        {
            if (stateClass == null)
            {
                trace(this,"stateClass == null");
                return currScene;
            }

            if (sceneClass == stateClass)
            {
                trace(this,"sceneClass == stateClass");
                return currScene;
            }

            if(isLoadRes)
            {
                trace(this,"isLoadRes ",isLoadRes);
                return null;
            }

            changeScene(LoadingScene);
            assets.enqueue(resArr);
            isLoadRes = true;
            assets.loadQueue(onComplete);
            function onComplete(ratio:Number):void {
                if (ratio == 1.0) {
                  var s:BaseScene =  changeScene(stateClass,param);
                    if(callback != null)
                    {
                        callback(s);
                    }
                    isLoadRes = false;
                }
            }
            return null;
        }*/
    }
}
