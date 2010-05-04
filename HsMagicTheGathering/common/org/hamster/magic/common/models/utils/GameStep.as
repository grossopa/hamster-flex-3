package org.hamster.magic.common.models.utils
{
	/**
	 * Beginning Phase
	 * Untap Step
	 * Upkeep Step
	 * Draw Step
	 * Main Phase
	 * Combat Phase
	 * Beginning of Combat Step
	 * Declare Attackers Step
	 * Declare Blockers Step
	 * Combat Damage Step
	 * End of Combat Step
	 * Ending Phase
	 * End Step
	 * Cleanup Step
	 */
	public class GameStep
	{
		public static const P_1_BEGINNING:int 				= 10;
		public static const S_11_UNTAP:int 					= 11;
		public static const S_12_UPKEEP:int 				= 12;
		public static const S_13_DRAW:int 					= 13;
		public static const P_2_MAIN:int 					= 20;
		public static const P_3_COMBAT:int 					= 30;
		public static const S_31_BEGINNING_OF_COMBAT:int 	= 31;
		public static const S_32_DECLARE_ATTACKERS:int 		= 32;
		public static const S_33_DECLARE_BLOCKERS:int 		= 33;
		public static const S_34_COMBAT_DAMAGE:int 			= 34;
		public static const S_35_END_OF_COMBAT:int 			= 35;
		public static const P_4_ENDING:int 					= 40;
		public static const S_41_END:int 					= 41;
		public static const S_42_CLEANUP:int 				= 42;
		

	}
}