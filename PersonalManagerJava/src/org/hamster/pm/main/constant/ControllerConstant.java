package org.hamster.pm.main.constant;

public class ControllerConstant {
	private ControllerConstant() { }
	
	public static final int S_SUCCESS 				= 0;
	
	public static final int S_LOGIN_FAILED	= 1;
	
	public static final int S_TOKEN_INVALID = 1;
	
	public static final int S_REGISTER_EMAIL_INVALID		= 1;
	public static final int S_REGISTER_PASSWORD_INVALID		= 2;
	
	public static final int USER_INVALID				= 1;
	
	public static final String MSG_LOGIN_SUCCESS			= "LoginSuccess";
	public static final String MSG_LOGIN_FAILED 				= "LogiFailed";
	
	public static final String MSG_REGISTER_SUCCESS			= "RegisterSuccess";
	public static final String MSG_EMAIL_INVALID			= "EmailInvalid";
	public static final String MSG_PASSWORD_INVALID			= "PasswordInvalid";
	
	public static final String MSG_USER_INVALID				 = "UserInvalid";
	
	
	public static final String PASSWORD	 	 	= "password";
	public static final String EMAIL	 		= "email";
	
	public static final String COOKIE			= "cookie";
	public static final String COOKIE_UUID	 	= COOKIE + "UUID";
	
}
