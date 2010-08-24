package org.hamster.calendar.util;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
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
	public static List<Date> readCalendar(Context context, Date startDate,
			Date endDate) {

		ContentResolver contentResolver = context.getContentResolver();

		// Fetch a list of all calendars synced with the device, their display
		// names and whether the
		// user has them selected for display.

		final Cursor cursor = contentResolver.query(Uri
				.parse("content://calendar/calendars"), (new String[] { "_id",
				"color", "selected" }), null, null, null);
		// For a full list of available columns see http://tinyurl.com/yfbg76w

		HashSet<String> calendarIds = new HashSet<String>();

		while (cursor.moveToNext()) {

			final String _id = cursor.getString(0);
			final int color = cursor.getInt(1);
			final Boolean selected = !cursor.getString(2).equals("0");

			System.out.println("Id: " + _id + " color: " + color
					+ " Selected: " + selected);
			calendarIds.add(_id);
		}

		// For each calendar, display all the events from the previous week to
		// the end of next week.
		List<Date> result = new ArrayList<Date>();
		//for (String id : calendarIds) {
		Uri.Builder builder = Uri.parse("content://calendar/instances/when").buildUpon();
		ContentUris.appendId(builder, startDate.getTime());
		ContentUris.appendId(builder, endDate.getTime());

//			Cursor eventCursor = contentResolver
//					.query(builder.build(), new String[] { "begin" },
//							null, null, null);
			Cursor eventCursor = contentResolver.query(builder.build(),
					new String[] { "title", "begin", "end", "allDay"}, null,
					null, null); 
			// For a full list of available columns see
			// http://tinyurl.com/yfbg76w

			
			
			while (eventCursor.moveToNext()) {
				
//				System.out
//						.println("Date : " + new Date(eventCursor.getInt(0)).toLocaleString());
				 final String title = eventCursor.getString(0);
				 final Date begin = new Date(eventCursor.getLong(1));
				 final Date end = new Date(eventCursor.getLong(2));
				 final Boolean allDay = !eventCursor.getString(3).equals("0");
				 result.add(begin);
				 System.out.println("Title: " + title + " Begin: " + begin +
				 " End: " + end +
				 " All Day: " + allDay);
			}
		//}
		return result;
	}
}
