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
	 * Different data validation functions
	 *
	 * Original (c) by Adobe (as3DataValidation classes), 2007
	 *
	 * @author focus | http://blog.codestage.ru
	 */
	public class StrValidationUtils
	{
		private static const DECIMAL_DIGITS:String = "01234567890";
		private static const LC_ROMAN_LETTERS:String = "abcdefghijklmnopqrstuvwxyz";

		/**
		 * Compare a string against a list of characters to determine if the string does not
		 * contain those characters.  This comparison is not case-senstive and it does not
		 * validate that the characters are in a particular order
		 *
		 * @param str The string that needs to be validated
		 * @param chars The list of valid characters for that string
		 * @return A Boolean true value if the data is valid
		 */
		public static function hasInvalidChars(str:String, chars:String):Boolean
		{
			var bRet:Boolean = false;
			var len:uint = str.length;
			var i:uint = 0;
			
			for (i; i < len; i++)
			{
				if (chars.indexOf(str.charAt(i)))
				{
					bRet = true;
					break;
				}
			}
			return bRet;
		}


		/**
		 * Compare a string against a list of characters to determine if the string contains
		 * only those characters.  This comparison is not case-sensitive and does not validate
		 * the order of the characters
		 *
		 * @param str The string that needs to be validated
		 * @param chars The list of valid characters for that string
		 * @return A Boolean true value if the data is valid
		 */
		public static function hasValidChars(str:String, chars:String):Boolean
		{
			var bRet:Boolean = true;
			str = str.toLowerCase();
			if (str.length != 0)
			{
				chars = chars.toLowerCase();
				var cArr:Array = str.split("");
				var len:uint = cArr.length;
				var i:uint = 0;
				for (i; i < len; i++)
				{
					var valid:Boolean = (chars.indexOf(cArr[i]) != -1);
					if (!valid)
					{
						bRet = false;
						break;
					}
				}
			}
			else
			{
				bRet = false;
			}
			
			return bRet;
		}


		/**
		 * Determine whether a string is a valid IP address
		 *
		 * @param ip The string containing the IP address
		 * @return Will return true if the data is valid
		 */
		public static function isIP4(ip:String):Boolean
		{
			var bRet:Boolean = true;
			
			if (!hasValidChars(ip, DECIMAL_DIGITS + "."))
			{
				bRet = false;
			}
			else
			{
				//Does the IP contain four sections
				var parts:Array = ip.split(".");
				if (parts.length != 4)
				{
					bRet = false;
				}
				else if (parseInt(parts[0]) == 0)//Make sure the first number is not zero
				{
					bRet = false;
				}
				else
				{
					//Validate that each part exists and is in the correct range
					var len:uint = parts.length;
					var i:uint = 0;
					for (i; i < len; i++)
					{
						if ((parts[i].length == 0) || (parseInt(parts[i]) > 255 || parseInt(parts[i]) < 0))
						{
							bRet = false;
							break;
						}
					}
				}
			}
			return bRet;
		}
		
		/**
		 * Determine whether a string is a Windows file URL
		 *
		 * @param fileURL The string containing the file url
		 * @return Will return true if the data is valid
		 */
		public static function isFileURL(fileURL:String):Boolean
		{
			var bRet:Boolean = true;
			
			//Does it start with file://
			if (fileURL.indexOf("file://") != 0)
			{
				bRet = false;
			}
			else
			{
				var lastSlash:int = fileURL.lastIndexOf("/");
				
				//On windows systems paths can not be longer than 248 characters
				if (lastSlash - 7 >= 248)
				{
					bRet = false;
				}
				else if (fileURL.length - lastSlash >= 260) //On Windows machines filenames can not be longer than 260 characters
				{
					bRet = false;
				}
				else if (fileURL.length >= 260 + 248 + 7) //Just in case the slash is encoded or something
				{
					bRet = false;
				}
			}
			return bRet;
		}
		
		/**
		 * Performs basic checks to determine if a string is a valid HTTPS URL
		 *
		 * @param str The string containing the HTTPS URL
		 * @param domain The expected domain for the URL (optional)
		 * @return Will return true if the data is valid
		 */
		public static function isHttpsURL(str:String, domain:String = ""):Boolean
		{
			return isHttpURL(str,domain,true);
		}
		
		
		/**
		 * Performs basic checks to determine if a string is a valid HTTP or HTTPS URL
		 *
		 * @param str The string containing the URL
		 * @param domain The expected domain for the URL (optional)
		 * @param isSSL A boolean value that is set to true for HTTPS URLs (optional)
		 * @return Will return true if the data is valid
		 */
		public static function isHttpURL(str:String, domain:String = "", isSSL:Boolean = false):Boolean
		{
			var res:Boolean = true;
			str = str.toLowerCase();

			//Assuming domain contains at least 4 characters (a.eu)
			if (str.length<9 || str.length>4096)
			{
				res = false;
			}
			else
			{
				var startIndex:int;
				var startLen:int;
				if (isSSL)
				{
					startIndex = str.indexOf("https://");
					startLen = 8;
				}
				else
				{
					startIndex = str.indexOf("http://");
					startLen = 7;
				}

				if (startIndex != 0)
				{
					res = false;
				}
				else if (!hasValidChars(str, DECIMAL_DIGITS + LC_ROMAN_LETTERS + "-_.:/?&%#=+~"))
				{
					res = false;
				}
				else
				{
					var tempDomain:String;
					if (str.indexOf("/", startLen + 1) > 0)
					{
						tempDomain = str.substr(startLen, str.indexOf("/", startLen+1)-startLen);
					}
					else
					{
						tempDomain = str.substring(startLen, str.length);
					}
					
					//Does the domain name appear to be valid
					if (!hasValidChars(tempDomain, DECIMAL_DIGITS + LC_ROMAN_LETTERS + "-."))
					{
						res = false;
					}
					else if (domain.length > 0 && domain != tempDomain)
					{
						res = false;
					}
					else if ((str.indexOf("?") > startLen + 1) && (str.indexOf("?") != str.lastIndexOf("?")))
					{
						res = false;
					}
				}
			}
			return res;
		}
		
		/**
		 * Determines whether a string is an email address.
		 * Checks for common email address formats but it does not support the full RFC definition
		 *
		 * @param mail The string containing the email address
		 * @return Will return true if the data is valid
		 */
		public static function isValidEmail(mail:String):Boolean
		{
			//var reExpression:RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			var reExpression:RegExp = /\S+@\S+\.\S{2,4}/i;
			return reExpression.test(mail);
		}
		
		/**
		 * Determines whether a string is an phone number
		 *
		 * @param phoneNumber The string containing the phone number
		 * @return Will return true if the data is valid
		 */
		public static function isValidPhone(phoneNumber:String):Boolean
		{
			var reExpression:RegExp = /^[-0-9]{3,}$/;
			return reExpression.test(phoneNumber);
		}
		
		/**
		 * Determines whether the specified string is numeric
		 *
		 * @param source <code>String</code> to check
		 * @return True if given <code>String</code> is a number; otherwise false
		 */
		public static function isNumeric(source:String):Boolean
		{
			if (source == null) { return false; }
			var regx:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
			return regx.test(source);
		}
		
		/**
		 * Casts a string as a number.  If it fails, returns false
		 *
		 * @param n The String of the number to validate
		 * @return A Boolean true value if the data is valid
		 */
		public static function isDigit(n:String):Boolean
		{
			if (n == "" || n == null || n.length != 1)
			{
				return false;
			}
			return ! isNaN(parseInt(n));
		}


		/**
		 * Determines if n is within A-Z or a-z
		 *
		 * @param n The character to validate
		 * @return A Boolean true value if the data is valid
		 */
		public static function isLetter(n:String):Boolean
		{
			if (n == "" || n == null || n.length != 1)
			{
				return false;
			}
			return LC_ROMAN_LETTERS.indexOf(n.toLowerCase()) != -1;
		}


		/**
		 * Determines whether the string contains only alphabetic and numeric characters
		 *
		 * @param str The string to validate
		 * @return A Boolean true value if the data is valid
		 */
		public static function isAlphaNumeric(str:String):Boolean
		{
			return hasValidChars(str,DECIMAL_DIGITS + LC_ROMAN_LETTERS);
		}


		/**
		 * Does the character contain an alphabetic character or number
		 *
		 * @param n The character to validate
		 * @return A Boolean true value if the data is valid
		 */
		public static function isLetterOrDigit(n:String):Boolean
		{
			if (n.length != 1) {return false;}
			var ret:Boolean = (isLetter(n) || isDigit(n));
			return ret;
		}


		/**
		 * Determines whether the string contains data
		 *
		 * @param str The character to validate
		 * @param ignoreWhite A boolean when set to false will ignore white space (space, newline, tab, return)
		 * @return A Boolean true value if the string is not empty
		 */
		public static function isNotEmpty(str:String, keepWhite:Boolean = false):Boolean
		{
			if (keepWhite == false)
			{
				str = str.split(" ").join("");
				str = str.split("\n").join("");
				str = str.split("\t").join("");
				str = str.split("\r").join("");
			}
			return str.length > 0;
		}


		/**
		 * Determines whether the integer with a specified range
		 *
		 * @param n The String representing the number to validate
		 * @param min The minimum value as a Number (&gt;= comparison)
		 * @param max The maxium value  as a Number (&lt;= comparison)
		 * @return A Boolean true value if the data is within the range
		 */
		public static function isIntegerInRange(nString:String, min:int, max:int):Boolean
		{
			var n:int = parseInt(nString);
			if (isNaN(n) || isNaN(min) || isNaN(max)) {
				return false;
			}
			
			//Make sure the arguments are in the correct order
			if (min > max) {return false;}
			
			//Make sure the number is an Integer
			if (n != Math.round(n))
			{
				return false;
			}
			return (n >= min && n <= max);
		}
	}
}