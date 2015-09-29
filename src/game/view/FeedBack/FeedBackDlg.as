package game.view.FeedBack
{
	import com.components.RollTips;
	import com.dialog.DialogMgr;
	import com.langue.Langue;
	import com.mvc.interfaces.INotification;
	import com.utils.StringUtil;

	import flash.text.TextFormat;

	import feathers.controls.TextArea;
	import feathers.events.FeathersEventType;

	import game.common.JTGlobalDef;
	import game.dialog.DialogBackgroundView;
	import game.dialog.ShowLoader;
	import game.managers.JTFunctionManager;
	import game.net.GameSocket;
	import game.net.data.c.CFeedback;
	import game.net.data.s.SFeedback;
	import game.view.viewBase.FeedBackDlgBase;

	import starling.events.Event;
	import starling.text.TextField;

	/**
	 * 反馈
	 * @author Samuel
	 *
	 */
	public class FeedBackDlg extends FeedBackDlgBase
	{
		private var _textInput:TextArea=new TextArea();
		private var default_text:TextField=new TextField(534, 30, "", "", 24, 0xffffff);

		public function FeedBackDlg()
		{
			super();
		}

		override protected function listTabButton():Array
		{
			tab_1.text=Langue.getLangue("feedbackDlgSuggestion");
			tab_2.text=Langue.getLangue("feedbackDlgBug");
			return [tab_1, tab_2];
		}

		override protected function init():void
		{
			enableTween=true;
			_closeButton=closeBtn;

			default_text.hAlign='left';
			_textInput.width=infoTxt.width;
			_textInput.height=infoTxt.height;
			this.addChild(_textInput);
			this.addChild(default_text);
			default_text.x=_textInput.x=infoTxt.x;
			default_text.y=_textInput.y=infoTxt.y;
			_textInput.padding=4;
			_textInput.textEditorProperties.textFormat=new TextFormat("", 21, 0xffffff);
			_textInput.maxChars=280;

			default_text.text=getLangue("feedbackDlgInitInfo");
			tips1.text=Langue.getLangue("feedbackDlgTips1");
			tips2.text=Langue.getLangue("feedbackDlgTips2");
			submit_Scale9Button.text=Langue.getLangue("submit_name");
		}

		override protected function addListenerHandler():void
		{
			super.addListenerHandler();
			_textInput.addEventListener(FeathersEventType.FOCUS_IN, onFocusIn);
			_textInput.addEventListener(FeathersEventType.FOCUS_OUT, onFocusOut);
			submit_Scale9Button.addEventListener(Event.TRIGGERED, onSubmitButton);
		}

		private function onSubmitButton(e:Event):void
		{
			_textInput.text=StringUtil.trim(_textInput.text);
			if (_textInput.text == "" || _textInput.text == Langue.getLangue("feedbackDlgInitInfo"))
			{
				RollTips.add(Langue.getLangue("feedbackDlgSubmitEmpty"));
			}
			else
			{
				var cmd:CFeedback=new CFeedback();
				cmd.type=defaultSelect + 1;
				cmd.content=_textInput.text;
				GameSocket.instance.sendData(cmd);
				ShowLoader.add();
			}
		}

		override public function handleNotification(_arg1:INotification):void
		{
			if (_arg1.getName() == String(SFeedback.CMD))
			{
				var snotice:SFeedback=_arg1 as SFeedback;
				updateSubmit(snotice);
			}
			ShowLoader.remove();
		}

		override public function listNotificationName():Vector.<String>
		{
			var vect:Vector.<String>=new Vector.<String>;
			vect.push(SFeedback.CMD);
			return vect;
		}

		private function updateSubmit(info:SFeedback):void
		{
			if (info.code == 0) //成功
			{
				RollTips.add(Langue.getLangue("feedbackDlgSubmitSucceed"));
			}
			else if (info.code == 1) //失败
			{
				RollTips.add(Langue.getLangue("feedbackDlgSubmitError"));
			}
			close();
		}

		private function onFocusIn():void
		{
			_textInput.selectRange(0, _textInput.text.length);
			default_text.visible=false;
		}

		private function onFocusOut():void
		{
			if (_textInput.text != "")
			{
				default_text.text=_textInput.text;
			}
			else
			{
				default_text.text=getLangue("feedbackDlgInitInfo");
			}
			default_text.visible=true;
		}

		override public function dispose():void
		{
			_textInput.dispose();
			default_text.dispose();
			_textInput=null;
			default_text=null;
			super.dispose();
		}
	}
}
