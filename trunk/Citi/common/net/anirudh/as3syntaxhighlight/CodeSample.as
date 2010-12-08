// Author: Anirudh Sasikumar (http://anirudhs.chaosnet.org/)
// Copryright (C) 2009 Anirudh Sasikumar

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
package net.anirudh.as3syntaxhighlight
{
	public class CodeSample
	{
		[Bindable]
		public static var codeString:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<mx:Application xmlns:mx=\"http://www.adobe.com/2006/mxml\" layout=\"absolute\">\n<mx:Script>\nprivate var a:String = \"Dude\";\n\n//this is a comment\n\nprivate function dude():void\n{\n    Alert.show(\"Dude\");\n}\n</mx:Script>\n</mx:Application>";
		
		public function CodeSample()
		{
		}

	}
}