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
	 * @author jloa | http://chargedweb.com/
	 */
	public class VectorUtil 
	{
		
		/**
		* Converts vector to an array
		* @param	vector	vector to be converted
		* @return	Array		converted array
		*/
		public static function vectorToArray(vector:*):Array
		{
			var n:int = vector.length;
			var a:Array = [];
			for(var i:int = 0; i < n; i++) a[i] = vector[i];
			return a;
		}
		/**
		 * Converts vector to an array and sorts it by a certain fieldName, options.
		 * For more info see Array.sortOn
		 * @param	vector			the source vector
		 * @param	fieldName	a string that identifies a field to be used as the sort value
		 * @param	options		one or more numbers or names of defined constants
		 * @see Array#sortOn()
		 * @example <listing version="3.0">
		 * var sorted:Vector.&lt;Object&gt; = Vector.&lt;Object&gt;(VectorUtil.sortOn(unsorted, "id", Array.NUMERIC));</listing>
		 */
		public static function sortOn(vector:*, fieldName:Object, options:Object  = null):Array
		{
			return vectorToArray(vector).sortOn(fieldName, options);
		}
		
	}

}