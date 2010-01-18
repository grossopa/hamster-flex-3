// ActionScript file
import mx.collections.ArrayCollection;

import noorg.magic.services.DataService;
import noorg.magic.utils.Properties;Properties;

private const DS:DataService = DataService.getInstance();

private function localeChanged():void
{
	this.resourceManager.localeChain = [localeComboBox.selectedItem as String];
}

private function showDetailTipChange():void
{
	DS.isAutoShowCardDetail = this.showCardDetailTipCheckBox.selected;
}