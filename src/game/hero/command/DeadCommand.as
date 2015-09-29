package game.hero.command
{
import game.data.HeroData;
import game.hero.Hero;

import starling.core.Starling;

/**
	 * 死亡
	 * @author Michael
	 *
	 */
	public class DeadCommand extends Command
	{
		public function DeadCommand(executor:Hero)
		{
			super(executor);
		}

		override public function execute():void
		{
            if(_hero.data.team == HeroData.BLUE)
            {
                _hero.playDieAnimation(onCompleteHer);
            }
            else
            {
                Starling.juggler.tween(_hero, 0.3, {alpha: 0, onComplete: onCompleteHer});
            }
		}

		private function onCompleteHer(o:Object = null):void
		{
            Starling.juggler.removeTweens(_hero);
            _hero.visible = false;
            _hero.stopAnimation();
            onComplete.dispatch(this);
		}
	}
}


//6222 9800 6063 7529