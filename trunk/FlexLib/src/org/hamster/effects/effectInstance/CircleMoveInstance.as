package org.hamster.effects.effectInstance
{
	import org.hamster.errors.TodoError;
	
	public class CircleMoveInstance extends AbstractCurveMoveInstance
	{
		public function CircleMoveInstance(target:Object)
		{
			super(target);
			throw new TodoError();
		}
		
		override public function onTweenUpdate(value:Object):void
		{  
			super.onTweenUpdate(value);
			var val:Number = Number(value);
			
			
			
		} 
		
	}
}