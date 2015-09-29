
package game.view.blacksmith.render {
    import game.view.viewBase.EquipContainerBase;

    public class EquipContainer extends EquipContainerBase {
        public function EquipContainer() {
            icon.visible = false;
            btnBg.container.addChild(icon);
            btnBg.container.addQuiackChild(quality);
            btnBg.container.addQuiackChild(ad);
            btnBg.container.addChild(txt);
        }
    }
}
