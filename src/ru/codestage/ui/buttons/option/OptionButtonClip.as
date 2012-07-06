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
package ru.codestage.ui.buttons.option
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * Simple OptionButton component implementation.
	 * Assigned <code>MovieClip</code> should have two labels: "on" and "off" with different states.
	 * You could use <b>group</b> property to group some OptionButtonClips together.
	 * 
	 * @author focus | http://blog.codestage.ru
	 */
		
	public class OptionButtonClip extends Object
	{
		private var _selected:Boolean = false;
		private var _group:Vector.<OptionButtonClip>;
		private var _optionButton:MovieClip;
		
		/**
		 * Assign OptionButtonClip behaviour to the given <code>MovieClip</code>
		 * @param	optionButton Should have two labels: "on" and "off" with different states
		 */
		public function OptionButtonClip(optionButton:MovieClip)
		{
			super();
			_optionButton = optionButton;
			_init();
		}
		
		private function _init():void 
		{
			_optionButton.buttonMode = true;
			_optionButton.gotoAndStop('off');
			_optionButton.addEventListener(MouseEvent.CLICK, _onClick);
			_optionButton.addEventListener(Event.REMOVED_FROM_STAGE, _onRemoved);
		}
		
		private function _onRemoved(e:Event):void
		{
			_optionButton.removeEventListener(Event.REMOVED_FROM_STAGE, _onRemoved);
			_optionButton.removeEventListener(MouseEvent.CLICK, _onClick);
			
			if (_group)
			{
				_group.length = 0;
				_group = null;
			}
			
			_optionButton = null;
		}
		
		private function _onClick(e:MouseEvent):void
		{
			if (!_selected)
			{
				_selected = true;
			}
		}
		
		private function _unselectGroupOptionButtons():void
		{
			var len:uint = _group.length;
			var item:OptionButtonClip;
			var i:uint = 0;
			for (i; i < len; i++ )
			{
				item = _group[i];
				if (item != this)
				{
					item.selected = false;
				}
			}
		}
		
		/**
		 * Get and change the selected state
		 */
		public function get selected():Boolean { return _selected; }
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			if (value == true)
			{
				_optionButton.gotoAndStop('on');
				if (_group != null)
				{
					_unselectGroupOptionButtons();
				}
			}
			else
			{
				_optionButton.gotoAndStop('off');
			}
			
		}
		
		/**
		 * Use it to group different OptionButtonClips together
		 */
		public function get group():Vector.<OptionButtonClip> 
		{ 
			if (!_group) _group = new Vector.<OptionButtonClip>();
			return _group; 
		}
		
		public function set group(value:Vector.<OptionButtonClip>):void
		{
			_group = value;
			if (_group.indexOf(this) == -1)
			{
				_group[_group.length] = this;
			}
		}
	}
}