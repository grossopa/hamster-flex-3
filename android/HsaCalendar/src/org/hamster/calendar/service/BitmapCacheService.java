/**
 * 
 */
package org.hamster.calendar.service;

import java.util.HashMap;
import java.util.Map;

import android.content.Context;
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
	
	public BitmapCacheService() {
		storage = new HashMap<Integer, Bitmap>();
	}
	
	public Bitmap getBitmap(Context context, int id) {
		if (!storage.containsKey(id)) {
			Bitmap newBitmap = BitmapFactory.decodeResource(context.getResources(), id);
			Bitmap alter = Bitmap.createBitmap(newBitmap);
			storage.put(id, alter);
			return alter;
		} else {
			return storage.get(id);
		}
	}
}
