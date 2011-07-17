/**
 * 
 */
package org.hamster.pm.test.base;

import java.util.ArrayList;
import java.util.List;

/**
 * @author yinz
 *
 */
public class BaseTest {
	public static final String LINE_SEPARATOR = System.getProperty("line.separator");
	
	/**
	 * generate a non-duplicated number sequence
	 * format {num1}{split}{num2}{split}{num3}.....
	 * 
	 * @param valueFrom
	 * @param valueTo
	 * @param count
	 * @param split
	 * @return
	 */
	public static final String generateRandomNumbersString(long valueFrom, long valueTo, int count, String split) {

		long[] randomNums = generateRandomNumbers(valueFrom, valueTo, count);
		
		StringBuffer result = new StringBuffer(String.valueOf(randomNums[0]));
		for (int i = 1; i < count; i++) {
			result.append(split).append(randomNums[i]);
		}
		
		return result.toString();
	}
	
	/**
	 * generate an random number array
	 * 
	 * @param valueFrom
	 * @param valueTo
	 * @param count
	 * @return
	 */
	public static final long[] generateRandomNumbers(long valueFrom, long valueTo, int count) {
		List<Long> list = new ArrayList<Long>(0);
		for (int i = 0; i < valueTo - valueFrom; i++) {
			list.add(i + valueFrom);
		}
		
		long[] randomNums = new long[count];
		for (int i = 0; i < count; i++) {
			randomNums[i] = list.remove((int) (Math.random() * list.size()));
		}
		
		return randomNums;
	}
}
