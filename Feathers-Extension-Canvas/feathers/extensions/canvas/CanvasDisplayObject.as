/*
Copyright 2016 pol2095. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package feathers.extensions.canvas
{
	import starling.display.Canvas;
	import starling.display.Quad;
	import starling.filters.FragmentFilter;
	import starling.geom.Polygon;
	import starling.utils.Align;
	import starling.display.MeshBatch;
	import starling.events.Event;
 
	/**
	 * The Canvas supports basic vector drawing functionality.
	 *
	 * @see starling.display.Canvas
	 */
	public class CanvasDisplayObject extends Canvas
	{
 
		private var _thickness:Number = 1;
		private var _color:uint = 0;
		private var _alpha:Number = 1;
		private var _fromX:Number;
		private var _fromY:Number;
		private var _toX:Number;
		private var _toY:Number;
		private var line :Quad;
		/**
		 * @private
		 */
		public var batch :MeshBatch;
		private var fragmentFilter :FragmentFilter;
 
		public function CanvasDisplayObject()
		{
			super();
			batch = new MeshBatch ()
			fragmentFilter = new FragmentFilter ();
			fragmentFilter.antiAliasing = 4;
			this.filter = fragmentFilter;
		}
		
		/**
		 * Specifies a line style used for subsequent calls to Graphics methods such as the lineTo().
		 *
		 * @param thickness An integer that indicates the thickness of the line in points
		 *
		 * @param color A hexadecimal color value of the line
		 *
		 * @param alpha A number that indicates the alpha value of the color of the line
		 *
		 */
		public function lineStyle(thickness:Number = 1, color:uint = 0, alpha:Number = 1):void
		{
			_thickness = thickness;
			_color = color;
			_alpha = alpha;
		}
		
		/**
		 * Moves the current drawing position to (x, y).
		 *
		 * @param x A number that indicates the horizontal position relative to the registration point of the parent display object (in pixels).
		 *
		 * @param y A number that indicates the vertical position relative to the registration point of the parent display object (in pixels).
		 *
		 */
		public function moveTo(x:Number, y:Number):void
		{
			_fromX = x;
			_fromY = y;
		}
		
		/**
		 * Draws a line using the current line style from the current drawing position to (x, y)
		 *
		 * @param x A number that indicates the horizontal position relative to the registration point of the parent display object (in pixels).
		 *
		 * @param y A number that indicates the vertical position relative to the registration point of the parent display object (in pixels).
		 *
		 */
		public function lineTo(x:Number, y:Number):void
		{
			if( this.getChildIndex( batch ) == -1 )
			{
				addChild( batch );
			}
			{
				dispatchEvent(new Event( Event.ADDED ));
			}
			
			_toX = x;
			_toY = y;
 
			line = new Quad (_thickness, _thickness, _color);
 
			var fXOffset:Number = _toX - _fromX;
			var fYOffset:Number = _toY - _fromY;
			var len:Number = Math.sqrt(fXOffset * fXOffset + fYOffset * fYOffset);
			fXOffset = fXOffset * _thickness / (len * 2);
			fYOffset = fYOffset * _thickness / (len * 2);
 
			line. setVertexPosition(2, _fromX + fYOffset, _fromY - fXOffset);
			line. setVertexPosition(1, _toX  - fYOffset, _toY + fXOffset);
			line. setVertexPosition(0, _toX  + fYOffset, _toY - fXOffset);
			line. setVertexPosition(3, _fromX - fYOffset, _fromY + fXOffset);
 
			line.alpha = _alpha;
 
			batch.addMesh (line);
 
			_fromX = x;
			_fromY = y;
		}
		
		/**
		 * @private
		 */
		override public function clear():void
		{
			batch.clear();
			super.clear();
		}
	}
}