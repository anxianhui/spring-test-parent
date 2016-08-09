/*
 * Copyright (C) 2012 淘学网络. All rights reserved.
 */
package com.andy.shiro;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.Sha256Hash;
import org.apache.shiro.util.ByteSource;
import org.apache.shiro.util.SimpleByteSource;

/**
 * 密码工具类.
 *
 */
public class PasswordUtils {
	
	/**
	 * 密码加密.
	 *
	 * @param pwd the pwd
	 * @return the password
	 */
	public static Password encryptPwd(String pwd){
		RandomNumberGenerator rng = new SecureRandomNumberGenerator();
		ByteSource salt = rng.nextBytes();
		ByteSource pSalt = new SimpleByteSource(salt.toBase64());
		Sha256Hash hash = new Sha256Hash(pwd,pSalt);
	
		return new Password(hash.toBase64(),salt.toBase64());
	}
	
	/**
	 * The Class Password.
	 *
	 * @author derek
	 * @version 1.0, 2012-7-2
	 */
	public static class Password{
		
		/** The pwd. */
		private String pwd;
		
		/** The pwd salt. */
		private String pwdSalt;
		
		/**
		 * Instantiates a new password.
		 *
		 * @param pwd the pwd
		 * @param pwdSalt the pwd salt
		 */
		public Password(String pwd, String pwdSalt){
			this.pwd = pwd;
			this.pwdSalt = pwdSalt;
		}
		
		/**
		 * Gets the pwd.
		 *
		 * @return the pwd
		 */
		public String getPwd() {
			return pwd;
		}
		
		/**
		 * Sets the pwd.
		 *
		 * @param pwd the new pwd
		 */
		public void setPwd(String pwd) {
			this.pwd = pwd;
		}
		
		/**
		 * Gets the pwd salt.
		 *
		 * @return the pwd salt
		 */
		public String getPwdSalt() {
			return pwdSalt;
		}
		
		/**
		 * Sets the pwd salt.
		 *
		 * @param pwdSalt the new pwd salt
		 */
		public void setPwdSalt(String pwdSalt) {
			this.pwdSalt = pwdSalt;
		}
		
		/* (non-Javadoc)
		 * @see java.lang.Object#toString()
		 */
		public String toString(){
			return pwd +"  "+ pwdSalt;
		}
	}
}
