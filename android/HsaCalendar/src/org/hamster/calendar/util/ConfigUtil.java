package org.hamster.calendar.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Calendar;
import java.util.Properties;

import android.content.Context;

public class ConfigUtil {
	public static final String FILE_NAME = "config.xml";
	public static final String CUR_DATE = "curDateSelection";

	private static Properties properties;
	private static Calendar curDateSelection;

	private ConfigUtil() {
	}

	private static Properties getProperties(Context context) {
		if (properties == null) {
			properties = new Properties();
			InputStream fis;
			try {
				init(context);
				fis = context.openFileInput(FILE_NAME);
				properties.loadFromXML(fis);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return properties;
	}

	public static Calendar getCurDateSelection(Context context) {
		if (curDateSelection == null) {
			System.out.println("    HAMSTER WARN : cur date selection is null!");
			curDateSelection = Calendar.getInstance();
			String pDate = get(context, CUR_DATE);
	
			if (pDate == null) {
				putCurDateSelection(context, curDateSelection);
			} else {
				String[] info = pDate.split(":");
				curDateSelection.set(Calendar.YEAR, Integer.valueOf(info[0]));
				curDateSelection.set(Calendar.MONTH, Integer.valueOf(info[1]));
				curDateSelection.set(Calendar.DAY_OF_MONTH, Integer.valueOf(info[2]));
			}
		}
		return curDateSelection;
	}

	public static void putCurDateSelection(Context context, Calendar calendar) {
		curDateSelection = calendar;
		put(context, CUR_DATE, calendar.get(Calendar.YEAR) + ":"
				+ calendar.get(Calendar.MONTH) + ":"
				+ calendar.get(Calendar.DAY_OF_MONTH));
	}

	public static String get(Context context, String key) {
		return getProperties(context).getProperty(key);
	}

	public static void put(Context context, String key, String value) {
		Properties p = getProperties(context);
		p.setProperty(key, value);
		try {
			p.storeToXML(context
					.openFileOutput(FILE_NAME, Context.MODE_PRIVATE), "");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	private static boolean init(Context context) {
		properties = new Properties();
		try {
			File file = new File(context.getFilesDir(), FILE_NAME);
			if (!file.exists()) {
				file.createNewFile();
				putCurDateSelection(context, Calendar.getInstance());
				return true;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

}
