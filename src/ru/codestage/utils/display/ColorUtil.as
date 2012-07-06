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
package ru.codestage.utils.display
{
	import com.gskinner.geom.ColorMatrix;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * Provides utility functions for dealing with color.
	 * @author focus | http://blog.codestage.ru
	 */
	public final class ColorUtil
	{
		/**
		 * Allows to set main color ajusters to the target <code>DisplayObject</code>
		 *
		 * @param target		Any <code>DisplayObject</code> to apply color ajusters
		 * @param brightness	Use vaues from -100 to 100
		 * @param contrast		Use vaues from -100 to 100
		 * @param saturation	Use vaues from -100 to 100
		 * @param hue			Use vaues from -100 to 100
		 */
		public static function setBCSH(target:DisplayObject, brightness:Number, contrast:Number, saturation:Number, hue:Number):void
		{
			var cm:ColorMatrix = new ColorMatrix();
			cm.adjustColor(brightness, contrast, saturation, hue);
			
			var filterExists:Boolean = false;
			var filt:Array = target.filters;
			var n:uint = filt.length;
			var i:uint = 0;
			
			for (i; i < n; i++)
			{
				if (filt[i] is ColorMatrixFilter)
				{
					filterExists = true;
					filt[i] = new ColorMatrixFilter(cm);
					break;
				}
			}
			
			if (!filterExists)
			{
				filt.push(new ColorMatrixFilter(cm));
			}
			
			target.filters = filt;
		}
		
		/**
		 * Tints target <code>DisplayObject</code>
		 *
		 * @param target	Any <code>DisplayObject</code> to apply color tint
		 * @param tint		Value from 0 to 100
		 * @param color		RGB color
		 */
		public static function setTint(target:DisplayObject, tint:Number, color:uint):void
		{
			var color:uint = color;
			var mul:Number = tint / 100;
			
			var ctMul:Number = (1 - mul);
			var ctRedOff:Number = Math.round(mul * ((color >> 16) & 0xFF));
			var ctGreenOff:Number = Math.round(mul * ((color >> 8) & 0xFF));
			var ctBlueOff:Number = Math.round(mul * (color & 0xFF));
			
			var ct:ColorTransform = new ColorTransform(ctMul,ctMul,ctMul,1,ctRedOff,ctGreenOff,ctBlueOff,0);
			target.transform.colorTransform = ct;
		}
		
		/**
		 * Changes text color of each <code>TextField</code> in the given vector through the <code>TextFormat</code>
		 *
		 * @param textFields	<code>Vector</code> of the TextField instances to apply new text color
		 * @param color			RGB color
		 */
		public static function setTextsColor(textFields:Vector.<TextField>, color:uint = 0xB1FF00):void
		{
			var len:uint = textFields.length;
			var i:uint = 0;
			for (i; i < len; i++)
			{
				var tf:TextFormat = textFields[i].getTextFormat();
				tf.color = color;
				textFields[i].setTextFormat(tf);
				textFields[i].defaultTextFormat = tf;
			}
		}
		
		/**
		 * Converts a series of individual RGB(A) values to a 32-bit ARGB color value
		 *
		 * @param r	A uint from 0 to 255 representing the red color value
		 * @param g	A uint from 0 to 255 representing the green color value
		 * @param b	A uint from 0 to 255 representing the blue color value
		 * @param a	A uint from 0 to 255 representing the alpha value. Default is 255
		 *
		 * @return A hexidecimal color as a 32-bit ARGB color value
		 *
		 * @example
		 * <listing version="3.0">
		 * var hexColor: String = ColorUtil.getColor(128, 255, 0, 255);
		 * trace(hexColor); // traces 80FF00FF </listing>
		 */
		public static function getColor(r: uint, g: uint, b: uint, a: uint = 255): uint
		{
			return (a << 24) | (r << 16) | (g << 8) | b;
		}
		
		/**
		 * Converts a 32-bit ARGB color value into an ARGB object
		 *
		 * @param color	The 32-bit ARGB color value
		 *
		 * @return An object with the properties a, r, g, and b defined
		 *
		 * @example <listing version="3.0">
		 * var myRGB: Object = ColorUtil.getARGB(0xCCFF00FF);
		 * trace("Alpha = " + myRGB.a);
		 * trace("Red = " + myRGB.r);
		 * trace("Green = " + myRGB.g);
		 * trace("Blue = " + myRGB.b); </listing>
		 */
		public static function getARGB(color : uint): Object
		{
			var c: Object = {};
			c.a = color >> 24 & 0xFF;
			c.r = color >> 16 & 0xFF;
			c.g = color >> 8 & 0xFF;
			c.b = color & 0xFF;
			return c;
		}
		
		/**
		 * Converts a 24-bit RGB color value into an RGB object
		 *
		 * @param color	The 24-bit RGB color value
		 *
		 * @return An object with the properties r, g, and b defined
		 *
		 * @example	<listing version="3.0">
		 * var myRGB: Object = ColorUtil.getRGB(0xFF00FF);
		 * trace("Red = " + myRGB.r);
		 * trace("Green = " + myRGB.g);
		 * trace("Blue = " + myRGB.b);</listing>
		 */
		public static function getRGB(color : uint): Object
		{
			var c : Object = {};
			c.r = color >> 16 & 0xFF;
			c.g = color >> 8 & 0xFF;
			c.b = color & 0xFF;
			return c;
		}
		
		/**
		 * Converts a 32-bit ARGB color value into a hexidecimal <code>String</code> representation
		 *
		 * @param a	A uint from 0 to 255 representing the alpha value
		 * @param r	A uint from 0 to 255 representing the red color value
		 * @param g	A uint from 0 to 255 representing the green color value
		 * @param b	A uint from 0 to 255 representing the blue color value
		 *
		 * @return A hexidecimal color as a <code>String</code>
		 *
		 * @example	<listing version="3.0">
		 * var hexColor: String = ColorUtil.getHexStringFromARGB(128, 255, 0, 255);
		 * trace(hexColor); // Traces 80FF00FF </listing>
		 */
		public static function getHexStringFromARGB(a: uint, r: uint, g: uint, b: uint): String
		{
			var aa: String = a.toString(16);
			var rr: String = r.toString(16);
			var gg: String = g.toString(16);
			var bb: String = b.toString(16);
			aa = (aa.length == 1) ? '0' + aa : aa;
			rr = (rr.length == 1) ? '0' + rr : rr;
			gg = (gg.length == 1) ? '0' + gg : gg;
			bb = (bb.length == 1) ? '0' + bb : bb;
			return (aa + rr + gg + bb).toUpperCase();
		}
		
		/**
		 * Converts an RGB color value into a hexidecimal <code>String</code> representation
		 *
		 * @param r	A uint from 0 to 255 representing the red color value
		 * @param g	A uint from 0 to 255 representing the green color value
		 * @param b	A uint from 0 to 255 representing the blue color value
		 *
		 * @return A hexidecimal color as a <code>String</code>
		 *
		 * @example	<listing version="3.0">
		 * var hexColor: String = ColorUtil.getHexStringFromRGB(255, 0, 255);
		 * trace(hexColor); // Traces FF00FF </listing>
		 */
		public static function getHexStringFromRGB(r: uint, g: uint, b: uint): String
		{
			var rr: String = r.toString(16);
			var gg: String = g.toString(16);
			var bb: String = b.toString(16);
			rr = (rr.length == 1) ? '0' + rr : rr;
			gg = (gg.length == 1) ? '0' + gg : gg;
			bb = (bb.length == 1) ? '0' + bb : bb;
			return (rr + gg + bb).toUpperCase();
		}
		
		/**
		 * Inverts a color
		 *
		 * @param color	A RGB color to invert
		 *
		 * @return An inverted color
		 */
		public static function invert(color:uint): uint
		{
			return 16777215 - color;
		}
		
	}

}