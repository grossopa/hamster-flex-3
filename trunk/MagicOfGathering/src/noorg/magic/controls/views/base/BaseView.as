package noorg.magic.controls.views.base
{
	import mx.containers.Canvas;
	import mx.effects.Fade;
	import mx.effects.TweenEffect;
	import mx.events.TweenEvent;

	public class BaseView extends Canvas
	{
		private var _showEffect:TweenEffect = new Fade(this);
		
		public function set showEffect(value:TweenEffect):void
		{
			_showEffect = value;
		}
		
		public function BaseView()
		{
			super();
			
			_showEffect.duration = 1000;
			Fade(_showEffect).alphaFrom = 0;
			Fade(_showEffect).alphaTo = 1;
			this.visible = false;
		}
		
		public function showView(effect:TweenEffect = null):void
		{
			if (effect != null) {
				_showEffect = effect;
			}
			if (_showEffect != null) {
				_showEffect.target = this;
				_showEffect.duration = 1000;
				_showEffect.play();
			}
			this.visible = true;
		}
		
		public function hideView(effect:TweenEffect = null):void
		{
			if (effect != null) {
				_showEffect = effect;
			}
			if (_showEffect != null) {
				_showEffect.target = this;
				_showEffect.duration = 1000;
				_showEffect.addEventListener(TweenEvent.TWEEN_END, showEffEndHandler);
				_showEffect.play(null, true);
			}			
		}
		
		public function showEffEndHandler(evt:TweenEvent):void
		{
			_showEffect.removeEventListener(TweenEvent.TWEEN_END, showEffEndHandler);
			
			this.parent.removeChild(this);
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			
		}
		
	}
}