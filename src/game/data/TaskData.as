package game.data {
    import com.data.Data;
    import com.data.HashMap;

    import flash.utils.ByteArray;

    import game.net.data.IData;
    import game.net.data.vo.TaskPlan;
    import game.view.uitils.Res;


    public class TaskData extends Data {

        /**任务ID*/
        public var TaskId:int;
        /**任务类型*/
        public var TaskType:int;
        /**任务名字*/
        public var TaskName:String;
        /**任务说明*/
        public var TaskDes:String;
        /**任务目标*/
        public var TaskTarget:int;
        /**进入等级限制*/
        public var TaskLevel:int;
        /**进入关卡限制*/
        public var TaskTollgate:int;
        /**任务奖励*/
        public var TaskAward:String;
        /**任务进度*/
        public var TaskCondition:String;
        /**操作任务的类型*/
        public var OperTaskType:int;
        /**操作任务的子类型*/
        public var OperTaskChlidType:int;


        /**任务状态 0=未完成,1=可以领取*/
        public var state:int;
        /**动态任务进度*/
        public var taskVector:Vector.<IData>;
        /**是否是new*/
        public var isNew:Boolean;
        /**是否已经执行了一次提示*/
        public var isTips:Boolean;

        public static var hash:HashMap;

        public static function init(data:ByteArray):void {
            hash = new HashMap();
            initData(data, hash, TaskData, "TaskId");
        }

        public function GetTaskRwad(buttonModel:Boolean = true, visibleName:Boolean = false):Vector.<IconData> {
            var dataVector:Vector.<IconData> = new Vector.<IconData>;
            if (TaskAward == null) {
                return dataVector;
            }
            var i:int = 0;
            var itemData:Goods = null;
            var items:Array = null;
            var itemExp:RegExp = /\d+/gs;
            var goodsExp:RegExp = /\{[\d,\,]*\}/gs;
            var iconData:IconData = null;
            var goods:Array = TaskAward.match(goodsExp); //奖励物品
            var goodsLen:int = goods.length;
            for (i = 0; i < goodsLen; i++) {
                items = goods[i].match(itemExp);
                itemData = Goods.goods.getValue(items[0]);
                iconData = new IconData();
                if (itemData.type > 30000 && itemData.type < 40000 || itemData.type < 100 && itemData.type != 5) {
                    iconData.QualityTrue = Res.instance.getQualityToolTextures(0);
                } else {
                    iconData.QualityTrue = Res.instance.getQualityToolTextures(itemData.quality);
                }

                if (itemData.type > 30000 && itemData.type < 40000) {
                    var hero:HeroData = HeroData.hero.getValue(itemData.type) as HeroData;
                    iconData.IconTrue = (hero.show > 0) ? (RoleShow.hash.getValue(hero.show) as RoleShow).photo : "ui_gongyong_100yingxiongkuang_kong";
                } else {
                    iconData.IconTrue = itemData.picture;
                }

                iconData.Num = "x " + items[1];
                iconData.IconId = itemData.type;
                iconData.IconType = itemData.type;
                if (visibleName) {
                    iconData.Name = String(itemData.name);
                }
                if (buttonModel) {
                    iconData.ButtonModel = buttonModel;
                }
                dataVector.push(iconData);
            }
            return dataVector;
        }

        /**任务进度列表*/
        public function get TaskPlanVector():Vector.<TaskPlan> {
            var dataVector:Vector.<TaskPlan> = new Vector.<TaskPlan>;
            var i:int = 0;
            var items:Array = null;
            var itemExp:RegExp = /\d+/gs;
            var goodsExp:RegExp = /\{[\d,\,]*\}/gs;
            var taskPlan:TaskPlan = null;
            var goods:Array = TaskCondition.match(goodsExp); //奖励物品
            var goodsLen:int = goods.length;
            for (i = 0; i < goodsLen; i++) {
                items = goods[i].match(itemExp);
                taskPlan = new TaskPlan();
                taskPlan.type = items[0];
                taskPlan.number = items[1];
                dataVector.push(taskPlan);
            }
            return dataVector;
        }

    }

}


