package game.net.data.vo {
    import flash.utils.ByteArray;
    import game.net.data.DataBase;
    import game.net.data.vo.*;
    import game.net.data.IData;

    public class sweepResultVOS extends DataBase {
        public var nth:int;
        public var sweepResult:Vector.<int>;
        public var sweepResultExtra:Vector.<int>;

        public function sweepResultVOS() {
        }

        /**
         *
         * @param data
         */
        override public function deSerialize(data:ByteArray):void {
            super.deSerialize(data);
            nth = data.readInt();
            sweepResult = readArrayInt();
            sweepResultExtra = readArrayInt();
        }

        override public function serialize():ByteArray {
            var byte:ByteArray = new ByteArray();
            byte.writeInt(nth);
            writeInts(sweepResult, byte);
            writeInts(sweepResultExtra, byte);
            return byte;
        }
    }
}

// vim: filetype=php :
