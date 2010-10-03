package org.hamster.showcase.common.util
{
	public class TraceHelper
	{
		
 		public static function curLine():String
        {
            var e:Error = new Error();
            var ss:String = e.getStackTrace();
            var f:int = 0;
            var l:int = 0;
			f = ss.indexOf("at mx.logging::LogLogger");
           // for (var i:int = 0; i < parentLevelCount; i++) {
            	f = ss.indexOf("[", f + 1);
				f = ss.indexOf("[", f + 1);
            	l = ss.indexOf("]", f + 1);
           // }
            var p:String = ss.substring(f, l);
            //var srcStrIndex:int = p.indexOf("src\\com") + 4;
            p = p.substring(p.length - 40);
            e = null;
            return p;
        }


	}
}