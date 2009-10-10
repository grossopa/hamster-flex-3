package noorg.errors
{
	public class ServiceError extends Error
	{
		public static const SINGLETON_ERROR_MSG:String = "The class should only have one singleton.";
		
		public function ServiceError(message:String="", id:int=0)
		{
			super(message, id);
		}
		
	}
}