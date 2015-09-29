package com.utils {
    import flash.display.Bitmap;
    import flash.utils.Dictionary;

    import starling.core.Starling;
    import starling.display.Image;
    import starling.textures.Texture;

    public class Assets {
        // 简体logo
        [Embed(source = "../../../assets_mst/logo.png")]
        public static var Logo:Class;
        // 繁体logo
        [Embed(source = "../../../assets_mst/logo_ft.png")]
        public static var Logo_FT:Class;

        // 英文logo
        [Embed(source = "../../../assets_mst/logo_en.png")]
        public static var Logo_En:Class;

        public static var Logo_IMAGE:Bitmap;
        // 加载转圈圈图标
        [Embed(source = "../../../assets_mst/loding.png")]
        public static var LoadingICO:Class;

        [Embed(source = "../../../assets_mst/lodingdi.png")]
        public static var LoadingICO_BG:Class;

        // 脏字库
        [Embed(source = "../../../assets_mst/dirtyword.txt", mimeType = "application/octet-stream")]
        public static var Dirtyword:Class;
        // 随机玩家游戏名字库
        [Embed(source = "../../../assets_mst/username.xml", mimeType = "application/octet-stream")]
        public static var Username:Class;

        // 随机英文玩家游戏名字库
        [Embed(source = "../../../assets_mst/name_eng.txt", mimeType = "application/octet-stream")]
        public static var Username_En:Class;

        [Embed(source = "../../../assets_mst/MsgAssets.png")]
        public static var MsgAssetsPNG:Class;
        [Embed(source = "../../../assets_mst/MsgAssets.xml", mimeType = "application/octet-stream")]
        public static var MsgAssetsXML:Class;

        [Embed(source = "../../../assets_mst/RollTipsBG.png")]
        public static var RollTipsBG:Class;


        [Embed(source = "../../../assets_mst/ui_gongyong_heisetongmingding50.png")]
        public static var Alpha_Backgroud:Class;


        /**
         * Texture Cache
         */
        private static var gameTextures:Dictionary = new Dictionary();
        private static var gameXml:Dictionary = new Dictionary();

        public static function getXML(xmlClass:Class):XML {
            if (gameXml[xmlClass] == undefined) {
                var xml:XML = XML(new xmlClass())
                gameXml[xmlClass] = xml;
            }

            return gameXml[xmlClass];
        }

        public static function getImage(className:Class):Image {
            return new Image(getTexture(className));
        }

        public static function getTexture(className:Class):Texture {
            if (gameTextures[className] == undefined) {
                var texture:Texture = Texture.fromEmbeddedAsset(className);
                gameTextures[className] = texture;

                if (Starling.handleLostContext) {
                    texture.root.onRestore = function():void {
                        texture.root.uploadBitmap(new className());
                    };
                }
            }
            return gameTextures[className];
        }
    }
}
