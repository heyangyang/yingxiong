package game.scene.world {
    import game.data.MonsterData;
    import game.view.uitils.Res;
    import game.view.viewBase.MonsterItemRenderBase;

    public class MonsterItemRender extends MonsterItemRenderBase {
        public function MonsterItemRender() {
            super();
            headBtn1.touchable = headBtn2.touchable = false;
        }

        override public function set data(value:Object):void {
            super.data = value;
            if (value == null) {
                return;
            }

            var monsterData:MonsterData = MonsterData.monster.getValue(value.id);
            if (value.type == 0) {
                headBtn2.visible = false;
                headBtn1.visible = true;
            } else {
                headBtn1.visible = false;
                headBtn2.visible = true;
            }
            head.texture = Res.instance.getHeroIconTexture(monsterData.show);
        }
    }
}
