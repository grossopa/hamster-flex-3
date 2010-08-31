/**
 * 
 */
package org.hamster.calendar.service;

import java.util.HashMap;
import java.util.Map;

import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;

/**
 * @author Administrator
 *
 */
public class BitmapCacheService {
	
	private static BitmapCacheService instance;
	
	public static final BitmapCacheService getInstance() {
		if (instance == null) {
			instance = new BitmapCacheService();
		}
		return instance;
	}
	
	private Map<Integer, Bitmap> storage;
	private Resources resources;
	
	public void setResources(Resources resources) {
		this.resources = resources;
	}
	
	public BitmapCacheService() {
		storage = new HashMap<Integer, Bitmap>();
	}
	
	public Bitmap getBitmap(int id) {
		if (!storage.containsKey(id)) {
			Bitmap newBitmap = BitmapFactory.decodeResource(resources, id);
			Bitmap alter = Bitmap.createBitmap(newBitmap);
			storage.put(id, alter);
			System.out.println("WARN: load " + id + "from resource");
			return alter;
		} else {
			return storage.get(id);
		}
	}
}
