/*
Copyright 2016 pol2095. All Rights Reserved.

This program is free software. You can redistribute and/or modify it in
accordance with the terms of the accompanying license agreement.
*/
package feathers.extensions.canvas
{
	import feathers.controls.ScrollContainer;
	
	/**
	 * The Canvas supports basic vector drawing functionality.
	 *
	 * @see feathers.extensions.canvas.CanvasDisplayObject
	 */
	public class Canvas extends ScrollContainer
	{
		private var canvas:CanvasControl = new CanvasControl();
		
		public function Canvas()
		{
			super();
			this.addChild( canvas );
		}
		
		/**
		 * The display object that contains the drawing methods.
		 */
		public function get graphics():CanvasDisplayObject
		{
			return canvas.graphics;
		}
	}
}