/**
 * 
 */
package org.hamster.calendar;

import java.util.Calendar;

import org.hamster.calendar.service.BitmapCacheService;

import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.widget.RemoteViews;

/**
 * @author yinz
 *
 */
public class HsaCalendarWidget extends AppWidgetProvider {
	 
	private static BitmapCacheService BCS = BitmapCacheService.getInstance();
	
	private boolean initialized = false;
	private RemoteViews views;
	
	public HsaCalendarWidget () {
		super();   
	}
	
	
	/* (non-Javadoc)
	 * @see android.appwidget.AppWidgetProvider#onUpdate(android.content.Context, android.appwidget.AppWidgetManager, int[])
	 */
	public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {
        final int N = appWidgetIds.length;
        BCS.setResources(context.getResources());
        views = new RemoteViews(context.getPackageName(), R.layout.widget4_4);
              
		if (!initialized) {
			// updateDayViews(views);
			// buttons = createImageButtons(context, widthGap, heightGap);
			initialized = true;
		} 
		views.setImageViewBitmap(R.id.View_background, BCS.getBitmap(R.drawable.c_background));
        updateCalendar(210, 270);

        //views.setImageViewBitmap(R.id.View_mainDayList, painter);
        for (int i=0; i<N; i++) {
            int appWidgetId = appWidgetIds[i];
            appWidgetManager.updateAppWidget(appWidgetId, views);
        }
    }
	
	private void updateDayViews(RemoteViews views) {
		Bitmap newBp = Bitmap.createBitmap(40, 35, Config.ARGB_8888);
        Canvas canvas = new Canvas(newBp);
       // canvas.drawBitmap(drawable, 0, 0, null);
        Bitmap b1 = BCS.getBitmap(R.drawable.n2);
        Bitmap b2 = BCS.getBitmap(R.drawable.n1);
        canvas.drawBitmap(b1, 0, 0, null);
        canvas.drawBitmap(b2, b1.getWidth(), 0, null);
        Bitmap.createBitmap(newBp);
		views.setBitmap(R.id.View_day11, "setImageBitmap", newBp);
	}
	
	private void drawSingleNumber(int indexX, int indexY, int i, RemoteViews views) {
		Bitmap newBp = Bitmap.createBitmap(30, 35, Config.ARGB_8888);
		Canvas canvas = new Canvas(newBp);
		Bitmap b = BCS.getBitmap(R.drawable.n0 + i);
		canvas.drawBitmap(b, (30 - b.getWidth()) / 2, (35 - b.getHeight()) / 2, null);
		Bitmap.createBitmap(newBp);
		int id = R.id.View_day11 + i - 1;
		views.setBitmap(id, "setImageBitmap", newBp);
	}
	
	private void drawDoubleNumber(int indexX, int indexY, int i, RemoteViews views) {
		Bitmap newBp = Bitmap.createBitmap(30, 35, Config.ARGB_8888);
		Canvas canvas = new Canvas(newBp);
		
		// draw ten digit number
		int tenDigit = (int) (i / 10);
		Bitmap b1  = BCS.getBitmap(R.drawable.n0 + tenDigit);
		
		// draw single digit number
		int singleDigit = i % 10;
		Bitmap b2 = BCS.getBitmap(R.drawable.n0 + singleDigit);
		
		//TODO: left align and right align may cause issues
		canvas.drawBitmap(b1, 0, (35 - b1.getHeight()) / 2, null);
		canvas.drawBitmap(b2, 30 - b2.getWidth(), (35 - b2.getHeight()) / 2, null);
		
		Bitmap.createBitmap(newBp);
		int id = R.id.View_day11 + i - 1;
		views.setBitmap(id, "setImageBitmap", newBp);		
	}
	 
	
	
	private Bitmap updateCalendar(int width, int height) {
		return updateDateNumbers(width, height);
	}
	
	/**
	 * week 1 = Sunday
	 */
	private Bitmap updateDateNumbers(int width, int height) {
		Calendar calendar = Calendar.getInstance();
		final int curDay = calendar.get(Calendar.DATE);
		final int curWeek = calendar.get(Calendar.DAY_OF_WEEK);
		final int dayCount = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		final int startWeek = (curDay % curWeek) + 1;
		
		int week = startWeek;
		
		for (int i = 1; i < 20 + 1; i++) {
			int indexX = ((week - 1) % 7);
			int indexY = (int)((week - 1) / 7);
			if (i < 10) {
				drawSingleNumber(indexX, indexY, i, views);
			} else {
				drawDoubleNumber(indexX, indexY, i, views);
			}
			
			week = week == 7 ? 1 : week + 1;
		}
		return null;
	}

}
