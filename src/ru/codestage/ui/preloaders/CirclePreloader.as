/** * @author Daniel Goldsworthy * 			daniel@sitedaniel.com * 			http://blog.sitedaniel.com * 			http://www.sitedaniel.com * @author focus | http://blog.codestage.ru * * Copyright(c) 2010 Daniel Goldsworthy * Your reuse is governed by the Creative Commons Attribution 3.0 United States License * http://creativecommons.org/licenses/by/3.0/ **/package ru.codestage.ui.preloaders{		import flash.display.DisplayObjectContainer;	import flash.display.Graphics;	import flash.display.Shape;	import flash.display.Sprite;	import flash.events.Event;	import flash.text.engine.ElementFormat;	import flash.text.engine.FontDescription;	import flash.text.engine.TextBlock;	import flash.text.engine.TextElement;	import flash.text.engine.TextLine;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;	import flash.text.TextFormatAlign;	import flash.utils.clearInterval;	import flash.utils.setTimeout;		/**	 * A configurable spinning circle LoadIndicator	 */	public class CirclePreloader extends Sprite	{		private const RADIUS		:uint = 18;		private const NUM_BARS		:uint = 16;		private const BAR_LENGTH	:uint = 8;		private const BAR_HEIGHT	:uint = 3;		private const COLOUR		:uint = 0x000000;		private const SPEED			:uint = 1;				private var _radius			:int;		private var _num_bars		:int;		private var _bar_length		:int;		private var _bar_height		:int;		private var _colour			:int;		private var _frameCount		:int;		private var _speed			:uint;		private var _showProgress	:Boolean;		private var _textProgress	:TextField;		private var _progressTextFormat:TextFormat;		private var _delayTimeout	:uint;		private var _parent			:DisplayObjectContainer;				/**		* @param $parent	 the parent holding clip		* @param $x			 the x position		* @param $y			 the y position		* @param $radius	 the radius of the clip		* @param $total_bars the number of bars		* @param $bar_length the length of each bar		* @param $bar_height the height of each bar		* @param $colour	 the colour of each bar		* @param $speed		 the number of frames to wait before moving to the next position		* @param $progressTextFormat the TextFormat to use with a progress indicator text		* @param $delay		 delay to wait before showing load indicator		*/		public function CirclePreloader(parent:DisplayObjectContainer,										x:int,										y:int,										radius:int = RADIUS,										total_bars:int = NUM_BARS,										bar_length:int = BAR_LENGTH,										bar_height:int = BAR_HEIGHT,										color:int = COLOUR,										speed:uint = SPEED,										progressTextFormat:TextFormat = null,										delay:uint = 0)		{			super();						this.x = x;			this.y = y						_parent = parent;			_radius 	= radius;			_num_bars 	= total_bars;			_bar_length = bar_length;			_bar_height	= bar_height;			_colour 	= color;			_speed 		= speed;			_progressTextFormat = progressTextFormat;						if (delay == 0)			{				init();			}			else			{				_delayTimeout = setTimeout(init, delay);			}		}				private function init():void		{			_delayTimeout = 0;			addEventListener(Event.ADDED_TO_STAGE, _onAdded);			_parent.addChild(this);						this.mouseChildren = false;			this.mouseEnabled = false;		}				/**		* Removes the clip from the parent, kills animation and cleans up.		*/		public function destroy():void		{			if (_delayTimeout)			{				clearInterval(_delayTimeout);			}			else			{				this.removeEventListener(Event.ENTER_FRAME, _onFrame);				while (this.numChildren) this.removeChildAt(0);				this.parent.removeChild(this);								if (_textProgress)				{					_textProgress = null;				}			}						if (_progressTextFormat)			{				_progressTextFormat = null;			}			_parent = null;		}				private function _onAdded(e:Event):void		{			removeEventListener(Event.ADDED_TO_STAGE, _onAdded);						for (var i:int = 0; i < _num_bars; i++)			{				var bar:Shape = getBar();				bar.rotation = 360 / _num_bars * i;				bar.alpha = 1 / _num_bars * i;				this.addChild(bar);			}						if (_progressTextFormat)			{				_textProgress = new TextField();				_progressTextFormat.size = _radius - 8 - (_bar_length - 8);				_textProgress.autoSize = TextFieldAutoSize.CENTER;				_textProgress.defaultTextFormat = _progressTextFormat;				_textProgress.multiline = false;				_textProgress.embedFonts = true;				_textProgress.text = "0";				_textProgress.selectable = false;				_textProgress.x = -_textProgress.width/2;				_textProgress.y = -_textProgress.textHeight/2;				addChild(_textProgress);			}			_frameCount = 0;						addEventListener(Event.ENTER_FRAME, _onFrame, false, 0, true);		}				/**		 * Use it to set the current loading progress. Works only if <b>$progressTextFormat</b> was passed to the constructor.		 * @param	progressPercent		 */		public function setProgress(progressPercent:uint):void		{			if (_textProgress)			{				_textProgress.text = String(progressPercent);			}		}				/**		 * Removes progress indicator. Works only if <b>$progressTextFormat</b> was passed to the constructor.		 */		public function hideProgress():void		{			removeChild(_textProgress);		}				private function _onFrame(e:Event):void		{			if (++_frameCount % _speed == 0)			{				this.rotation += 360 / _num_bars;			}		}				private function getBar():Shape		{			var bar:Shape = new Shape();			var g:Graphics = bar.graphics;			g.beginFill(_colour);			g.drawRect(_radius - _bar_length, -_bar_height/2, _bar_length, _bar_height);			g.endFill();			return bar;		}				/**		 * Get and change the spinning speed.		 */		public function get speed():uint 		{			return _speed;		}				public function set speed(value:uint):void 		{			_speed = value;		}	}}