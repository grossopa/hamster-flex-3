package org.hamster.magic.common.models.action.utils
{
	import org.hamster.magic.common.models.Player;
	
	public class ActionTarget
	{
		public static const PLAYER:int 					= 100;
		
		// same as CardLocation
		public static const GALLERY:int 				= 0;
		public static const HAND:int 					= 1;
		public static const LAND:int 					= 2;
		public static const LAND_ENHANCEMENT:int 		= 3;
		public static const ARTIFACT:int 				= 4;
		public static const ARTIFACT_ENHANCEMENT:int 	= 5;
		public static const CREATURE:int 				= 6;
		public static const CREATURE_ENHANCEMENT:int 	= 7;
		public static const MAGIC:int 					= 8;
		public static const MAGIC_ENHANCEMENT:int 		= 9;
		public static const GRAVEYARD:int 				= 10;
		public static const OUT:int						= 11;
	}
}