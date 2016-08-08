/*
 * PROJECT NAME: platform-server
 * PACKAGE NAME: com.baobao.platform.server.web
 * FILE    NAME: Response.java
 */ 
package web.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.MultiValueMap;


public class Response {

	private final static String ERROR_CODE = "errorCode";
	private final static String MSG_KEY = "message";
	private final static String SUCCESS_KEY = "success";

	/**
	 * @return ResponseEntity type value includes default Map data
	 *         {"success":true} and http code 200
	 */
	public static ResponseEntity<Object> success(Object object) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(SUCCESS_KEY, true);
		result.put(MSG_KEY, object);
		return getEntity(result, HttpStatus.OK);
	}
	
	public static ResponseEntity<Object> fail() {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(SUCCESS_KEY, false);
		return getEntity(result, HttpStatus.OK);
	}
	
	public static ResponseEntity<Object> fail(Object object) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(SUCCESS_KEY, false);
		result.put(MSG_KEY, object);
		return getEntity(result, HttpStatus.OK);
	}
	
	public static ResponseEntity<Object> success() {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(SUCCESS_KEY, true);
		return getEntity(result, HttpStatus.OK);
	}
	


	/**
	 * @param errorCode
	 *            customization error code
	 * @param msg
	 *            customization error description
	 * @return ResponseEntity type object includes a Map object of error and
	 *         HTTP code 404
	 */
	public static ResponseEntity<Object> notFound(String errorCode, String msg) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(MSG_KEY, msg);
		result.put(ERROR_CODE, errorCode);
		return getEntity(result, HttpStatus.NOT_FOUND);
	}

	/**
	 * @param errorCode
	 *            customization error code
	 * @param msg
	 *            customization error description
	 * @return ResponseEntity type object includes a Map object of error and
	 *         HTTP code 403
	 */
	public static ResponseEntity<Object> authorityFailed(String errorCode,
			String msg) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(MSG_KEY, msg);
		result.put(ERROR_CODE, errorCode);
		return getEntity(result, HttpStatus.FORBIDDEN);
	}

	/**
	 * @param errorCode
	 *            customization error code
	 * @param msg
	 *            customization error description
	 * @return ResponseEntity type object includes a Map object of error and
	 *         HTTP code 422
	 */
	public static ResponseEntity<Object> illegalArgument(String errorCode,
			String msg) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(MSG_KEY, msg);
		result.put(ERROR_CODE, errorCode);
		return getEntity(result, HttpStatus.UNPROCESSABLE_ENTITY);
	}


	/**
	 * @param errorCode
	 *            customization error code
	 * @param msg
	 *            customization error description
	 * @return ResponseEntity type object includes a Map object of error and
	 *         HTTP code 500
	 */
	public static ResponseEntity<Object> serverLocalErrorMsg(String msg) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(MSG_KEY, msg);
		return getEntity(result, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	/**
	 * @param errorCode
	 *            customization error code
	 * @param msg
	 *            customization error description
	 * @return ResponseEntity type object includes a Map object of error and
	 *         HTTP code 500
	 */
	public static ResponseEntity<Object> serverLocalError(String errorCode,
			String msg) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put(MSG_KEY, msg);
		result.put(ERROR_CODE, errorCode);
		return getEntity(result, HttpStatus.INTERNAL_SERVER_ERROR);
	}


	/**
	 * get a new entity.
	 */
	protected static ResponseEntity<Object> getEntity(Object body,
			HttpStatus statusCode) {
		MultiValueMap<String, String> headers = new HttpHeaders();
		List<String> contentType = new ArrayList<String>();
		contentType.add("application/json;charset=utf-8");
		headers.put("Content-Type", contentType);
		return new ResponseEntity<Object>(body, headers, statusCode);
	}

}
