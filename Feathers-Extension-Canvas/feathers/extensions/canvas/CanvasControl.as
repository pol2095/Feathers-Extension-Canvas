package feathers.extensions.canvas
{
	import feathers.core.FeathersControl;
	import starling.events.Event;
 
	/**
	 * The Canvas supports basic vector drawing functionality.
	 *
	 * @see feathers.extensions.canvas.CanvasDisplayObject
	 */
	public class CanvasControl extends FeathersControl
	{
		private var canvas:CanvasDisplayObject = new CanvasDisplayObject();
		
		public function CanvasControl()
		{
			super();
			canvas.addEventListener(Event.ADDED, invalidateHandler);
			canvas.addEventListener(Event.REMOVED, invalidateHandler);
			this.addChild( canvas );
		}
		
		private function invalidateHandler():void
		{
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}
		
		/**
		 * The display object that contains the drawing methods.
		 */
		public function get graphics():CanvasDisplayObject
		{
			return canvas;
		}
 		/**
		 * @private
		 */
		override protected function draw():void
        {
			this.autoSizeIfNeeded();
        }
		/**
		 * @private
		 */
        protected function autoSizeIfNeeded():Boolean
        {
            var needsWidth:Boolean = isNaN(this.explicitWidth);
            var needsHeight:Boolean = isNaN(this.explicitHeight);
            if(!needsWidth && !needsHeight)
            {
                return false;
            }
			
            var newWidth:Number = this.explicitWidth;
            if(needsWidth)
            {
                newWidth = this.graphics.bounds.x + this.graphics.bounds.width;
            }
            var newHeight:Number = this.explicitHeight;
            if(needsHeight)
            {
                newHeight = this.graphics.bounds.y + this.graphics.bounds.height;
            }
 
            return this.setSizeInternal(newWidth, newHeight, false);
        }
		
		/**
		 * @private
		 */
		override public function dispose():void
		{
			canvas.removeEventListener(Event.ADDED, invalidateHandler);
			canvas.removeEventListener(Event.REMOVED, invalidateHandler);
			super.dispose();
		}
	}
}