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
	/**
	 * A queue of any items with several methods to add and remove items.
	 * Queue stores items in the stack-style, e.g. if you push 1,2,3 - poping wil return 3,2,1.
	 * 
	 * @author focus | http://blog.codestage.ru
	 */
	public class Queue extends Object 
	{
		private var _queue:Vector.<Object> = new Vector.<Object>();
		
		public function Queue() 
		{
			super();
		}
		
		/**
		 * Returns current queue length
		 */
		public function get length():Number
		{
			return _queue.length;
		}
		
		/**
		 * Puts single item on top of the queue stack
		 * @param	item Item to put to the queue
		 */
		public function pushSingle(item:Object):void 
		{
			_queue[_queue.length] = item;
		}
		
		/**
		 * Puts multiple items on top of the queue stack
		 * @param	...args Items to add to the queue
		 */
		public function pushMultiple(...args):void 
		{
			var len:uint = args.length;
			var i:uint = 0;
			
			for (i; i < len; i++ )
			{
				_queue[_queue.length] = args[i];
			}
		}
		
		/**
		 * Puts all items from given Vector on top of the queue stack
		 * @param	items Vector of items to add to the queue
		 */
		public function pushVector(items:Vector.<Object>):void 
		{
			_queue = _queue.concat(items);
		}
		
		/**
		 * Returns last pushed item from the top of the stack and removes this item from the queue
		 * @return Last pushed item from the top of the stack
		 */
		public function pop():Object
		{
			return _queue.pop();
		}
		
		/**
		 * Pops all pushed items from the stack and removes them from the queue
		 * @return All pushed items from the stack
		 */
		public function popAll():Vector.<Object>
		{
			var allItems:Vector.<Object> = new Vector.<Object>();
			var len:uint = _queue.length;
			var i:int = 0;
			
			for (i = len-1; i >= 0; i-- )
			{
				allItems[len-1-i] = _queue[i];
			}
			_queue.length = 0;
			return allItems;
		}
		
		/**
		 * Returns raw queue
		 * @return Raw queue
		 */
		public function getQueue():Vector.<Object> 
		{
			return _queue;
		}
		
		/**
		 * Removes all items from the queue
		 */
		public function clear():void
		{
			_queue.length = 0;
		}
		
		/**
		 * Clears queue and prepares it for the GC
		 */
		public function destroy():void
		{
			clear();
			_queue = null;
		}
	}
}