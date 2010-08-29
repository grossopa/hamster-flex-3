package org.hamster.calendar.util;

public class CommonUtil {
	public static double mathMax(double ...ds) {
		double max = Double.MIN_VALUE;
		for (double d : ds) {
			if (max < d) max = d;
		}
		return max;
	}
}
