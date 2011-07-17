package org.hamster.pm.main.constant;

public class ControllerConstant {
	private ControllerConstant() { }
	
	public static final int SUCCESS 				= 0;
	
	public static final int LOGIN_EMAILPASSWORDWRONG 	= 1;
	
	public static final int REGISTER_EMAIL_INVALID		= 1;
	public static final int REGISTER_PASSWORD_INVALID	= 2;
	
	public static final int USER_INVALID				= 1;
	
	public static final String MSG_LOGIN_SUCCESS			= "LoginSuccess";
	public static final String MSG_LOGIN_EMAILPASSWORDWRONG = "LoginEmailPasswordWrong";
	
	public static final String MSG_REGISTER_SUCCESS			= "RegisterSuccess";
	public static final String MSG_EMAIL_INVALID			= "EmailInvalid";
	public static final String MSG_PASSWORD_INVALID			= "PasswordInvalid";
	
	public static final String MSG_USER_INVALID				 = "UserInvalid";
	
	
	public static final String PASSWORD	 	 	= "password";
	public static final String EMAIL	 		= "email";
	
	public static final String COOKIE			= "cookie";
	public static final String COOKIE_UUID	 	= COOKIE + "UUID";
	
}
