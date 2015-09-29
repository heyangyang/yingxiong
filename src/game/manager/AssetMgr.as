package game.manager
{
	import com.mobileLib.utils.ConverURL;
	import com.singleton.Singleton;

	import avmplus.getQualifiedClassName;

	import starling.utils.AssetManager;

	public class AssetMgr extends AssetManager
	{
		public static function get instance() : AssetMgr
		{
			return Singleton.getInstance(AssetMgr) as AssetMgr;
		}

	/*	public function removeUi(name : String, home : String) : void
		{
			home += "/";
			delete _nameDic[ConverURL.conver(home + name + ".atf").url];
			delete _nameDic[ConverURL.conver(home + name + ".png").url];
			delete _nameDic[ConverURL.conver(home + name + ".xml").url];
			delete _nameDic[ConverURL.conver(home + name + ".axs").url];
			removeXml(name);
			removeByteArray(name);
			removeTexture(name);
			removeTextureAtlas(name);
		}*/
	}
}