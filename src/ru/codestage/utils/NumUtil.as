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
	
	/**
	 * Diffirent handy numbers manipulation snippets and functions.
	 * @author focus | http://blog.codestage.ru
	 */
	public class NumUtil
	{
		
		/**
		* Generates boolean regarding to the chance
		* @author Oliver-Bogdan Iancu
		* @param chance Chance to generate true in percents, "for 70% chances of happening, pass 0.7"
		* @return Generated boolean from the chance
		*/
		public static function generateChanceBoolean(chance:Number):Boolean
		{
			var randomNumber:Number = Math.random();
			var result:Boolean=false;
			if (chance > randomNumber)
			{
				result = true;
			}
			else
			{
				result = false;
			}
			return result;
		}
		
		/**
		* "Grid-like" number round function.
		* As example, you can pass a mouse X coordinate as first argument and grid stem as a second one,
		* function will return value, nearest to the "grid column"
		* @author focus | http://blog.codestage.ru
		* @param value   Number to round
		* @param base    Round base (e.g. grid step)
		* @return Value, rounded to the nearest base
		*/
		public static function roundTo(value:Number, base:Number):Number
		{
			return Math.floor((value + base / 2) / base) * base;
		}
		
		/**
		* Function to get a random number from the specific range
		* @author focus | http://blog.codestage.ru
		* @param max   Max range value
		* @param min   Min range value, zero by default
		* @return Random number in the range min, max
		*/
		public static function randomRange(max:Number, min:Number = 0):Number
		{
			return Math.random() * (max - min) + min;
		}
		
		/**
		 * Fastest <code>Math.abs();</code> implementation.
		 * Warning: only for integer values! Use <code>NumUtil.fastAbs();</code> for <code>Number</code> variables, it's slower though.
		 * @param	value To get absolute value from
		 * @return Absolute integer value
		 * @see #fastAbs
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Math.html#abs()
		 */
		public static function fastIntAbs(value:int):int
		{
			return (value ^ (value >> 31)) - (value >> 31);
		}
		
		/**
		 * Fast <code>Math.abs();</code> implementation. For integer numbers, use <code>NumUtil.fastIntAbs();</code>
		 * @param	value	Number to get absolute number from
		 * @return Absolute number
		 * @see #fastIntAbs
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Math.html#abs()
		 */
		public static function fastAbs(value:Number):Number
		{
			return value < 0 ? -value : value;
		}
		
		/**
		 * Fast <code>Math.round();</code> implementation.
		 * @param	value	Number to round
		 * @return Rounded number
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Math.html#round()
		 */
		public static function fastRound(value:Number):int
		{
			return int(value + 0.5);
		}
		
		/**
		 * Fast <code>Math.floor();</code> implementation.
		 * @param	value	Number to floor
		 * @return Floored number
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Math.html#floor()
		 */
		public static function fastFloor(value:Number):int
		{
			var ni:int = value;
			return (value < 0 && value != ni) ? ni - 1 : ni;
		}
		
		/**
		 * Fast <code>Math.ceil();</code> implementation.
		 * @param	value	Number to ceil
		 * @return Ceiled number
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Math.html#ceil()
		 */
		public static function fastCeil(value:Number):int
		{
			var ni:int = value;
			return (value >= 0 && value != ni) ? ni + 1 : ni;
		}
		
		/**
		 * Converts degrees to radians
		 * 
		 * @param degrees The number of degrees
		 * @return Returns the number of radians
		 */
		public static function degreesToRadians(degrees:Number):Number 
		{
			return degrees * (Math.PI / 180);
		}
		
		/**
		 * Converts radians to degrees
		 * 
		 * @param radians: The number of radians
		 * @return Returns the number of degrees
		 */
		public static function radiansToDegrees(radians:Number):Number 
		{
			return radians * (180 / Math.PI);
		}
		
		/**
		 * Function to check if the given value is an even number
		 * @author focus | http://blog.codestage.ru
		 * @param value   Value to check
		 * @return True if value is even number, otherwise - false
		 */
		public static function isEven(value:Number):Boolean
		{
			return ((value & 1) == 0);
		}
		
		/**
		 * Function to check how many given powers has given number
		 * @author focus | http://blog.codestage.ru
		 * @param number   Number to check for powers
		 * @param powerValue   Power to check for
		 * @return -1 if number or powerValue is not valid (e.g. 0 or NaN), 0 if number is not a power of powerValue, > 0  - amount of powerValue powers in number
		 */
		public static function powerOf(number:uint, powerValue:uint):int
		{
			var powersCount:int = 0;
			
			if (!number || !powerValue || number!=number || powerValue!=powerValue)
			{
				powersCount = -1
			}
			else
			{
				while (number % powerValue == 0)
				{
					number /= powerValue;
					powersCount++;
				}
				
				if (number != 1)
				{
					powersCount = 0;
				}
			}
			
			return powersCount;
		}
		
		
		
		/**
		 * Fast <code>Math.max();</code> version.
		 * @param	val1
		 * @param	val2
		 * @return 	Maximum value
		 * @see 	#min
		 * @see 	http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Math.html#max()
		 */
        public static function max(val1:Number, val2:Number): Number
        {
            if (val1 != val1 || val2 != val2)
            {
                return NaN;
            }
            return val1 > val2 ? val1 : val2;
        }
		
		/**
		 * Fast <code>Math.min();</code> version.
		 * @param	val1
		 * @param	val2
		 * @return	Minimum value
		 * @see 	#max
		 * @see		http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Math.html#min()
		 */
        public static function min(val1:Number, val2:Number): Number
        {
            if (val1 != val1 || val2 != val2)
            {
                return NaN;
            }
            return val1 < val2 ? val1 : val2;
        }
		
		/**
		 * Fast <code>Math.ceil();</code> version.
		 * @param	value <code>Number</code> to ceil
		 * @return Ceiled <code>Number</code>
		 * @see http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/Math.html#ceil()
		 */
        public static function ceil(value:Number): Number
        {
            var valueInt:int = value;
            if (value == valueInt)
            {
                return value;
            }
            else if (value >= 0)
            {
                valueInt = value + 1;
                return valueInt;
            }
            else
            {
                return valueInt;
            }
        }
	}
	
}