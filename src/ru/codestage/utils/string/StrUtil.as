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

/**
 * Contains parts of the String Utilities class by Ryan Matsikas, Feb 10 2006
 * 
 * Visit www.gskinner.com for documentation, updates and more free code.
 * You may distribute this code freely, as long as this comment block remains intact.
 */

package ru.codestage.utils.string
{
	/**
	 * Different string-around functions.
	 * @author focus | http://blog.codestage.ru
	 */
	public final class StrUtil
	{
		// Whitespace characters (space, tab, new line and return)
		private static const WHITESPACE:String = "	\t\n\r";
		
		/**
		 * Generates anti-cache string
		 *
		 * @param prefix Generated string prefix
		 *
		 * @return Generated anticache string
		 */
		public static function getAntiCache(prefix:String = '?ac='):String
		{
			var dtTmp:Date = new Date();
			return prefix + String(dtTmp.getFullYear()) +
							String(dtTmp.getMinutes()) +
							String(dtTmp.getMilliseconds()) +
							String(dtTmp.getHours()) +
							String(dtTmp.getDay());
		}
		
		/**
		 * Returns given filename's directory path
		 *
		 * @param filepath Full path to the file
		 *
		 * @return Directory path of the given filepath
		 */
		public static function getFileDir(filepath:String):String
		{
			var result:String = '';
			if (filepath.lastIndexOf("/") != -1)
			{
				result = filepath.substring(0,filepath.lastIndexOf("/")+1);
			}
			else if (filepath.lastIndexOf("\\") != -1)
			{
				result = filepath.substring(0,filepath.lastIndexOf("\\")+1);
			}
			return result;
		}
		
		/**
		 * Returns given filename's extension (chars after last period)
		 *
		 * @param filename Source filename
		 *
		 * @return Extension (chars after last period) of the filename
		 */
		public static function getFileExtension(filename:String):String
		{
			return filename.substring(filename.lastIndexOf(".")+1,filename.length);
		}
		
		/**
		 * Returns given filename's clean name, without extension (chars before last period)
		 *
		 * @param filename Source filename
		 *
		 * @return clean filename without extension
		 */
		public static function getFileName(filename:String):String
		{
			if (filename.lastIndexOf("/") != -1)
			{
				return filename.substring(filename.lastIndexOf("/") + 1, filename.lastIndexOf("."));
			}
			else if (filename.lastIndexOf("\\") != -1)
			{
				return filename.substring(filename.lastIndexOf("\\") + 1, filename.lastIndexOf("."));
			}
			else
			{
				return filename.substring(filename.lastIndexOf("\\") + 1, filename.lastIndexOf("."));
			}
		}
		
		/**
		 * Returns time in hh:mm:ss format from seconds
		 *
		 * @param timeInSeconds <code>Time</code> in seconds to convert
		 *
		 * @return Formatted time string
		 */
		public static function formatTime(timeInSeconds:Number):String
		{
			var nRemainder:Number;
			
			var nHours:Number = timeInSeconds / ( 60 * 60 );
			nRemainder = nHours - (nHours | 0);
			nHours = nHours | 0;
			
			var nMinutes:Number = nRemainder * 60;
			nRemainder = nMinutes - (nMinutes | 0);
			nMinutes = nMinutes | 0;
			
			var nSeconds:Number = nRemainder * 60;
			nRemainder = nSeconds - (nSeconds | 0);
			nSeconds = nSeconds | 0;
			
			var hString:String = nHours < 10 ? "0" + nHours : "" + nHours;
			var mString:String = nMinutes < 10 ? "0" + nMinutes : "" + nMinutes;
			var sString:String = nSeconds < 10 ? "0" + nSeconds : "" + nSeconds;
			
			if ( timeInSeconds < 0 || isNaN(timeInSeconds)) return "00:00";
			
			if (nHours > 0 )
			{
				return hString + ":" + mString + ":" + sString;
			}
			else
			{
				return mString + ":" + sString;
			}
		}
		
		/**
		 * This function will pad the left or right side of any <code>String</code> passed in elem
		 *
		 * @param elem          Source string to pad
		 * @param finalLength   Maximum pad length
		 * @param padChar       Character to use for padding
		 * @param dir           Pad direction ("l" - left, "r" - right)
		 *
		 * @return Resulting string with padding
		 */
		public static function pad(elem:String, finalLength:uint = 2, padChar:String = '0', dir:String = 'l'):String
        {
            //make sure the direction is in lowercase
            dir = dir.toLowerCase();

            //store the elem length
            var elemLen:uint = elem.length;

            //check the length for escape clause
            if(elemLen == finalLength)
            {
                return elem;
            }

            //pad the value
            if (dir == 'l')
            {
                return pad(padChar + elem, finalLength, padChar, dir);
            }
            else
            {
                return pad(elem + padChar, finalLength, padChar, dir);
            }
        }
		
		/**
		 * Duplicates 'source' string 'count' times
		 *
		 * @param source <code>String</code> to duplicate
		 * @param count  Duplicates count
		 *
		 * @return Duplicated string
		 */
		public static function duplicateString(source:String, count:uint = 1):String
		{
			var res:String = '';
			while (count)
			{
				res += source;
				count--;
			}
			return res;
		}
		
		/**
		 * Converts HTML &amp;,&quot;,etc into the characters
		 *
		 * @param str HTML string to process
		 *
		 * @return <code>String</code> with unescaped HTML
		 */
		public static function unescapeHTML(str:String):String
		{
			return str.replace(/(&lt;)|(&gt;)|(&quot;)|(&amp;)|(&apos;)/gi, function():String { return new function():void{ this["&lt;"]="<", this["&gt;"]=">", this["&quot;"]="\"", this["&amp;"]="&", this["&apos;"]="'"; }()[arguments[0]] });
		}
		
		/**
		 * Encodes characters within a string for use in an HTML Text Field.
		 * The characters escaped include: &lt;&gt;'&#38;"
		 *
		 * @param str The <code>String</code> containing the HTML data
		 *
		 * @return An HTML encoded version of the original string
		 */
		public static function escapeHTML(str:String):String
		{
			var safeString:String = str;
			if (safeString.indexOf("&") >= 0)
			{
				safeString = safeString.split("&").join("&amp;");
			}
			if (safeString.indexOf("<") >= 0)
			{
				safeString = safeString.split("<").join("&lt;");
			}
			if (safeString.indexOf(">") >= 0)
			{
				safeString = safeString.split(">").join("&gt;");
			}
			if (safeString.indexOf("\"") >= 0)
			{
				safeString = safeString.split("\"").join("&quot;");
			}
			if (safeString.indexOf("'") >= 0)
			{
				safeString = safeString.split("'").join("&apos;");
			}
			return safeString;
		}
		
		/**
		 * Returns a shortened <code>String</code>
		 *
		 * @param source    <code>String</code> to shorten
		 * @param trailing  The number of characters to keep in the end of the <code>String</code>
		 * @param leading   The number of characters to keep in the begining of the <code>String</code>
		 * @param separator Characters to seperate the begining and the end of the <code>String</code>
		 *
		 * @return The shortened String
		 *
		 * @example <listing version="3.0">
		 * trace(StringUtil.truncate('Mississippi', 2, 3, '...')); // traces "Mis...pi" </listing>
		 */
		public static function truncate(source:String, leading:uint = 10, trailing:uint = 0, separator:String = "..."):String
		{
			var lead:String  = source.substr(0, leading);
			var trail:String = source.substr( -trailing, trailing);
			return lead + separator + trail;
		}
		
		/**
		 * Used to include trailing delimiter into the given path
		 *
		 * @param path Path to the file or directory
		 * @param separator Separator to use as a path delimiter
		 *
		 * @return Path with trailing delimiter (e.g. with "\" on Win and "/" on Mac)
		 */
		public static function includeTrailingPathDelimiter(path:String, separator:String = "\\"):String
		{
			if (path.charAt(path.length-1) != separator)
			{
				path += separator
			}
			return path;
		}
		
		/**
		 * Returns all the numeric characters from a <code>String</code>
		 *
		 * @param source <code>String</code> to return numbers from
		 *
		 * @return <code>String</code> containing only numbers
		 */
		public static function getNumbersFromString(source:String):String
		{
			var pattern:RegExp = /[^0-9]/g;
			return source.replace(pattern, '');
		}
		
		/**
		 * Returns all the letter characters from a <code>String</code>
		 *
		 * @param source <code>String</code> to return letters from
		 *
		 * @return <code>String</code> containing only letters
		 */
		public static function getLettersFromString(source:String):String
		{
			var pattern:RegExp = /[[:digit:]|[:punct:]|\s]/g;
			return source.replace(pattern, '');
		}
		
		/**
		 * Strips whitespace (or other characters) from the beginning of a <code>String</code>
		 *
		 * @param source <code>String</code> to remove characters from
		 * @param removeChars Characters to strip (case sensitive). Defaults to whitespace characters
		 *
		 * @return <code>String</code> with characters removed
		 */
		public static function trimLeft(source:String, removeChars:String = WHITESPACE):String
		{
			var pattern:RegExp = new RegExp('^[' + removeChars + ']+', '');
			return source.replace(pattern, '');
		}
		
		/**
		 * Strips whitespace (or other characters) from the end of a <code>String</code>
		 *
		 * @param source <code>String</code> to remove characters from
		 * @param removeChars Characters to strip (case sensitive). Defaults to whitespace characters
		 *
		 * @return String with characters removed
		 */
		public static function trimRight(source:String, removeChars:String = WHITESPACE):String
		{
			var pattern:RegExp = new RegExp('[' + removeChars + ']+$', '');
			return source.replace(pattern, '');
		}
		
		/**
		 * Strips whitespace (or other characters) from the beginning and end of a given string
		 *
		 * @param source String to remove characters from
		 * @param removeChars Characters to strip (case sensitive). Defaults to whitespace characters
		 *
		 * @return String with characters removed
		 */
		public static function trim(source:String, removeChars:String = WHITESPACE):String
		{
			var pattern:RegExp = new RegExp('^[' + removeChars + ']+|[' + removeChars + ']+$', 'g');
			return source.replace(pattern, '');
		}
		
		/**
		 * Removes extraneous whitespace (extra spaces, tabs, line breaks, etc) from the specified string
		 *
		 * @param	source The String whose extraneous whitespace will be removed
		 *
		 * @return	<code>String</code> with extraneous whitespace removed
		 */
		public static function removeExtraWhitespace(source:String):String
		{
			if (source == null)
			{
				return '';
			}
			var str:String = trim(source);
			return str.replace(/\s+/g, ' ');
		}
		
		/**
		 * Returns everything after the first occurrence of the provided character in the string
		 * 
		 * @param targetString Target string
		 * @param char Character or sub-string
		 * 
		 * @return Everything after the first occurrence of <code>char</code>
		 */
		public static function afterFirst(targetString:String, char:String):String
		{
			if (targetString == null)
			{
				return '';
			}
			var idx:int = targetString.indexOf(char);
			if (idx == -1)
			{
				return '';
			}
			idx += char.length;
			return targetString.substr(idx);
		}
		
		/**
		 * Returns everything after the last occurence of the provided character in p_string
		 * 
		 * @param targetString Target string
		 * @param char Character or sub-string
		 * 
		 * @return Everything after the last occurrence of <code>char</code>
		 */
		public static function afterLast(targetString:String, char:String):String 
		{
			if (targetString == null)
			{
				return '';
			}
			var idx:int = targetString.lastIndexOf(char);
			if (idx == -1)
			{
				return '';
			}
			idx += char.length;
			return targetString.substr(idx);
		}
		
		/**
		 * Returns everything before the first occurrence of the provided character in the string
		 * 
		 * @param targetString Target string
		 * @param char Character or sub-string
		 * 
		 * @return Everything before the first occurrence of <code>char</code>
		 */
		public static function beforeFirst(targetString:String, char:String):String 
		{
			if (targetString == null)
			{
				return '';
			}
			var idx:int = targetString.indexOf(char);
        	if (idx == -1)
			{
				return '';
			}
        	return targetString.substr(0, idx);
		}
		
		/**
		 * Returns everything before the last occurrence of the provided character in the string
		 * 
		 * @param targetString Target string
		 * @param char Character or sub-string
		 * 
		 * @return Everything before the last occurrence of <code>char</code>
		 */
		public static function beforeLast(targetString:String, char:String):String
		{
			if (targetString == null)
			{
				return '';
			}
			var idx:int = targetString.lastIndexOf(char);
        	if (idx == -1)
			{
				return '';
			}
        	return targetString.substr(0, idx);
		}
		
		/**
		 * Returns everything after the first occurance of <code>startString</code> and before
		 * the first occurrence of <code>endString</code> in <code>targetString</code>
		 * 
		 * @param targetString Target string
		 * @param startString Character or sub-string to use as the start index
		 * @param endString Character or sub-string to use as the end index
		 * 
		 * @return Everything after the first occurance of <code>startString</code> and before
		 * the first occurrence of <code>endString</code> in <code>targetString</code>
		 */
		public static function between(targetString:String, startString:String, endString:String):String
		{
			var str:String = '';
			if (targetString == null)
			{
				return str;
			}
			var startIdx:int = targetString.indexOf(startString);
			if (startIdx != -1)
			{
				startIdx += startString.length; // RM: should we support multiple chars? (or ++startIdx);
				var endIdx:int = targetString.indexOf(endString, startIdx);
				if (endIdx != -1)
				{
					str = targetString.substr(startIdx, endIdx - startIdx);
				}
			}
			return str;
		}
		
		/**
		 * Capitallizes the first word in a string or all words
		 * 
		 * @param targetString Target string
		 * @param allWords (optional) Boolean value indicating if we should
		 * capitalize all words or only the first
		 * 
		 * @return String with capitalized word(s)
		 */
		public static function capitalize(targetString:String, allWords:Boolean = false):String 
		{
			var str:String = trimLeft(targetString);
			if (allWords)
			{
				return str.replace(/^.|\b./g, _upperCase);
			}
			else
			{
				return str.replace(/(^\w)/, _upperCase);
			}
		}
		
		/**
		 * Determines the number of times a charactor or sub-string appears within the string
		 * 
		 * @param targetString Target string
		 * @param char The character or sub-string to count
		 * @param caseSensitive (optional, default is true) A boolean flag to indicate if the
		 * search is case sensitive
		 * 
		 * @return Number of times a charactor or sub-string appears within the string
		 */
		public static function countOf(targetString:String, char:String, caseSensitive:Boolean = true):uint
		{
			if (targetString == null)
			{
				return 0;
			}
			var escapedChar:String = escapePattern(char);
			var flags:String = (!caseSensitive) ? 'ig' : 'g';
			return targetString.match(new RegExp(escapedChar, flags)).length;
		}
		
		/**
		 * Removes all instances of the remove string in the input string
		 * 
		 * @param targetString The string that will be checked for instances of remove
		 * string
		 * @param toRemove The string that will be removed from the input string
		 * @param caseSensitive An optional boolean indicating if the replace is case sensitive. Default is true
		 * 
		 * @return String without <code>toRemove</code> instances
		 */
		public static function remove(targetString:String, toRemove:String, caseSensitive:Boolean = true):String
		{
			if (targetString == null)
			{
				return '';
			}
			var rem:String = escapePattern(toRemove);
			var flags:String = (!caseSensitive) ? 'ig' : 'g';
			return targetString.replace(new RegExp(rem, flags), '');
		}
		
		/**
		 * Returns the specified string in reverse character order
		 * 
		 * @param targetString The String that will be reversed
		 * 
		 * @return Reversed <code>targetString</code>
		 */
		public static function reverse(targetString:String):String
		{
			if (targetString == null)
			{
				return '';
			}
			return targetString.split('').reverse().join('');
		}
		
		/**
		 * Returns the specified string in reverse word order
		 * 
		 * @param targetString The String that will be reversed
		 * 
		 * @return String with reversed word order
		 */
		public static function reverseWords(targetString:String):String
		{
			if (targetString == null)
			{
				return '';
			}
			return targetString.split(/\s+/).reverse().join('');
		}
		
		/**
		 * Removes all &lt; and &gt; based tags from a string
		 * 
		 * @param targetString The source string
		 * 
		 * @return String with removed tags
		 */
		public static function stripTags(targetString:String):String
		{
			if (targetString == null)
			{
				return '';
			}
			return targetString.replace(/<\/?[^>]+>/igm, '');
		}
		
		/* **************************************************************** */
		/*	These are helper methods used by some of the above methods.		*/
		/* **************************************************************** */
		private static function escapePattern(pattern:String):String
		{
			// RM: might expose this one, I've used it a few times already.
			return pattern.replace(/(\]|\[|\{|\}|\(|\)|\*|\+|\?|\.|\\)/g, '\\$1');
		}
		
		private static function _upperCase():String
		{
			return arguments[0].toUpperCase();
		}
	}
	
}