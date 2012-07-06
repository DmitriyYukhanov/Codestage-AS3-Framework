/*The MIT License
 
Copyright (c) 2011 Dmitriy [focus] Yukhanov | http://blog.codestage.ru
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package ru.codestage.utils
{
	import ru.codestage.utils.string.StrValidationUtils;

	/**
	 * Class that contains static utility methods for manipulating and working
	 * with Dates.
	 *
	 * @author focus | http://blog.codestage.ru
	 */
	public class DateUtil
	{

		/**
		 * Returns a two digit representation of the year represented by the
		 * specified date
		 * 
		 * @param d The Date instance whose year will be used to generate a two
		 * digit string representation of the year
		 * 
		 * @return A string that contains a 2 digit representation of the year.
		 * Single digits will be padded with 0
		 */
		public static function getShortYear(d:Date):String
		{
			var dStr:String = String(d.getFullYear());
			
			if(dStr.length < 3)
			{
				return dStr;
			}

			return (dStr.substr(dStr.length - 2));
		}

		/**
		*	Compares two dates and returns an integer depending on their relationship.
		*
		*	Returns -1 if d1 is greater than d2.
		*	Returns 1 if d2 is greater than d1.
		*	Returns 0 if both dates are equal
		*
		* 	@param d1 The date that will be compared to the second date
		*	@param d2 The date that will be compared to the first date
		*
		* 	@return An int indicating how the two dates compare
		*/
		public static function compareDates(d1:Date, d2:Date):int
		{
			var d1ms:Number = d1.getTime();
			var d2ms:Number = d2.getTime();
			
			if(d1ms > d2ms)
			{
				return -1;
			}
			else if(d1ms < d2ms)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}

		/**
		*	Returns a short hour (0 - 12) represented by the specified date.
		*
		*	If the hour is less than 12 (0 - 11 AM) then the hour will be returned.
		*
		*	If the hour is greater than 12 (12 - 23 PM) then the hour minus 12
		*	will be returned
		*
		* 	@param d1 The Date from which to generate the short hour
		*
		* 	@return An int between 0 and 13 ( 1 - 12 ) representing the short hour
		*/
		public static function getShortHour(d:Date):int
		{
			var h:int = d.hours;
			
			if(h == 0 || h == 12)
			{
				return 12;
			}
			else if(h > 12)
			{
				return h - 12;
			}
			else
			{
				return h;
			}
		}
		
		/**
		*	Returns a string indicating whether the date represents a time in the
		*	ante meridiem (AM) or post meridiem (PM).
		*
		*	If the hour is less than 12 then "AM" will be returned.
		*
		*	If the hour is greater than 12 then "PM" will be returned
		*
		* 	@param d1 The Date from which to generate the 12 hour clock indicator
		*
		* 	@return A String ("AM" or "PM") indicating which half of the day the
		*	hour represents
		*/
		public static function getAMPM(d:Date):String
		{
			return (d.hours > 11)? "PM" : "AM";
		}
		
		/**
		* Parses dates that conform to the W3C Date-time Format into Date objects.
		*
		* This function is useful for parsing RSS 1.0 and Atom 1.0 dates
		*
		* @param str
		* @see http://www.w3.org/TR/NOTE-datetime
		*/
		public static function parseW3CDTF(str:String):Date
		{
            var finalDate:Date;
			try
			{
				var dateStr:String = str.substring(0, str.indexOf("T"));
				var timeStr:String = str.substring(str.indexOf("T")+1, str.length);
				var dateArr:Array = dateStr.split("-");
				var year:Number = Number(dateArr.shift());
				var month:Number = Number(dateArr.shift());
				var date:Number = Number(dateArr.shift());
				
				var multiplier:Number;
				var offsetHours:Number;
				var offsetMinutes:Number;
				var offsetStr:String;
				
				if (timeStr.indexOf("Z") != -1)
				{
					multiplier = 1;
					offsetHours = 0;
					offsetMinutes = 0;
					timeStr = timeStr.replace("Z", "");
				}
				else if (timeStr.indexOf("+") != -1)
				{
					multiplier = 1;
					offsetStr = timeStr.substring(timeStr.indexOf("+")+1, timeStr.length);
					offsetHours = Number(offsetStr.substring(0, offsetStr.indexOf(":")));
					offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":")+1, offsetStr.length));
					timeStr = timeStr.substring(0, timeStr.indexOf("+"));
				}
				else // offset is -
				{
					multiplier = -1;
					offsetStr = timeStr.substring(timeStr.indexOf("-")+1, timeStr.length);
					offsetHours = Number(offsetStr.substring(0, offsetStr.indexOf(":")));
					offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":")+1, offsetStr.length));
					timeStr = timeStr.substring(0, timeStr.indexOf("-"));
				}
				var timeArr:Array = timeStr.split(":");
				var hour:Number = Number(timeArr.shift());
				var minutes:Number = Number(timeArr.shift());
				var secondsArr:Array = (timeArr.length > 0) ? String(timeArr.shift()).split(".") : null;
				var seconds:Number = (secondsArr != null && secondsArr.length > 0) ? Number(secondsArr.shift()) : 0;
				//var milliseconds:Number = (secondsArr != null && secondsArr.length > 0) ? Number(secondsArr.shift()) : 0;
				
				var milliseconds:Number = (secondsArr != null && secondsArr.length > 0) ? 1000*parseFloat("0." + secondsArr.shift()) : 0;
				var utc:Number = Date.UTC(year, month-1, date, hour, minutes, seconds, milliseconds);
				var offset:Number = (((offsetHours * 3600000) + (offsetMinutes * 60000)) * multiplier);
				finalDate = new Date(utc - offset);
	
				if (finalDate.toString() == "Invalid Date")
				{
					throw new Error("This date does not conform to W3CDTF.");
				}
			}
			catch (e:Error)
			{
				var eStr:String = "Unable to parse the string [" +str+ "] into a date. ";
				eStr += "The internal error was: " + e.toString();
				throw new Error(eStr);
			}
            return finalDate;
		}
	
		/**
		* Returns a date string formatted according to W3CDTF
		*
		* @param d
		* @param includeMilliseconds Determines whether to include the
		* milliseconds value (if any) in the formatted string
		* @see http://www.w3.org/TR/NOTE-datetime
		*/
		public static function toW3CDTF(d:Date,includeMilliseconds:Boolean=false):String
		{
			var date:Number = d.getUTCDate();
			var month:Number = d.getUTCMonth();
			var hours:Number = d.getUTCHours();
			var minutes:Number = d.getUTCMinutes();
			var seconds:Number = d.getUTCSeconds();
			var milliseconds:Number = d.getUTCMilliseconds();
			var sb:String = new String();
			
			sb += d.getUTCFullYear();
			sb += "-";
			
			//thanks to "dom" who sent in a fix for the line below
			if (month + 1 < 10)
			{
				sb += "0";
			}
			sb += month + 1;
			sb += "-";
			if (date < 10)
			{
				sb += "0";
			}
			sb += date;
			sb += "T";
			if (hours < 10)
			{
				sb += "0";
			}
			sb += hours;
			sb += ":";
			if (minutes < 10)
			{
				sb += "0";
			}
			sb += minutes;
			sb += ":";
			if (seconds < 10)
			{
				sb += "0";
			}
			sb += seconds;
			if (includeMilliseconds && milliseconds > 0)
			{
				sb += ".";
				sb += milliseconds;
			}
			sb += "-00:00";
			return sb;
		}
		
		/**
		 * Converts a date into just after midnight
		 */
		public static function makeMorning(d:Date):Date
		{
			var d:Date = new Date(d.time);
			d.hours = 0;
            d.minutes = 0;
            d.seconds = 0;
            d.milliseconds = 0;
            return d;
		}
		
		/**
		 * Converts a date into just befor midnight
		 */
		public static function makeNight(d:Date):Date
		{
			var d:Date = new Date(d.time);
			d.hours = 23;
            d.minutes = 59;
            d.seconds = 59;
            d.milliseconds = 999;
            return d;
		}

		/**
		 * Sort of converts a date into UTC
		 */
		public static function getUTCDate(d:Date):Date
		{
			var nd:Date = new Date();
			var offset:Number = d.getTimezoneOffset() * 60 * 1000;
			nd.setTime(d.getTime() + offset);
			return nd;
		}
		
		/**
		 * Determines whether the string contains a valid day-first format date
		 *
		 * @param str The string containing a date in a day-first format
		 * @return A Boolean true value if the date is a valid day-first date
		 */
		public static function isWorldDate(str:String):Boolean
		{
			return isDate(str,true);
		}


		/**
		 * Determines if the string contains a valid date
		 * Valid Examples include 9/30/09, 9-30-09 or 9.30.09
		 *
		 * @param str The String containing the date
		 * @param dayFirst Whether the date is in a day first format
		 * @return True value if the data is valid.  If the data is invalid, then
		 * false is returned
		 */
		public static function isDate(str:String, dayFirst:Boolean = false):Boolean
		{
			str = str.split(" ").join("");

			var dash:Boolean = (str.indexOf("-") != -1);
			var slash:Boolean = (str.indexOf("/") != -1);
			var period:Boolean = (str.indexOf(".") != -1);

			var parts:Array;

			//Validate that it used a consistent seperator
			if (dash && !slash && !period)
			{
				parts = str.split("-");
			}
			else if (slash && !dash && !period)
			{
				parts = str.split("/");
			}
			else if (period && !dash && !slash)
			{
				parts = str.split(".");
			}
			else
			{
				return false;
			}

			if (parts.length != 3)
			{
				return false;
			}
			
			//Obtain the pieces of the date
			var month:int, day:int;

			if (dayFirst == true)
			{
				day = parseInt(parts[0]);
				month = parseInt(parts[1]);
			}
			else
			{
				month = parseInt(parts[0]);
				day = parseInt(parts[1]);
			}
			
			var year:int = parseInt(parts[2]);
			var yearLen:int = parts[2].length;

			if (yearLen == 2)
			{
				year = parseInt("20" + parts[2]);
			}
			else if (yearLen != 4)
			{
				return false;
			}
			
			//Validate that the day and month look reasonable
			if (!StrValidationUtils.isIntegerInRange(month.toString(), 1, 12) || !StrValidationUtils.isIntegerInRange(day.toString(), 1, 31))
			{
				return false;
			}
			//Cast as date to determine if the date exists on the calendar
			var dt:Date = new Date(year, month-1, day);
			if (dt.getMonth() != month - 1)
			{
				return false;
			}
			
			return true;
		}
	}
}
