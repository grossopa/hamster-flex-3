/**
 * 
 */
package org.hamster.calendar;

import java.util.Calendar;

import org.hamster.calendar.service.BitmapCacheService;
import org.hamster.calendar.util.ResourceUtil;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.Bitmap.Config;
import android.graphics.Paint.Style;
import android.graphics.Canvas;
import android.util.Log;
import android.widget.ImageView;
import android.widget.RemoteViews;

/**
 * @author yinz
 *
 */
public class HsaCalendarWidget extends AppWidgetProvider {
	 
	private static BitmapCacheService BCS = BitmapCacheService.getInstance();
	
	private boolean initialized = false;
	
	
	public HsaCalendarWidget () {
		super();   
	}
	
	
	/* (non-Javadoc)
	 * @see android.appwidget.AppWidgetProvider#onUpdate(android.content.Context, android.appwidget.AppWidgetManager, int[])
	 */
	public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        final int N = appWidgetIds.length;
        BCS.setResources(context.getResources());
        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget4_4);
       // context.
		if (!initialized) {
			// updateDayViews(views);
			// buttons = createImageButtons(context, widthGap, heightGap);
	        updateCalendar(210, 270, views);
	        updateBackground(210, 270, views);
	        //view.setBackgroundColor(color)
	       // view.setAlpha(alpha)
	        // views.setImageViewBitmap(R.id.View_background, BCS.getBitmap(R.drawable.c_background));
			initialized = true;
		} 
		


        //views.setImageViewBitmap(R.id.View_mainDayList, painter);
        for (int i=0; i<N; i++) {
            int appWidgetId = appWidgetIds[i];
            appWidgetManager.updateAppWidget(appWidgetId, views);
        }
        
        super.onUpdate(context, appWidgetManager, appWidgetIds);
    }
	
	private void updateBackground(int width, int height, RemoteViews views) {
		Bitmap bitmap = Bitmap.createBitmap(width, height, Config.RGB_565);
		Canvas canvas = new Canvas(bitmap);
		Paint paint = new Paint();
		// paint.setAlpha(50);
		canvas.drawRect(new Rect(0, 0, width, height), paint);
		Bitmap.createBitmap(bitmap);
		views.setImageViewBitmap(R.id.View_background, bitmap);
	}

	private void updateCalendar(int width, int height, RemoteViews views) {
		updateDateNumbers(width, height, views);
	}
	
	/**
	 * week 1 = Sunday
	 */
	private void updateDateNumbers(int width, int height, RemoteViews views) {
		Calendar calendar = Calendar.getInstance();
		final int curDay = calendar.get(Calendar.DATE);
		final int curWeek = calendar.get(Calendar.DAY_OF_WEEK);
		//final int curWeek = 6;
		final int dayCount = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		int startWeek = curWeek - (curDay % 7);
		if (startWeek < 0) {
			startWeek += 7;
		}
		
		
		int week = startWeek;
		
		for (int i = 1; i < dayCount + 1; i++) {
			int indexX = (startWeek + i - 1) % 7; // 0-6
			int indexY = (startWeek + i - 1) / 7; // 0-5
			if (i < 10) {
				drawSingleNumber(indexX, indexY, i, views);
			} else {
				drawDoubleNumber(indexX, indexY, i, views);
			}
			
			week = week == 7 ? 1 : week + 1;
		}
	}
	
	
	private void drawSingleNumber(int indexX, int indexY, int i, RemoteViews views) {
		Bitmap newBp = Bitmap.createBitmap(48, 60, Config.ARGB_8888);
		Canvas canvas = new Canvas(newBp);
		Bitmap b = BCS.getBitmap(ResourceUtil.NUMBER_IMG_LIST[i]);
		//canvas.drawRect(0, 0, 48, 60, paint);
		canvas.drawBitmap(b, (48 - b.getWidth()) / 2, (60 - b.getHeight()) / 2, null);
		Bitmap.createBitmap(newBp);
		
		int id = ResourceUtil.DATE_VIEW_ID_LIST[indexY][indexX];
		views.setBitmap(id, "setImageBitmap", newBp);
	}
	
	private void drawDoubleNumber(int indexX, int indexY, int i, RemoteViews views) {
		Bitmap newBp = Bitmap.createBitmap(48, 60, Config.ARGB_8888);
		Canvas canvas = new Canvas(newBp);
		  
		// draw ten digit number
		int tenDigit = (int) (i / 10);
		Bitmap b1  = BCS.getBitmap(ResourceUtil.NUMBER_IMG_LIST[tenDigit]);
		
		// draw single digit number
		int singleDigit = i % 10;
		Bitmap b2 = BCS.getBitmap(ResourceUtil.NUMBER_IMG_LIST[singleDigit]);
		
		//TODO: left align and right align may cause issues
		int gap = 0;
		canvas.drawBitmap(b1, (48 - b1.getWidth() - b2.getWidth()) / 2 - gap, (60 - b1.getHeight()) / 2, null);
		canvas.drawBitmap(b2, (48 + b1.getWidth() - b2.getWidth()) / 2 + gap, (60 - b2.getHeight()) / 2, null);
		

		// canvas.drawRect(0, 0, 48, 60, paint);
		Bitmap.createBitmap(newBp);
		int id = ResourceUtil.DATE_VIEW_ID_LIST[indexY][indexX];
		views.setBitmap(id, "setImageBitmap", newBp);		
	}

}
