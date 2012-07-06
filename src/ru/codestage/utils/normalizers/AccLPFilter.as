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
package ru.codestage.utils.normalizers
{
	import ru.codestage.types.TripleVar;
	import ru.codestage.utils.NumUtil;
	
	/**
	 * Accelometer Low Pass filter. Use it to smooth the accelometer raw vaues.
	 * @author focus | http://blog.codestage.ru
	 * @example
	 * <listing version="3.0">
	 * package
	 * {
	 * 		import flash.display.MovieClip;
	 * 		import flash.events.AccelerometerEvent;
	 * 		import flash.events.TimerEvent;
	 * 		import flash.sensors.Accelerometer;
	 * 		import flash.utils.Timer;
	 * 		import ru.codestage.types.TripleVar;
	 * 
	 * 		public class AccExample extends MovieClip
	 * 		{
	 * 			private const TIMER_UPDATE_INTERVAL:Number = 35;
	 * 			private const ACCELOMETER_UPDATE_INTERVAL:uint = 50;
	 * 			private const ACCELEROMETER_CUT_OFF_FREQ:Number = 95;
	 * 			private const ACCELEROMETER_FREQ:Number = 100;
	 * 	
	 * 			private var accFilter:AccLPFilter;
	 * 			private var updateTimer:Timer;
	 * 			private var accelometer:Accelerometer;
	 * 	
	 * 			public function AccExample() 
	 * 			{
	 * 				super();
	 * 				_init();
	 * 			}
	 * 	
	 * 			private function _init():void 
	 * 			{
	 * 				if (Accelerometer.isSupported)
	 * 				{
	 * 					accFilter = new AccLPFilter();
	 * 					accFilter.setParams(ACCELEROMETER_FREQ, ACCELEROMETER_CUT_OFF_FREQ);
	 * 					
	 * 					accelometer = new Accelerometer();
	 * 					accelometer.addEventListener(AccelerometerEvent.UPDATE, _onAccUpdate);
	 * 					accelometer.setRequestedUpdateInterval(ACCELOMETER_UPDATE_INTERVAL);
	 * 					
	 * 					updateTimer = new Timer(TIMER_UPDATE_INTERVAL);
	 * 					updateTimer.addEventListener(TimerEvent.TIMER, _onUpdateTimerTimer);
	 * 					updateTimer.start();
	 * 				}
	 * 			}
	 * 
	 * 			private function _onUpdateTimerTimer(e:TimerEvent):void
	 * 			{
	 * 				var acc:TripleVar = accFilter.getValue();
	 * 				trace(acc.x);
	 * 				trace(acc.y);
	 * 				trace(acc.z);
	 * 				acc = null;
	 * 			}
	 * 			
	 * 			private function _onAccUpdate(e:AccelerometerEvent):void 
	 * 			{
	 * 				accFilter.addValue(e.accelerationX, e.accelerationY, e.accelerationZ);
	 * 			}
	 * 		}
	 * }
	 * </listing>
	 */
	public final class AccLPFilter extends Object 
	{
		private const _accelerometerMinStep:Number = 0.01;
		private const _accelerometerNoiseAttenuation:Number = 3.0;
		
		private var _filterConstant:Number = 1.0;
		private var _value:TripleVar = new TripleVar();
		
		/**
		 * Adaptive filtering makes it more smooth and calculates more relevant filter values. Non adaptive filtering based on the constant
		 */
		public var adaptive:Boolean = true;
		
		public function AccLPFilter() 
		{
			super();
		}
		
		/**
		 * Reset filter values
		 */
		public function reset():void
		{
			_value.z = 0;
			_value.x = 0;
			_value.y = 0;
		}
		
		/**
		 * Set the initial filter prarmeters. Could be called at any time to change the initial parameters
		 * @param	sample_rate
		 * @param	cutoff_frequency
		 */
		public function setParams(sample_rate:Number, cutoff_frequency:Number):void
		{
			var dt:Number = 1.0 / sample_rate;
			var rc:Number = 1.0 / cutoff_frequency;
			
			_filterConstant = dt / (dt + rc);
		}
		
		/**
		 * Add raw accelometer values to filter
		 * @param	x
		 * @param	y
		 * @param	z
		 */
		public function addValue(x:Number,y:Number,z:Number):void
		{
			var alpha:Number = _filterConstant;
			
			if (adaptive)
			{
				var d:Number = _clamp(NumUtil.fastAbs(_norm(_value.x, _value.y, _value.z) - _norm(x, y, z)) / _accelerometerMinStep - 1.0, 0.0, 1.0);
				alpha = (1.0 - d) * _filterConstant / _accelerometerNoiseAttenuation + d * _filterConstant;
			}
			
			_value.x = x * alpha + _value.x * (1.0 - alpha);
			_value.y = y * alpha + _value.y * (1.0 - alpha);
			_value.z = z * alpha + _value.z * (1.0 - alpha);
		}
		
		/**
		 * Get filtered values
		 * @return filtered values in the x,y,z properties of the <code>TripleVar</code> instance
		 */
		public function getValue():TripleVar
		{ 
			return _value; 
		}
		
		private function _norm(x:Number, y:Number, z:Number):Number
		{
			return Math.sqrt(x * x + y * y + z * z);
		}
		
		private function _clamp(v:Number, min:Number, max:Number):Number
		{
			if(v > max)
				return max;
			else if(v < min)
				return min;
			else
				return v;
		}
	}
}