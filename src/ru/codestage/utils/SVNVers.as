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
	import flash.utils.ByteArray;
	
	/**
	 * Simple class to get the revision number from svn. It's based on the EMBED tag now, should be rewritten using loader(s).
	 * @author focus | http://blog.codestage.ru
	 */
	public class SVNVers extends Object
	{
		private static const VERSION_PATTERN:RegExp = /dir\xa(\d+)\xa/;
	 
	//	[Embed(source = "../../../.svn/entries", mimeType = "application/octet-stream")]
		
		private static var _entriesByteArray:Class;
		
		public static function get version():String 
		{
			var entries:String = readEntries(20);
			var matches:Array = entries.match(VERSION_PATTERN);
	 
			if (matches) 
			{
				return matches[1];
			}
	 
			return null;
		}
	 
		private static function readEntries(length:uint):String 
		{
			return (new _entriesByteArray() as ByteArray).readUTFBytes(length);
		}
		
	}

}