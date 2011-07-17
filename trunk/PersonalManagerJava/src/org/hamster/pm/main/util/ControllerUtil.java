package org.hamster.pm.main.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.hamster.pm.main.pojo.AbstractPojo;
import org.hamster.pm.main.pojo.annotation.PojoToResponse;
import org.springframework.ui.ModelMap;

public class ControllerUtil {
	
	public static final String DEFAULT_ENCODING = "utf8";
	
	private ControllerUtil() { }
	
	public static void writeResponse(HttpServletResponse response, String resultStr) throws IOException {
		IOUtils.write(resultStr, response.getOutputStream(), DEFAULT_ENCODING);
	}
	
	public static void writeResponse(HttpServletResponse response, File f) throws IOException {
		response.setContentType("text/html; charset=UTF-8");
		response.addHeader("Content-length", String.valueOf(f.length()));
		response.addHeader("Content-Disposition",
				"inline; filename=" + f.getName().replace(" ", ""));
		InputStream is = new FileInputStream(f);
		IOUtils.copy(is, response.getOutputStream());
	}
	
	public static ModelMap writeFailureMessage(ModelMap modelMap, int status, String messageKey) {
		modelMap.put("status", status);
		modelMap.put("messageKey", messageKey);
		modelMap.put("message", messageKey);
		return modelMap;
	}
	
	public static List<Map<String, Object>> mappingList(Map<String, Object> modelMap, Method method, List<?> targetList) {
		List<Map<String, Object>> result =  new LinkedList<Map<String, Object>>();
		for (Object o : targetList) {
			result.add(mappingObject(new HashMap<String, Object>(), o));
		}
		return result;
	}
	
	public static Map<String, Object> mappingObject(Map<String, Object> modelMap, Object targetObject) {
		Class<?> clazz = targetObject.getClass();
		Method mm[] = clazz.getDeclaredMethods();
		for (int i = 0; i < mm.length; i++) {
			Method method = mm[i];
			
			if (method.isAnnotationPresent(PojoToResponse.class)) {
				PojoToResponse anno = method.getAnnotation(PojoToResponse.class);
				String name = method.getName();
				if (anno.included() && name.startsWith("get")) {
					try {
						Object value = method.invoke(targetObject);
						if (!CommonUtil.isEmpty(value) || anno.required()) {
							String key = CommonUtil.isEmpty(anno.parameterName()) 
									? CommonUtil.firstCharToLowerCase(name.replaceFirst("get", "")) 
									: anno.parameterName();
							if (value instanceof List) {
								modelMap.put(key, mappingList(new HashMap<String, Object>(0), method, (List<?>) value));
							} else {
								modelMap.put(key, value);
							}
						}
					} catch (IllegalArgumentException e) {
						e.printStackTrace();
					} catch (IllegalAccessException e) {
						e.printStackTrace();
					} catch (InvocationTargetException e) {
						e.printStackTrace();
					}
				}
			}
		}
		return modelMap;
	}
	
	public static void mappingResponse(ModelMap modelMap, Object ...paramsAndObjs) {
		int length = paramsAndObjs.length;
		
		for (int i = 0; i < length; i += 2) {
			String key 		= (String) paramsAndObjs[i];
			Object value 	= paramsAndObjs[i + 1];
			if (value instanceof AbstractPojo) {
				modelMap.put(key, ControllerUtil.mappingObject(new HashMap<String, Object>(), value));
			} else {
				modelMap.put(key, value);
			}
		}
	}
}
