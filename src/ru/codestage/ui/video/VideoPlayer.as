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
package ru.codestage.ui.video
{
	import com.greensock.easing.Cubic;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * Simple video player component.
	 * 
	 * @author focus | http://blog.codestage.ru
	 */
	public class VideoPlayer extends Sprite
	{
		private var _videoURL:String = "";
        private var _connection:NetConnection = null;
        private var _stream:NetStream = null;
		private var _video:Video = null;
		
		private var _width:Number = 800;
		private var _height:Number = 600;
		
		private var _duration:Number = 0;
		private var _playing:Boolean = false;
		private var _hasMetadata:Boolean = false;
		
		private var _volume:Number = 1;
		
		private var _traceFunction:Function = null;
		private var _preloader:DisplayObject = null;
		private var _enterFrameFunction:Function = null;
		
		/**
		 * Video player constructor. You could pass settings here
		 * @param	initialSettings
		 */
		public function VideoPlayer(initialSettings:Object = null)
		{
			if (initialSettings)
			{
				if (initialSettings.traceFunction != null)
				{
					_traceFunction = initialSettings.traceFunction;
				}
				
				if (initialSettings.width != null)
				{
					_width = initialSettings.width;
				}
				
				if (initialSettings.height != null)
				{
					_height = initialSettings.height;
				}
				
				if (initialSettings.videoURL != null)
				{
					if (_traceFunction != null) _traceFunction('VideoPlayer -> videoURL:', initialSettings.videoURL);
					_videoURL = initialSettings.videoURL;
					_startPlaying();
				}
				else
				{
					if (_traceFunction != null) _traceFunction('VideoPlayer -> You have to set videoURL setting');
				}
				
				if (initialSettings.preloader != null)
				{
					_preloader = initialSettings.preloader;
				}
				
				if (initialSettings.enterFrameFunction  != null)
				{
					_enterFrameFunction = initialSettings.enterFrameFunction;
				}
			}
        }
		
		private function _startPlaying():void
		{
			_playing = true;
			_hasMetadata = false;
            _connection = new NetConnection();
            _connection.addEventListener(NetStatusEvent.NET_STATUS, _onNetStatus);
            _connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
            _connection.connect(null);
		}
		
		private function _onSecurityError(event:SecurityErrorEvent):void
		{
            if (_traceFunction != null) _traceFunction("VideoPlayer -> securityErrorHandler: " + event);
        }
		
		private function _onNetStatus(event:NetStatusEvent):void
		{
            if (_traceFunction != null) _traceFunction('VideoPlayer -> netStatusHandler -> ' + event.info.code);
			switch (event.info.code)
			{
                case "NetConnection.Connect.Success":
                    _connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    if (_traceFunction != null) _traceFunction("Stream not found: " + _videoURL);
                    break;
				case "NetStream.Play.Stop":
					if (_traceFunction != null) _traceFunction('Stopped');
					_stream.seek(0);
					_stream.pause();
					_playing = false;
					if (_enterFrameFunction != null)
					{
						_enterFrameFunction(null);
					}
					//video.alpha = 0;
					break;
            }
        }
		
		private function _connectStream():void
		{
			_hasMetadata = false;
            _stream = new NetStream(_connection);
			_stream.addEventListener(NetStatusEvent.NET_STATUS, _onNetStatus);
			
			var client:Object = new Object();
			client.onMetaData = _onMetaData;
			client.onCuePoint = _onCuePoint;
			_stream.client = client;
			_video = new Video();
            _video.attachNetStream(_stream);
			_stream.play(_videoURL);
			addChild(_video);
			_video.visible = false;
			_video.alpha = 0;
			pause();
        }
		
        private function _onMetaData(info:Object):void
		{
			if (_traceFunction != null) _traceFunction("VideoPlayer -> onMetaData");
			//fnTrace("metadata:",info);
			//fnTrace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
				
			if (_hasMetadata == false)
			{
				_hasMetadata = true;
				
				if (_enterFrameFunction != null)
				{
					this.addEventListener(Event.ENTER_FRAME, _enterFrameFunction);
				}
				
				_duration = info.duration;
				
				var obj:Object = _resize(info.width, info.height, _width, _height)
				_video.width = obj.width;
				_video.height = obj.height;
				
				_video.x = (_width - obj.width) * 0.5;
				_video.y = (_height - obj.height) * 0.5;
				
				_video.smoothing = true;
				_video.visible = true;

				pause();
				seek(0);
				_video.alpha = 0;
				play();
				if (_preloader.visible)
				{
					_preloader.visible = false;
				}
			}
		}
		
		private function _onCuePoint(info:Object):void
		{
			if (_traceFunction != null) _traceFunction("VideoPlayer -> cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
		}


		/**
		 * Close video player and clear everything
		 */
		public function closePlayer():void
		{
			_connection.removeEventListener(NetStatusEvent.NET_STATUS, _onNetStatus);
            _connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _onSecurityError);
			_stream.removeEventListener(NetStatusEvent.NET_STATUS, _onNetStatus);
			_stream.receiveAudio(false);
			_stream.receiveVideo(false);
			_stream.close();
			removeChild(_video);
			_connection.close();
			_connection = null;
			_video = null;
			_stream = null;
			
			if (_enterFrameFunction != null)
			{
				this.removeEventListener(Event.ENTER_FRAME, _enterFrameFunction);
			}
		}

		
		/**
		 * Get bytes loading progress in values from 0 to 1
		 * @return bytesLoaded/bytesTotal
		 */
		public function getLoadingProgress():Number
		{
			if (_stream == null) return 0;
			return (_stream.bytesLoaded / _stream.bytesTotal);
		}
		
		/**
		 * Get elapsed progress in values from 0 to 1. Always returns 1 if video is not playing and 0 if there is noe loaded video
		 * @return time/duration
		 */
		public function getPlayingProgress():Number
		{
			if (_duration == 0) return 0;
			if (_playing == false) return 1;
			return (_stream.time / _duration);
		}
		
		/**
		 * Start or resume video playing
		 * @param	resume Set to true if you wish to resume playing, set to false (by default) to play from beginning
		 */
		public function play(resume:Boolean = false):void
		{
			if (_traceFunction != null) _traceFunction('VideoPlayer -> play');
			if (!resume)
			{
				_video.alpha = 0;
				TweenLite.to(_video, 1.5, { alpha:1, ease:Cubic.easeOut } );
			}
			_playing = true;
			_stream.resume();
		}
		
		/**
		 * Pause current video
		 */
		public function pause():void
		{
			if (_traceFunction != null) _traceFunction('VideoPlayer -> pause');
			_stream.pause();
		}
		
		/**
		 * Jump to the specified percent of the stream
		 * @param	percent Where to jump
		 */
		public function seek(percent:Number):void
		{
			_stream.seek(percent * _duration);
			_playing = true;
			_video.alpha = 1;
		}
		
		private function _resize(w1:Number, h1:Number, w2:Number, h2:Number):Object
		{
			var w:Number;
			var h:Number;
			var k:Number;
			
			if (w1 == w2 && h1 <= h2) return {width:w1, height:h1};
			if (h1 == h2 && w1 <= w2) return {width:w1, height:h1};
			
			w = w2;
			k = w2 / w1;
			h = k * h1;
			
			if (h > h2)
			{
				h = h2;
				k = h2 / h1;
				w = k * w1;
			}
			
			return {width:w, height:h};
		}
		
		/**
		 * Get the playing state
		 */
		public function get isPlaying():Boolean 
		{ 
			return _playing; 
		}
		
		/**
		 * Get the video duration
		 */
		public function get duration():Number 
		{ 
			return _duration; 
		}
		
		/**
		 * Get and change the video sound volume ranging from 0 (silent) to 1 (full volume)
		 */
		public function get volume():Number 
		{
			return _volume;
		}
		
		public function set volume(value:Number):void 
		{
			var sndTrans:SoundTransform = new SoundTransform();
			sndTrans.volume = value;
			_stream.soundTransform = sndTrans;
			_volume = value;
		}
		
	}
	
}


