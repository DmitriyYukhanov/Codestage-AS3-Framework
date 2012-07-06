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
package ru.codestage.ui.scroller
{
	import com.greensock.easing.Quad;
	import com.greensock.OverwriteManager;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * GreensockScroller's exclusive settings holder object
	 * @see GreensockScroller
	 * @author focus | http://blog.codestage.ru
	 */
	public class GreensockScrollerSettings extends Object
	{
		/**
		 * For mouse up handling, etc
		 */
		public var eventsHandler:InteractiveObject = null;
		
		/**
		 * Content to scroll (should be at 0,0)
		 */
		public var scrollingContent:InteractiveObject = null;
		
		/**
		 * Displayable area of the content(MovieClip, TextField or Number)
		 */
		public var mask:Object = null;
		
		/**
		 * Slider graphics.
		 * @see #sliderArea
		 * @see #sliderAreaTimeline
		 */
		public var slider:Sprite = null;
		
		/**
		 * Draggable area for slider (DisplayObject or Number). <code>GreensockScrollerSettings.slider</code> <code>height</code> or <code>width</code> will be substracted automatically
		 * @see #slider
		 */
		public var sliderArea:Object = null;
		
		/**
		 * MovieClip to play while user drags a slider. Useful for complex slider animation.
		 * @see #slider
		 * @see #sliderTimelineArea
		 */
		public var sliderTimeline:MovieClip = null;
		
		/**
		 * Area for mouse tracking while user "drags" a slider.
		 * @see #slider
		 * @see #sliderTimeline
		 */
		public var sliderTimelineArea:DisplayObject = null;
		
		/**
		 * Up button arrow graphics
		 * @see #arrowDown
		 * @see #arrowsOverAsDown
		 * @see #arrowsHideUnused
		 * @see #arrowsScrollSpeed
		 */
		public var arrowUp:InteractiveObject = null;
		
		/**
		 * Down button arrow graphics
		 * @see #arrowUp
		 * @see #arrowsOverAsDown
		 * @see #arrowsHideUnused
		 * @see #arrowsScrollSpeed
		 */
		public var arrowDown:InteractiveObject = null;
		
		/**
		 * 'Arrow' buttons will react to over\out instead if down\up
		 * @see #arrowUp
		 * @see #arrowDown
		 */
		public var arrowsOverAsDown:Boolean = false
		
		/**
		 * Turn off 'arrow' button(s) behaviour if it(they) can't iteract
		 * @see #arrowsHideUnusedDuration
		 * @see GreensockScroller#DISABLE_TYPE_NONE
		 * @see GreensockScroller#DISABLE_TYPE_VISIBLE
		 * @see GreensockScroller#DISABLE_TYPE_GRAY
		 * @default GreensockScroller.DISABLE_TYPE_NONE
		 */
		public var arrowsHideUnused:uint = GreensockScroller.DISABLE_TYPE_NONE;
		
		/**
		 * Duration for hiding unused 'arrows' (in seconds). Set 0 to hide instantly
		 * @see #arrowsHideUnused
		 * @see #arrowUp
		 * @see #arrowDown
		 */
		public var arrowsHideUnusedDuration:Number = 0;
	   
	   /**
		* Arrow scrolling speed
		* @see #arrowUp
		* @see #arrowDown
		*/
	   public var arrowsScrollSpeed:Number = 1;
		
		/**
		 * Turn off whole scroller behaviour, used if whole scroller can't iteract
		 * @see #completeHideUnusedDuration
		 * @see GreensockScroller#DISABLE_TYPE_NONE
		 * @see GreensockScroller#DISABLE_TYPE_VISIBLE
		 * @see GreensockScroller#DISABLE_TYPE_GRAY
		 * @default GreensockScroller.DISABLE_TYPE_NONE
		 */
		public var completeHideUnused:uint = GreensockScroller.DISABLE_TYPE_NONE;
		
		/**
		 * Duration for all scroller elements hiding (arrows, slider, slider area). Set 0 to hide instantly
		 * @see #completeHideUnused
		 */
		public var completeHideUnusedDuration:Number = 0;
		
		/**
		 * Not for TextField content. Owner for MouseWheel event
		 * @see #scrollingContent
		 * @see #wheelSpeed
		 * @default scrollingContent
		 */
		public var wheelOwner:InteractiveObject = null;
		
		/**
		 * Mouse wheel speed multiplier (MouseWheel event delta multiplier)
		 * @see #wheelOwner
		 */
		public var wheelSpeed:Number = 1;
		
		/**
		 * Step size in pixels or in lines, used for paging\stepping. Set 0 to disable paging\stepping
		 */
		public var step:Number = 0;
		
		/**
		 * Set to true for line scrolling of the TextField
		 */
		public var textFieldMode:Boolean = false;
		
		/**
		 * Easing method. Set to <code>null</code> to disable easing
		 * @see #easingEnabled
		 * @see #easeDuration
		 * @see #overwriteEasing
		 * @see http://www.greensock.com/as/docs/tween/com/greensock/easing/package-detail.html
		 */
		public var easing:Function = Quad.easeOut;
		
		/**
		 * Easing duration (sec)
		 * @see #easing
		 * @see #easingEnabled
		 * @see #easeDuration
		 * @see #overwriteEasing
		 */
		public var easeDuration:Number = 0.5;
		
		/**
		 * Easing overwrite modes
		 * @see #easing
		 * @see http://www.greensock.com/as/docs/tween/com/greensock/OverwriteManager.html
		 */
		public var overwriteEasing:int = OverwriteManager.AUTO;
		
		/**
		 * Scrollbar orientation
		 * @see #realHorizontal
		 */
		public var horizontal:Boolean = false;
		
		/**
		 * If true, slider will move along x-axis instead of y
		 * @see #horizontal
		 */
		public var horizontalSlider:Boolean = false;
		
		public function GreensockScrollerSettings() {}
	}
}
