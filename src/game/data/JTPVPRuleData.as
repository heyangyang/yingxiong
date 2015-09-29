package game.data
{
    import com.data.Data;
    import com.data.HashMap;

    import flash.utils.ByteArray;

    public class JTPVPRuleData extends Data
    {
        public var num:int=0;
        public var up:int=0;
        public var down:int=0;
        public var produce:String;
        public var exp:int;
        public var diamon:int;
        public static var hash:HashMap=null;

        public function JTPVPRuleData()
        {
            super();
        }


        public static function init(data:ByteArray):void
        {
            hash=new HashMap();
            initData(data, hash, JTPVPRuleData);
        }
    }
}
