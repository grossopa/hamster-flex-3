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
import org.hamster.calendar.util.ConfigUtil;
import org.hamster.calendar.util.HsConstants;
import org.hamster.calendar.util.ResourceUtil;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Bitmap.Config;
import android.os.Bundle;
import android.widget.RemoteViews;

/**
 * @author yinz
 * 
 */
public class HsaCalendarWidget extends AppWidgetProvider {

	private static BitmapCacheService BCS = BitmapCacheService.getInstance();

	private boolean hasCalendar = true;

	public HsaCalendarWidget() {
		super();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * android.appwidget.AppWidgetProvider#onEnabled(android.content.Context)
	 */
	@Override
	public void onEnabled(Context context) {
		PackageManager pm = context.getPackageManager();
		List<ApplicationInfo> appInfo = pm.getInstalledApplications(PackageManager.GET_META_DATA);
		for (ApplicationInfo info : appInfo) {
			System.out.println("apps : " + info.className + "     " + info.packageName);
		}
		
		RemoteViews views = new RemoteViews(context.getPackageName(),
				R.layout.widget4_4);
		initCalendar(views, context);
		updateCalendar(views, context, Calendar.getInstance());
		updateWidgets(views, context);
	}

	/**
	 * @param views
	 * @param context
	 */
	private void updateWidgets(RemoteViews views, Context context) {
		long updateStartTime = System.currentTimeMillis();
		AppWidgetManager appWidgetManager = AppWidgetManager
				.getInstance(context);
		appWidgetManager.updateAppWidget(new ComponentName(context,
				HsaCalendarWidget.class), views);
		System.out.println("     HAMSTER updateWidget cost "
				+ (System.currentTimeMillis() - updateStartTime) + " ms");
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * android.appwidget.AppWidgetProvider#onReceive(android.content.Context,
	 * android.content.Intent)
	 */
	@Override
	public void onReceive(Context context, Intent intent) {
		super.onReceive(context, intent);
		System.out.println(">>><<< Track : " + intent.getAction());
		boolean invalidate = false;
		Calendar calendar = null;
		if (intent.getAction().equals(HsConstants.RIGHT_CLICK)) {
			calendar = ConfigUtil.getCurDateSelection(context);
			invalidate = true;
			calendar.add(Calendar.MONTH, 1);
		} else if (intent.getAction().equals(HsConstants.LEFT_CLICK)) {
			calendar = ConfigUtil.getCurDateSelection(context);
			invalidate = true;
			calendar.add(Calendar.MONTH, -1);
		} else if (intent.getAction().equals(HsConstants.DATE_TICK)
				|| intent.getAction().equals(HsConstants.YEAR_MONTH_CLICK)) {
//			calendar = Calendar.getInstance();
//			invalidate = true;
			// Intent it = new Intent("android.intent.action.AnCal.ACTION_MODE_EDIT_SELECT_DATE");
			Intent it = new Intent("com.htc.calendar.CalendarApplication");    
		//	it.se
            Bundle data = new Bundle();
            calendar = ConfigUtil.getCurDateSelection(context);
			//invalidate = true;
			calendar.add(Calendar.MONTH, 1);
            data.putLong("date", calendar.getTimeInMillis());
            data.putInt("firstDayOfWeek", Calendar.MONDAY);
            data.putBoolean("noneButton", false);   
            it.putExtras(data);
            it.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(it);
            //startActivityForResult(it, SELECT_DATE_REQUEST);
		}

		if (invalidate == true) {
			RemoteViews views = new RemoteViews(context.getPackageName(),
					R.layout.widget4_4);
			this.updateCalendar(views, context, calendar);
			this.updateWidgets(views, context);
			ConfigUtil.putCurDateSelection(context, calendar);
		}
	}

	/**
	 * @param views
	 * @param context
	 */
	private void initCalendar(RemoteViews views, Context context) {

		Intent rightBtnIntent = new Intent(context, HsaCalendarWidget.class);
		rightBtnIntent.setAction(HsConstants.RIGHT_CLICK);
		PendingIntent rightBtnPendingIntent = PendingIntent.getBroadcast(
				context, 0, rightBtnIntent, 0);
		views.setOnClickPendingIntent(R.id.View_RightButton,
				rightBtnPendingIntent);

		Intent leftBtnIntent = new Intent(context, HsaCalendarWidget.class);
		leftBtnIntent.setAction(HsConstants.LEFT_CLICK);
		PendingIntent leftBtnPendingIntent = PendingIntent.getBroadcast(
				context, 0, leftBtnIntent, 0);
		views.setOnClickPendingIntent(R.id.View_LeftButton,
				leftBtnPendingIntent);

		Intent yearBtnClickIntent = new Intent(context, HsaCalendarWidget.class);
		yearBtnClickIntent.setAction(HsConstants.YEAR_MONTH_CLICK);
		PendingIntent yearBtnClickPendingIntent = PendingIntent.getBroadcast(
				context, 0, yearBtnClickIntent, 0);
		views.setOnClickPendingIntent(R.id.View_yearImage,
				yearBtnClickPendingIntent);

		Intent monthBtnClickIntent = new Intent(context,
				HsaCalendarWidget.class);
		monthBtnClickIntent.setAction(HsConstants.YEAR_MONTH_CLICK);
		PendingIntent monthBtnClickPendingIntent = PendingIntent.getBroadcast(
				context, 0, monthBtnClickIntent, 0);
		views.setOnClickPendingIntent(R.id.View_monthImage,
				monthBtnClickPendingIntent);

		Calendar c = Calendar.getInstance();
		c.set(Calendar.HOUR_OF_DAY, 0);
		c.set(Calendar.MINUTE, 0);
		c.set(Calendar.SECOND, 0);
		c.set(Calendar.MILLISECOND, 0);
		c.add(Calendar.DAY_OF_MONTH, 1);

		AlarmManager alarmManager = (AlarmManager) context
				.getSystemService(Context.ALARM_SERVICE);
		Intent timeIntent = new Intent(context, HsaCalendarWidget.class);
		timeIntent.setAction(HsConstants.DATE_TICK);
		PendingIntent timePendingIntent = PendingIntent.getBroadcast(context,
				0, timeIntent, 0);
		alarmManager.setRepeating(AlarmManager.RTC, c.getTimeInMillis(),
				AlarmManager.INTERVAL_DAY, timePendingIntent);
	}

	private void updateCalendar(RemoteViews views, Context context,
			Calendar calendar) {
		long time = System.currentTimeMillis();
		long startTime = time;

		cleanDateNumbers(views, context);

		System.out.println("    HAMSTER INFO : cleanDateNumbers cost "
				+ (System.currentTimeMillis() - time));
		time = System.currentTimeMillis();

		updateDateNumbers(views, context, calendar);

		System.out.println("    HAMSTER INFO : updateDateNumbers cost "
				+ (System.currentTimeMillis() - time));
		time = System.currentTimeMillis();

		updateMonth(views, context, calendar);

		System.out.println("    HAMSTER INFO : updateMonth cost "
				+ (System.currentTimeMillis() - time));
		time = System.currentTimeMillis();

		updateYear(views, context, calendar);

		System.out.println("    HAMSTER INFO : updateYear cost "
				+ (System.currentTimeMillis() - time) + "  all cost: "
				+ (System.currentTimeMillis() - startTime));
	}

	private void updateYear(RemoteViews views, Context context,
			Calendar calendar) {
		int year = calendar.get(Calendar.YEAR);
		int n1 = (int) (year * 0.001);
		int n2 = (int) (year * 0.01) % 10;
		int n3 = (int) (year * 0.1) % 10;
		int n4 = year % 10;

		Bitmap img1 = BCS.getBitmap(context, ResourceUtil.YEAR_NUM_IMG_LIST[n1]);
		Bitmap img2 = BCS.getBitmap(context, ResourceUtil.YEAR_NUM_IMG_LIST[n2]);
		Bitmap img3 = BCS.getBitmap(context, ResourceUtil.YEAR_NUM_IMG_LIST[n3]);
		Bitmap img4 = BCS.getBitmap(context, ResourceUtil.YEAR_NUM_IMG_LIST[n4]);

		int width = img1.getWidth() + img2.getWidth() + img3.getWidth()
				+ img4.getWidth();
		int height = (int) CommonUtil.mathMax(img1.getHeight(), img2
				.getHeight(), img3.getHeight(), img4.getHeight());
		// double ratio = width / height;
		Bitmap newBp = Bitmap.createBitmap(width, height, Config.ARGB_8888);
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
				views.setImageViewBitmap(ResourceUtil.DATE_VIEW_ID_LIST[i][j],
						BCS.getBitmap(context, R.drawable.empty));
			}
		}
	}

	private void updateMonth(RemoteViews views, Context context,
			Calendar calendar) {
		int monthId = calendar.get(Calendar.MONTH);
		int resId = ResourceUtil.MONTH_IMG_LIST[monthId];
		views.setImageViewBitmap(R.id.View_monthImage, BCS.getBitmap(context,
				resId));
	}

	/**
	 * week 1 = Sunday
	 */
	private void updateDateNumbers(RemoteViews views, Context context,
			Calendar calendar) {
		final int cDate = calendar.get(Calendar.DATE);
		final int cWeek = calendar.get(Calendar.DAY_OF_WEEK);
		final int cDayCount = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		int startWeek = cWeek - (cDate % 7);
		if (startWeek < 0) {
			startWeek += 7;
		} else if (startWeek >= 7) {
			startWeek -= 7;
		}
		Calendar startDate = new GregorianCalendar(calendar.get(Calendar.YEAR),
				calendar.get(Calendar.MONTH), 1);
		Calendar endDate = new GregorianCalendar(calendar.get(Calendar.YEAR),
				calendar.get(Calendar.MONTH), cDayCount);
		Calendar curDate = Calendar.getInstance();
		List<Date> eventDateList = null;
		try {
			long startTime = System.currentTimeMillis();
			if (hasCalendar) {
				eventDateList = CalendarUtil.readCalendar(context, startDate,
						endDate);
			} else {
				eventDateList = new ArrayList<Date>();
			}
			System.out.println("     HAMSTER load calendar info cost "
					+ (System.currentTimeMillis() - startTime));
		} catch (Exception e) {
			// read database failed
			eventDateList = new ArrayList<Date>();
			hasCalendar = false;

		}
		int monthCompare = CalendarUtil.compareCalendar(curDate, startDate,
				Calendar.MONTH);
		boolean red = false;
		float density = context.getResources().getDisplayMetrics().density;
		int widthPx = (int) (48 * density);
		int heightPx = (int) (54 * density);

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
					maskBitmap = BCS.getBitmap(context, R.drawable.selected_old);
				} else if (dayOffset < 0 && hasEvent) {
					maskBitmap = BCS.getBitmap(context, R.drawable.selected);
				} else if (dayOffset == 0 && hasEvent) {
					maskBitmap = BCS.getBitmap(context, R.drawable.today_event);
				} else if (dayOffset == 0 && !hasEvent) {
					maskBitmap = BCS.getBitmap(context, R.drawable.today);
				}
			} else if (monthCompare == 1 && hasEvent) {
				maskBitmap = BCS.getBitmap(context, R.drawable.selected_old);
			} else if (monthCompare == -1 && hasEvent) {
				maskBitmap = BCS.getBitmap(context, R.drawable.selected);
			}

			red = (indexX == 6 || indexX == 0);
			if (i < 10) {
				drawSingleNumber(context, indexX, indexY, i, views, maskBitmap,
						red, widthPx, heightPx);
			} else {
				drawDoubleNumber(context, indexX, indexY, i, views, maskBitmap,
						red, widthPx, heightPx);
			}
		}
	}

	private void drawSingleNumber(Context context, int indexX, int indexY,
			int i, RemoteViews views, Bitmap maskBitmap, boolean red,
			int widthPx, int heightPx) {
		Bitmap newBp = Bitmap.createBitmap(widthPx, heightPx, Config.ARGB_4444);
		Canvas canvas = new Canvas(newBp);
		Bitmap b = red ? BCS.getBitmap(context,
				ResourceUtil.NUMBER_IMG_LIST_RED[i]) : BCS.getBitmap(context,
				ResourceUtil.NUMBER_IMG_LIST[i]);
		canvas.drawBitmap(b, (widthPx - b.getWidth()) / 2, (heightPx - b.getHeight()) / 2,
				null);
		if (maskBitmap != null) {
			canvas.drawBitmap(maskBitmap, 0, 0, null);
		}
		Bitmap.createBitmap(newBp);
		views.setBitmap(ResourceUtil.DATE_VIEW_ID_LIST[indexY][indexX],
				"setImageBitmap", newBp);
	}

	private void drawDoubleNumber(Context context, int indexX, int indexY,
			int i, RemoteViews views, Bitmap maskBitmap, boolean red,
			int widthPx, int heightPx) {
		Bitmap newBp = Bitmap.createBitmap(widthPx, heightPx, Config.ARGB_4444);
		Canvas canvas = new Canvas(newBp);

		// draw ten digit number
		int tenDigit = (int) (i / 10);
		Bitmap b1 = red ? BCS.getBitmap(context,
				ResourceUtil.NUMBER_IMG_LIST_RED[tenDigit]) : BCS.getBitmap(
				context, ResourceUtil.NUMBER_IMG_LIST[tenDigit]);

		// draw single digit number
		int singleDigit = i % 10;
		Bitmap b2 = red ? BCS.getBitmap(context,
				ResourceUtil.NUMBER_IMG_LIST_RED[singleDigit]) : BCS.getBitmap(
				context, ResourceUtil.NUMBER_IMG_LIST[singleDigit]);

		int gap = 0;
		canvas.drawBitmap(b1, (widthPx - b1.getWidth() - b2.getWidth()) / 2 - gap,
				(heightPx - b1.getHeight()) / 2, null);
		canvas.drawBitmap(b2, (widthPx + b1.getWidth() - b2.getWidth()) / 2 + gap,
				(heightPx - b2.getHeight()) / 2, null);
		if (maskBitmap != null) {
			canvas.drawBitmap(maskBitmap, 0, 0, null);
		}
		Bitmap.createBitmap(newBp);
		views.setBitmap(ResourceUtil.DATE_VIEW_ID_LIST[indexY][indexX],
				"setImageBitmap", newBp);
	}

}
