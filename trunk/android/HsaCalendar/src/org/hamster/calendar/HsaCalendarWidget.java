/**
 * 
 */
package org.hamster.calendar;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hamster.calendar.service.BitmapCacheService;
import org.hamster.calendar.util.CalendarUtil;
import org.hamster.calendar.util.ResourceUtil;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Bitmap.Config;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Paint.Style;
import android.widget.RemoteViews;

/**
 * @author yinz
 *
 */
public class HsaCalendarWidget extends AppWidgetProvider {
	 
	private static BitmapCacheService BCS = BitmapCacheService.getInstance();
	
	private boolean initialized = false;
	private Paint paint;
	
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
			paint = new Paint();
			paint.setAlpha(127);
			paint.setStyle(Style.STROKE);
			paint.setColor(0xff0000);
			paint.setStrokeWidth(1);
	        updateCalendar(views, context);
			initialized = true;
		} 

        //views.setImageViewBitmap(R.id.View_mainDayList, painter);
        for (int i=0; i<N; i++) {
            int appWidgetId = appWidgetIds[i];
            appWidgetManager.updateAppWidget(appWidgetId, views);
        }
        
        super.onUpdate(context, appWidgetManager, appWidgetIds);
    }
	
	@Override
	public void onReceive(Context context, Intent intent) {
		super.onReceive(context, intent);
		if (intent.getAction().equals("org.hamster.calendar.click")) {
			System.out.println(intent.getStringExtra("hs_aaaa"));
			RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget4_4);
		}
	}
	
	private void updateCalendar(RemoteViews views, Context context) {
		Intent actClick = new Intent(context, HsaCalendarWidget.class);
		actClick.setAction("org.hamster.calendar.click");
		actClick.putExtra("hs_aaaa", "ha_asbc");
		PendingIntent pending = PendingIntent.getBroadcast(context, 0, actClick, 0);
		views.setOnClickPendingIntent(R.id.View_day11, pending);
		updateDateNumbers(views, context);
		updateMonth(views, context);
	}
	
	private void updateMonth(RemoteViews views, Context context) {
		int monthId = Calendar.getInstance().get(Calendar.MONTH);
		int resId = ResourceUtil.MONTH_IMG_LIST[monthId];
		views.setImageViewBitmap(R.id.View_monthImage, BCS.getBitmap(resId));
	}
	
	/**
	 * week 1 = Sunday
	 */
	private void updateDateNumbers(RemoteViews views, Context context) {
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
		
		Date startDate = new Date(calendar.getTime().getYear(), calendar.get(Calendar.MONTH), 1);
		Date endDate = new Date(calendar.getTime().getYear(), calendar.get(Calendar.MONTH), dayCount);
		List<Date> eventDateList = CalendarUtil.readCalendar(context, startDate, endDate);
		
		for (int i = 1; i < dayCount + 1; i++) {
			int indexX = (startWeek + i - 1) % 7; // 0-6
			int indexY = (startWeek + i - 1) / 7; // 0-5
			boolean hasEvent = false;
			for (Date d : eventDateList) {
				if (i == d.getDate()) {
					hasEvent = true;
				}
			}
			if (i < 10) {
				drawSingleNumber(indexX, indexY, i, views, hasEvent, curDay);
			} else {
				drawDoubleNumber(indexX, indexY, i, views, hasEvent, curDay);
			}
			
			week = week == 7 ? 1 : week + 1;
		}
	}
	
	
	private void drawSingleNumber(int indexX, int indexY, int i, RemoteViews views, boolean hasEvent, int curDay) {
		Bitmap newBp = Bitmap.createBitmap(48, 60, Config.ARGB_8888);
		Canvas canvas = new Canvas(newBp);
		Bitmap b = BCS.getBitmap(ResourceUtil.NUMBER_IMG_LIST[i]);
		canvas.drawBitmap(b, (48 - b.getWidth()) / 2, (50 - b.getHeight()) / 2, null);
		
		if (curDay == i) {
			if (hasEvent) {
				canvas.drawBitmap(BCS.getBitmap(R.drawable.today_event), 0,0, null);
			} else {
				canvas.drawBitmap(BCS.getBitmap(R.drawable.today), 0,0, null);
			}
		} else if (curDay < i && hasEvent) {
			canvas.drawBitmap(BCS.getBitmap(R.drawable.selected), 0,0, null);
		} else if (curDay > i && hasEvent) {
			canvas.drawBitmap(BCS.getBitmap(R.drawable.selected_old), 0,0, null);
		}
		

		Bitmap.createBitmap(newBp);
		
		int id = ResourceUtil.DATE_VIEW_ID_LIST[indexY][indexX];
		views.setBitmap(id, "setImageBitmap", newBp);
	}
	
	private void drawDoubleNumber(int indexX, int indexY, int i, RemoteViews views, boolean hasEvent, int curDay) {
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
		canvas.drawBitmap(b1, (48 - b1.getWidth() - b2.getWidth()) / 2 - gap, (50 - b1.getHeight()) / 2, null);
		canvas.drawBitmap(b2, (48 + b1.getWidth() - b2.getWidth()) / 2 + gap, (50 - b2.getHeight()) / 2, null);
		
		if (curDay == i) {
			if (hasEvent) {
				canvas.drawBitmap(BCS.getBitmap(R.drawable.today_event), 0,0, null);
			} else {
				canvas.drawBitmap(BCS.getBitmap(R.drawable.today), 0,0, null);
			}
		} else if (curDay < i && hasEvent) {
			canvas.drawBitmap(BCS.getBitmap(R.drawable.selected), 0,0, null);
		} else if (curDay > i && hasEvent) {
			canvas.drawBitmap(BCS.getBitmap(R.drawable.selected_old), 0,0, null);
		}

		canvas.drawRect(0, 0, 48, 60, paint);
		Bitmap.createBitmap(newBp);
		int id = ResourceUtil.DATE_VIEW_ID_LIST[indexY][indexX];
		views.setBitmap(id, "setImageBitmap", newBp);		
	}

}
