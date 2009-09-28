package org.hamster.components
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import org.hamster.effects.advancedviewstack.FadeAVS;
	import org.hamster.effects.advancedviewstack.base.IAdvancedViewStackEffect;
	import org.hamster.utils.ImageUtil;
	
	import mx.containers.Canvas;
	import mx.containers.ViewStack;
	import mx.controls.Image;
	import mx.effects.IEffect;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;

	/**
	 * @author jack yin grossopforever@gmail.com
	 * 
	 * This component is extend Canvas rather than ViewStack because it will
	 * perform some animation on change children. A viewStack is composited
	 * to this class.
	 */
	public class AdvancedViewStack extends Canvas
	{
		public static const TURN_RIGHT:int = -1;
		public static const TURN_LEFT:int = 1;
		
		// turn left index -->> index - 1
		// turn right index -->> index + 1
		public var direction:int = TURN_LEFT;
		public var duration:Number = 1000;
		
		//see getter/setter functions
		private var _viewStack:ViewStack;
		private var _backgroundRenderer:Canvas;
		private var _isPlaying:Boolean;
		
		// animation type
		private var avsEffect:IAdvancedViewStackEffect;
		
		// stores all temp images
		private var curImages:Array;
		private var nextImages:Array;
		
		public function get isPlaying():Boolean
		{
			return this._isPlaying;
		}
		
		private function get _eff1():Array
		{
			return avsEffect.eff1;
		}
		
		private function get _eff2():Array
		{
			return avsEffect.eff2;
		}
		
		private function get _isQueue():Boolean
		{
			return avsEffect.isQueue;
		}
		
		/**
		 * call this function just like this:
		 * setAnimationClass(FadeAVS);
		 */
		public function setAnimationClass(className:Class):void
		{
			avsEffect = new className(this);
		}
		
		public function getCustomAnimation():Array
		{
			return [_eff1, _eff2];
		}
		
		/**
		 * initialize viewStack
		 */
		public function set viewStack(arg:ViewStack):void
		{
			this._viewStack = arg;
		//	this.width = _viewStack.width;
		//	this.height = _viewStack.height;
			if(!this.contains(_viewStack)) {
				this.removeAllChildren();
				this.addChildAt(_backgroundRenderer, 0);
				this.addChild(_viewStack);
			}
		}
		
		public function get viewStack():ViewStack
		{
			return this._viewStack;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_backgroundRenderer.width = value;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_backgroundRenderer.height = value;
		}
		
		public function AdvancedViewStack()
		{
			super();
			this.verticalScrollPolicy = "off";
			this.horizontalScrollPolicy = "off";
			_backgroundRenderer = new Canvas();
			_backgroundRenderer.verticalScrollPolicy = "off";
			_backgroundRenderer.horizontalScrollPolicy = "off";
			addChildAt(_backgroundRenderer, 0);
			
			addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
		}
		
		protected function completeHandler(evt:FlexEvent):void
		{
			// default animation is FadeAVS
			this.setAnimationClass(FadeAVS);
		}
		
		/**
		 * change current page function, return true if page changed.
		 */
		public function goPage(index:int):Boolean
		{
			if(_isPlaying) return false;
			if(viewStack.numChildren <= index || index < 0 
					|| index == viewStack.selectedIndex) return false;
			beginInitialize(index);
			return true;
		}
		
		/**
		 * initialize animation function.
		 */ 
		private function beginInitialize(nextIndex:int):void
		{
			//initialize direction
			this.direction = viewStack.selectedIndex > nextIndex 
					? TURN_RIGHT : TURN_LEFT;
			
			// disppatch a effect start event
			this.dispatchEvent(new EffectEvent(EffectEvent.EFFECT_START));
			
			// initialize image collections
			curImages = new Array();
			nextImages = new Array();
			
			// convert current page to Image.
			curImages.push(ImageUtil.toImage(viewStack.selectedChild));
			
			// change viewStack selected index to next index.
			viewStack.selectedIndex = nextIndex;
			viewStack.visible = false;
			viewStack.validateNow();
			
			// convert next page to Image.
			nextImages.push(ImageUtil.toImage(viewStack.selectedChild));
			
			var numChildren:int = this.getChildren().length;
			
			// initial avsEffect
			avsEffect.advInitFunction(curImages, nextImages);
			avsEffect.initAnimation();
			
			// set duration
			var tempDuration:Number = _isQueue ? duration / 2 : duration;
			for(var i:int = 0; i < _eff1.length; i++) {
				IEffect(_eff1[i]).duration = tempDuration;
			}
			for(i = 0; i < _eff2.length; i++) {
				IEffect(_eff2[i]).duration = tempDuration;
			}
			
			IEffect(_eff1[0]).removeEventListener(
					EffectEvent.EFFECT_END, doAnimation2Handler);
			IEffect(_eff2[0]).removeEventListener(
					EffectEvent.EFFECT_END, endAnimation);
			
			if(_isQueue) {
				_eff1[0].addEventListener(
						EffectEvent.EFFECT_END, doAnimation2Handler);
			}
			_eff2[0].addEventListener(EffectEvent.EFFECT_END, endAnimation);
			
			// add images to the top of this class.
			for (i = 0; i < nextImages.length; i++) {
				this.addChildAt(nextImages[i], numChildren++);
			}
			for (i = 0; i < curImages.length; i++) {
				this.addChildAt(curImages[i], numChildren++);
			}
			
			// do animation
			doAnimation();
		}
		
		private function doAnimation():void
		{
			_isPlaying = true;
			
			if(_isQueue) {
				for(var i:int = 0; i < _eff1.length; i++) {
					IEffect(_eff1[i]).play([curImages[i]]);
				}
				for(i = 0; i < nextImages.length; i++) {
					nextImages[i].visible = false;
				}
			} else {
				for(i = 0; i < _eff1.length; i++) {
					IEffect(_eff1[i]).play([curImages[i]]);
				}
				for(i = 0; i < _eff2.length; i++) {
					IEffect(_eff2[i]).play([nextImages[i]]);
				}
			}
		}
		
		private function doAnimation2Handler(evt:Event):void
		{
			this.invalidateProperties();
			for(var i:int = 0; i < _eff1.length; i++) {
				IEffect(_eff2[i]).play([nextImages[i]]);
			}
			for(i = 0; i < nextImages.length; i++) {
				nextImages[i].visible = true;
			}
			for(i = 0; i < curImages.length; i++) {
				curImages[i].visible = false;
			}
		}
		
		private function endAnimation(evt:Event):void
		{
			removeAllRendererImage();
			viewStack.visible = true;
			_isPlaying = false;
			
			dispatchEvent(new EffectEvent(EffectEvent.EFFECT_END));
		}
		
		/**
		 * On event finished, clear all temp images.
		 */
		private function removeAllRendererImage():void
		{
			for each(var disObj:DisplayObject in this.getChildren()) {
				if(disObj is Image) {
					this.removeChild(disObj);
				}
			}
		}
		
	}
}