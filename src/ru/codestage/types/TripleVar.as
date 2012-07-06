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
package ru.codestage.types 
{
	import ru.codestage.utils.NumUtil;
	/**
	 * Simple type to store three variables of the Number type simultaneously.
	 * Could be useful as lightweight Vector3D replacement.
	 * @author focus | http://blog.codestage.ru
	 */
	public class TripleVar extends Object 
	{
		public var x:Number = 0;
		public var y:Number = 0;
		public var z:Number = 0;
		
		public function TripleVar(x:Number = 0, y:Number = 0, z:Number = 0) 
		{
			this.x = x;
			this.y = y;
			this.z = z;
			super();
		}
		
		/**
		 * Allows to get absolute difference between x,y,z
		 * @param	compareTo - TripleVar to compare with
		 * @return  absolute difference between x,y,z
		 */
		public function getCommonDifference(compareTo:TripleVar):Number
		{
			var difference:Number;
			difference = NumUtil.fastAbs(compareTo.x - x);
			difference += NumUtil.fastAbs(compareTo.y - y);
			difference += NumUtil.fastAbs(compareTo.z - z);
			return difference;
		}
		
		/**
		 * Use it to copy all current x,y,z values to the new TripleVar
		 * @param	copy target TripleVar
		 */
		public function copyTo(copy:TripleVar):void
		{
			copy.x = x;
			copy.y = y;
			copy.z = z;
		}
		
		/**
		 * Use it to create a new TripleVar instance with current x,y,z values
		 * @return new TripleVar with current x,y,z values
		 */
		public function clone():TripleVar
		{
			return new TripleVar(x, y, z);
		}
	}

}