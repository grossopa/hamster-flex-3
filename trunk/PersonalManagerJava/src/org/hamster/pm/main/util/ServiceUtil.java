package org.hamster.pm.main.util;

import java.util.Map;

import org.hamster.pm.main.model.ResultVO;

public class ServiceUtil {
	private ServiceUtil() { }
	
	public static final ResultVO createResultVO() {
		return createResultVO(0, "", null);
	}
	
	public static final ResultVO createResultVO(int status) {
		return createResultVO(status, "", null);
	}
	
	public static final ResultVO createResultVO(int status, String messageCode) {
		return createResultVO(status, messageCode, null);
	}
	
	public static final ResultVO createResultVO(int status, String messageCode, Object result) {
		ResultVO resultVO = new ResultVO();
		resultVO.setStatus(status);
		resultVO.setMessageCode(messageCode);
		resultVO.setResult(result);
		return resultVO;
	}
	
	public static final ResultVO createResultVO(int status, String messageCode, Map<String, Object> results) {
		ResultVO resultVO = new ResultVO();
		resultVO.setStatus(status);
		resultVO.setMessageCode(messageCode);
		resultVO.setResults(results);
		return resultVO;
	}
}
