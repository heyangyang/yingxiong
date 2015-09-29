package game.view.vip {
    import com.langue.Langue;

    import game.data.VipData;
    import game.view.viewBase.VipRenderBase;

    public class VipRender extends VipRenderBase {
        public function VipRender() {
            super();
        }

        override public function set data(value:Object):void {
            super.data = value;
            var vipData:VipData = value as VipData;

            if (vipData == null) {
                return;
            }
            txt_vip.text = "VIP" + vipData.id + Langue.getLangue("VIP_Level_Privileges"); //等级特权;
            txt_des8.text = Langue.getLangue("VIP_Second"); //秒
            txt_des9.text = Langue.getLans("Mercenary_Icon_Value")[0]; //可以购买
            txt_des13.text = Langue.getLangue("tiredValue"); //疲劳值
            txt_des15.text = Langue.getLangue("VIP_Times"); //次
            txt_des14.text = Langue.getLangue("VIP_Arena_Challenge"); //竞技场挑战
            txt_des16.text = Langue.getLangue("VIP_Times"); //次
            txt_des7.text = Langue.getLangue("Chat_show_shortened"); //聊天显示缩短为
            txt_des6.text = Langue.getLangue("VIP_addSpeed"); //倍速
            txt_des2.text = Langue.getLangue("VIP_daSpree"); //大礼包
            txt_des5.text = Langue.getLangue("VIP_Fighting_Up"); //战斗加速提升至
            txt_des10.text = Langue.getLangue("everyday"); //每日
            txt_des17.text = Langue.getLangue("VIP_Luxury"); //豪华

            var selectedIndex:int = vipData.dayPrize;
            selectedIndex = selectedIndex < 0 ? 0 : selectedIndex;
            txt_day.text = VipData.getRewardName(VipData.list_dayReward[selectedIndex]);
            txt_vipLevel1.text = "vip" + vipData.id;
            txt_tired.text = vipData.tired_buy + "";
            txt_vipLevel2.text = Langue.getLangue("vipday"); //+ vipData.dayPrize;
            txt_best.text = VipData.getRewardName(VipData.list_reward[vipData.reward]);
            txt_speed.text = (vipData.fast / 10) + "";
            txt_chat.text = vipData.chat + "";
            txt_jingji.text = vipData.jingji_buy + "";
        }
    }
}
