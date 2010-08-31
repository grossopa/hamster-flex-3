package org.hamster.calendar.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import android.content.Context;

public class ConfigUtil {
	public static final String FILE_NAME = "config.xml";
	private static Properties properties;
	
	private ConfigUtil() { }
	
	private static Properties getProperties(Context context) {
		if (properties == null) {
			properties = new Properties();
			InputStream fis;
			try {
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
	
	public static String get(Context context, String key) {
		return getProperties(context).getProperty(key);
	}
	
	public static void put(Context context, String key, String value) {
		Properties p = getProperties(context);
		p.setProperty(key, value);
		try {
			p.storeToXML(
					context.openFileOutput(FILE_NAME, Context.MODE_PRIVATE), 
					"");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public static void init(Context context) {
		properties = new Properties();
		try {
			
			File file = new File(context.getFilesDir(), FILE_NAME);
			if (!file.exists()) {
				file.createNewFile();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
