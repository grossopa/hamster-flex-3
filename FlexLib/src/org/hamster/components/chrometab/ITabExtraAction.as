/**
 * @author org.hamster
 * 
 * Description: this interface supports the ChromeTab Class,
 * if use a static viewStack then this interface needn't to be implemented,
 * but if use a non-static viewStack or user need to define a chain of 
 * custom actions then this interface must be implemented and set to ChromeTab.
 */

package org.hamster.components.chrometab
{
	import flash.display.DisplayObject;
	
	public interface ITabExtraAction
	{
		/**
		 * on user click add Tab or the function addTab is called,
		 * to do some extra action to decide whether a new tab should
		 * be created.
		 * 
		 * @param index the index of the new tab.
		 * @return whether the tab should be created.
		 */
		function beforeAddTab(index:int):Boolean;
		
		/**
		 * if the viewStack isn't null, then this interface function 
		 * will be called to create a new viewStack child, if the return
		 * value is not null, the DisplayObject will be added to the viewStack.
		 * 
		 * @return DisplayObject.
		 */
		function createViewStackChild():DisplayObject
		
		/**
		 * decide whether user can selected the tab.
		 * 
		 * @param index the index of the selected tab.
		 * @return whether the tab can be selected.
		 */
		function beforeSelectTab(index:int):Boolean;
		
		/**
		 * decide whether user can close the tab.
		 * 
		 * @param index the index of the tab.
		 * @return whether the tab can be closed.
		 */		
		function beforeCloseTab(index:int):Boolean;
	}
}