/**
 * 
 */
package org.hamster.calendar;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.hamster.calendar.service.BitmapCacheService;
import org.hamster.calendar.util.CalendarUtil;
import org.hamster.calendar.util.CommonUtil;
import org.hamster.calendar.util.ResourceUtil;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
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
	private static final Calendar ca = Calendar.getInstance();
	
	private boolean initialized = false;
	private boolean hasCalendar = true;
//	private Paint paint;
	
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
//			paint = new Paint();
//			paint.setAlpha(127);
//			paint.setStyle(Style.STROKE);
//			paint.setColor(0xff0000);
//			paint.setStrokeWidth(1);
			initCalendar(views, context, appWidgetIds[0]);
	        updateCalendar(views, context, Calendar.getInstance());
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
		
		BCS.setResources(context.getResources());
		
		if (intent.getAction().equals("org.hamster.calendar.switch.click.right")) {
			
			RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget4_4);
			//Calendar calendar = (Calendar) intent.getSerializableExtra("calendar");
			Calendar calendar = ca;
				calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) + 1);
				System.out.println("INFO right : calendar  " + calendar.toString() + "   " + calendar.getTime().toString());
				this.updateCalendar(views, context, calendar);
				
			intent.putExtra("calendar", calendar);
			AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(context);
			appWidgetManager.updateAppWidget(new ComponentName(context, HsaCalendarWidget.class), views);
			
			System.out.println("TRACE   end of updating");
			
		} else if (intent.getAction().equals("org.hamster.calendar.switch.click.left")) {
			RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget4_4);
			//Calendar calendar = (Calendar) intent.getSerializableExtra("calendar");
			Calendar calendar = ca;
			calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) - 1);
			System.out.println("INFO left  : calendar  " + calendar.toString() + "   " + calendar.getTime().toString());
			this.updateCalendar(views, context, calendar);
			
			AppWidgetManager appWidgetManager = AppWidgetManager.getInstance(context);
			appWidgetManager.updateAppWidget(new ComponentName(context, HsaCalendarWidget.class), views);
			
			System.out.println("TRACE   end of updating");
		}
		
		
	}
	
	private void initCalendar(RemoteViews views, Context context, int appWidgetId) {
		Intent actClick = new Intent(context, HsaCalendarWidget.class);
		actClick.setAction("org.hamster.calendar.switch.click.right");
		actClick.putExtra("calendar", ca);
		PendingIntent pending = PendingIntent.getBroadcast(context, 0, actClick, 0);
		views.setOnClickPendingIntent(R.id.View_RightButton, pending);
		
		
		Intent actClickl = new Intent(context, HsaCalendarWidget.class);
		actClickl.setAction("org.hamster.calendar.switch.click.left");
		actClickl.putExtra("calendar", ca);
		PendingIntent pendingl = PendingIntent.getBroadcast(context, 0, actClickl, 0);
		views.setOnClickPendingIntent(R.id.View_LeftButton, pendingl);
	}
	
	private void updateCalendar(RemoteViews views, Context context, Calendar calendar) {
		cleanDateNumbers(views, context);
		updateDateNumbers(views, context, calendar);
		updateMonth(views, context, calendar);
		updateYear(views, context, calendar);
	}
	
	private void updateYear(RemoteViews views, Context context, Calendar calendar) {
		int year = calendar.get(Calendar.YEAR);
		int n1 = (int) (year * 0.001);
		int n2 = (int) (year * 0.01) % 10;
		int n3 = (int) (year * 0.1) % 10;
		int n4 = year % 10;
		
		Bitmap img1 = BCS.getBitmap(ResourceUtil.YEAR_NUM_IMG_LIST[n1]);
		Bitmap img2 = BCS.getBitmap(ResourceUtil.YEAR_NUM_IMG_LIST[n2]);
		Bitmap img3 = BCS.getBitmap(ResourceUtil.YEAR_NUM_IMG_LIST[n3]);
		Bitmap img4 = BCS.getBitmap(ResourceUtil.YEAR_NUM_IMG_LIST[n4]);
		
		int width = img1.getWidth() + img2.getWidth() 
		+ img3.getWidth() + img4.getWidth();
		int height = (int) CommonUtil.mathMax(img1.getHeight(), img2.getHeight(),
				img3.getHeight(), img4.getHeight());
		double ratio = width / height;
		Bitmap newBp = Bitmap.createBitmap((int) (45 * ratio), 45, Config.ARGB_8888);
		Canvas canvas = new Canvas(newBp);
		int offset = 0;
		canvas.drawBitmap(img1, offset, (height - img1.getHeight()) / 2, null);
		offset += img1.getWidth();
		canvas.drawBitmap(img2, offset, (height - img2.getHeight()) / 2, null);
		offset += img2.getWidth();
		canvas.drawBitmap(img3, offset, (height - img3.getHeight()) / 2, null);
		offset += img3.getWidth();
		canvas.drawBitmap(img4, offset, (height - img4.getHeight()) / 2, null);
		
		Bitmap.createBitmap(newBp);
		views.setImageViewBitmap(R.id.View_yearImage, newBp);
	}
	
	private void cleanDateNumbers(RemoteViews views, Context context) {
		int N = ResourceUtil.DATE_VIEW_ID_LIST.length;
		
		for (int i = 0; i < N; i++) {
			int M = ResourceUtil.DATE_VIEW_ID_LIST[i].length;
			for (int j = 0; j < M; j++) {
				views.setImageViewBitmap(
						ResourceUtil.DATE_VIEW_ID_LIST[i][j], 
						BCS.getBitmap(R.drawable.empty));
			}
		}
	}
	
	private void updateMonth(RemoteViews views, Context context, Calendar calendar) {
		int monthId = calendar.get(Calendar.MONTH);
		int resId = ResourceUtil.MONTH_IMG_LIST[monthId];
		views.setImageViewBitmap(R.id.View_monthImage, BCS.getBitmap(resId));
	}
	
	/**
	 * week 1 = Sunday
	 */
	private void updateDateNumbers(RemoteViews views, Context context, Calendar calendar) {
		final int cDate = calendar.get(Calendar.DATE);
		final int cWeek = calendar.get(Calendar.DAY_OF_WEEK);
		final int cDayCount = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		int startWeek = cWeek - (cDate % 7);
		if (startWeek < 0) {
			startWeek += 7;
		} else if (startWeek >= 7) {
			startWeek -= 7;
		}
		int week = startWeek;
		Calendar startDate = new GregorianCalendar(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), 1);
		Calendar endDate = new GregorianCalendar(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), cDayCount);
		Calendar curDate = Calendar.getInstance();
		List<Date> eventDateList = null;
		try {
			if (hasCalendar) {
				eventDateList = CalendarUtil.readCalendar(context, startDate, endDate);
			} else {
				eventDateList = new ArrayList<Date>();
			}
		} catch (Exception e) {
			// read database failed
			eventDateList = new ArrayList<Date>();
			hasCalendar = false;
			
		}
		int monthCompare = CalendarUtil.compareCalendar(curDate, startDate, Calendar.MONTH);
		
		for (int i = 1; i < cDayCount + 1; i++) {
			int indexX = (startWeek + i - 1) % 7; // 0-6
			int indexY = (startWeek + i - 1) / 7; // 0-5
			boolean hasEvent = false;
			for (Date d : eventDateList) {
				if (i == d.getDate()) {
					hasEvent = true;
				}
			}
			
			Bitmap maskBitmap = null;
			if (monthCompare == 0) {
				int dayOffset = curDate.get(Calendar.DAY_OF_MONTH) - i;
				if (dayOffset > 0 && hasEvent) {
					maskBitmap = BCS.getBitmap(R.drawable.selected_old);
				} else if (dayOffset < 0 && hasEvent) {
					maskBitmap = BCS.getBitmap(R.drawable.selected);
				} else if (dayOffset == 0 && hasEvent) {
					maskBitmap = BCS.getBitmap(R.drawable.today_event);
				} else if (dayOffset == 0 && !hasEvent) {
					maskBitmap = BCS.getBitmap(R.drawable.today);
				}
			} else if (monthCompare == 1 && hasEvent) {
				maskBitmap = BCS.getBitmap(R.drawable.selected_old);
			} else if (monthCompare == -1 && hasEvent) {
				maskBitmap = BCS.getBitmap(R.drawable.selected);
			}
			
			
			if (i < 10) {
				drawSingleNumber(indexX, indexY, i, views, maskBitmap);
			} else {
				drawDoubleNumber(indexX, indexY, i, views, maskBitmap);
			}
			
			week = week == 7 ? 1 : week + 1;
		}
	}
	
	
	private void drawSingleNumber(int indexX, int indexY, int i, RemoteViews views, Bitmap maskBitmap) {
		Bitmap newBp = Bitmap.createBitmap(48, 60, Config.ARGB_8888);
		Canvas canvas = new Canvas(newBp);
		//Rect r = new Rect(0, 0, 48, 60);
		//Paint paint = new Paint();
		//paint.set
		//canvas.drawRect(r, paint)
		Bitmap b = BCS.getBitmap(ResourceUtil.NUMBER_IMG_LIST[i]);
		canvas.drawBitmap(b, (48 - b.getWidth()) / 2, (50 - b.getHeight()) / 2, null);
		if (maskBitmap != null) {
			canvas.drawBitmap(maskBitmap, 0, 0, null);
		}
		Bitmap.createBitmap(newBp);
		views.setBitmap(ResourceUtil.DATE_VIEW_ID_LIST[indexY][indexX], "setImageBitmap", newBp);
	}
	
	private void drawDoubleNumber(int indexX, int indexY, int i, RemoteViews views, Bitmap maskBitmap) {
		Bitmap newBp = Bitmap.createBitmap(48, 60, Config.ARGB_8888);
		Canvas canvas = new Canvas(newBp);
		  
		// draw ten digit number
		int tenDigit = (int) (i / 10);
		Bitmap b1  = BCS.getBitmap(ResourceUtil.NUMBER_IMG_LIST[tenDigit]);
		
		// draw single digit number
		int singleDigit = i % 10;
		Bitmap b2 = BCS.getBitmap(ResourceUtil.NUMBER_IMG_LIST[singleDigit]);
		
		int gap = 0;
		canvas.drawBitmap(b1, (48 - b1.getWidth() - b2.getWidth()) / 2 - gap, (50 - b1.getHeight()) / 2, null);
		canvas.drawBitmap(b2, (48 + b1.getWidth() - b2.getWidth()) / 2 + gap, (50 - b2.getHeight()) / 2, null);
		if (maskBitmap != null) {
			canvas.drawBitmap(maskBitmap, 0, 0, null);
		}
		Bitmap.createBitmap(newBp);
		views.setBitmap(ResourceUtil.DATE_VIEW_ID_LIST[indexY][indexX], "setImageBitmap", newBp);		
	}

}