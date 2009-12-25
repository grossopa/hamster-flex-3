package noorg.magic.commands.impl
{
	import com.adobe.utils.StringUtil;
	
	import noorg.magic.models.Card;
	
	import org.hamster.commands.AbstractCommand;
	import org.hamster.services.HTTPServiceLocator;

	public class GetCardFromWebCmd extends AbstractCommand
	{
		public var pid:int;
		public var card:Card;
		
		public function GetCardFromWebCmd()
		{
			super();
		}
		
		override public function execute():void
		{
			var param:Object = new Object();
			param["pid"] = this.pid;
			HTTPServiceLocator.getInstance().sendService("getCardFromWeb", this, param);
		}
		
		override public function result(data:Object):void
		{
			var str:String = data.result as String;
			card = new Card();
			card.pid = pid;
			
			// find name
			var namePrefix:String = "Customers who bought ";
			var nameStartIndex:int = str.indexOf(namePrefix) + namePrefix.length;
			var nameSuffix:String = " also purchased";
			var nameEndIndex:int = str.indexOf(nameSuffix);
			card.name = str.substring(nameStartIndex + 3, nameEndIndex - 4);
			
			// find oracle text
			var textPrefix:String = "Oracle Text:";
			var textStartIndex:int = str.indexOf(textPrefix);
			var textSuffix:String = "</td>";
			var textEndIndex:int = str.indexOf(textSuffix, textStartIndex);
			card.oracleText = str.substring(textStartIndex + textPrefix.length, textEndIndex);
			card.oracleText = card.oracleText.replace("<br>","");
			card.oracleText = StringUtil.trim(card.oracleText);
			
			// find image
			var imagePrefix:String = "<img src='";
			var imageStartIndex:int = str.indexOf(imagePrefix, textStartIndex - 200);
			var imageSuffix:String = "' border=0>";
			var imageEndIndex:int = str.indexOf(imageSuffix, imageStartIndex);
			card.imgUrl = str.substring(imageStartIndex + imagePrefix.length, imageEndIndex);
						
			super.result(data);
		}
		
		override public function fault(info:Object):void
		{
			super.fault(info);
		}
		
	}
}