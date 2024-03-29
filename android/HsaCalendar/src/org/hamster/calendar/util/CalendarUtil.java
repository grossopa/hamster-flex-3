package org.hamster.calendar.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;

public class CalendarUtil {

	/**
	 * @param context
	 * @param startDate
	 * @param endDate
	 */
	public static List<Date> readCalendar(Context context, Calendar startDate,
			Calendar endDate) {

		ContentResolver contentResolver = context.getContentResolver();

		List<Date> result = new ArrayList<Date>();
		Uri.Builder builder = Uri.parse("content://calendar/instances/when").buildUpon();
		ContentUris.appendId(builder, startDate.getTime().getTime());
		ContentUris.appendId(builder, endDate.getTime().getTime());

		Cursor eventCursor = contentResolver.query(builder.build(),
				new String[] { "title", "begin", "end", "allDay" }, null, null,
				null);

		while (eventCursor.moveToNext()) {
	//		final String title = eventCursor.getString(0);
			final Date begin = new Date(eventCursor.getLong(1));
	//		final Date end = new Date(eventCursor.getLong(2));
	//		final Boolean allDay = !eventCursor.getString(3).equals("0");
			result.add(begin);
		}
		return result;
	}
	
	/**
	 * @param c1
	 * @param c2
	 * @param can be Calendar.YEAR, Calendar.MONTH or Calendar.DAY_OF_MONTH
	 * @return 1 c1 > c2, 0 equals, -1 c1 < c2
	 */
	public static int compareCalendar(Calendar c1, Calendar c2, int level) {
		int y1 = c1.get(Calendar.YEAR);
		int y2 = c2.get(Calendar.YEAR);
		if (y1 > y2) {
			return 1;
		} else if (y1 < y2) {
			return -1;
		} else if (level == Calendar.YEAR) {
			return 0;
		}
		
		int m1 = c1.get(Calendar.MONTH);
		int m2 = c2.get(Calendar.MONTH);
		if (m1 > m2) {
			return 1;
		} else if (m1 < m2) {
			return -1;
		} else if (level == Calendar.MONTH) {
			return 0;
		}
		
		int d1 = c1.get(Calendar.DAY_OF_MONTH);
		int d2 = c2.get(Calendar.DAY_OF_MONTH);
		if (d1 > d2) {
			return 1;
		} else if (d1 < d2) {
			return -1;
		} else if (level == Calendar.DAY_OF_MONTH) {
			return 0;
		}
		return 0; 
	}
}
