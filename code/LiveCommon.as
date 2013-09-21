package  code {
	
	import flash.display.MovieClip;
	import flash.geom.Point;
    import flash.events.MouseEvent;
    import flash.geom.Matrix;
    import flash.events.Event;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.filters.BlurFilter;
	import flash.filters.*;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	
	import flash.display.Sprite;
    //import fl.controls.NumericStepper;
	
	import flash.geom.Point;
    import flash.geom.Matrix;
    import flash.text.TextField;
    import fl.controls.Button;
    
   
	
	public class LiveCommon extends Sprite {
		
		
		public static const WIDTH:uint = 500;  
        public static const HEIGHT:uint = 500;  
		public static const CAPACITY:uint = 100; 
		
		
		private var __screen:Bitmap;   
		
        private var __blankBitmapData:BitmapData;
		private var filter:BlurFilter = new BlurFilter(3,3,BitmapFilterQuality.HIGH);

		private var __amountInfo:Info;
		private var __generationInfo:Info;
		private var __btn:Button;		
		
		private var liveModel:LiveModel;
		private var newCA:RGCellularAutomata;
		
		public function LiveCommon() {			
			if(stage!=null){
                __init()
            }else{
                addEventListener(Event.ADDED_TO_STAGE,__onAddedToStage);
            }		
		}
		
		
		private function __onAddedToStage($e:Event):void{
            removeEventListener(Event.ADDED_TO_STAGE,__onAddedToStage);
            __init();
        }
		
		private function __init():void{
            __screen = new Bitmap(new BitmapData(WIDTH,HEIGHT, false, 0x00000000),"auto",false);
			addChild(__screen);  
			
			__btn = new Button();
			addChild(__btn);
			
			
			__btn.x = 100; __btn.y = 100;
			
			
			
			
            //__blankBitmapData = new BitmapData(WIDTH,HEIGHT, true);               
			__blankBitmapData = new BitmapData(WIDTH,HEIGHT,true,0xFF000000);      
			
			__amountInfo = new Info();
			__amountInfo.str = "amount == ";
			__amountInfo.x = (WIDTH);
            __amountInfo.y = (HEIGHT - __amountInfo.height)/2;
            addChild(__amountInfo);
			
			__generationInfo = new Info();
			__generationInfo.str = "generation "
			__generationInfo.x = __amountInfo.x;
            __generationInfo.y = __amountInfo.y + 60;
			addChild(__generationInfo);
            
            // smooth motion please                   
            stage.frameRate = 60;
            // some listeners
            stage.addEventListener(MouseEvent.MOUSE_DOWN,__onMouseDown);           
            stage.addEventListener(Event.ENTER_FRAME,__onEnterFrame);         
			//__btn.addEventListener(MouseEvent.MOUSE_DOWN, __onButtonClick);
			//__btn.addEventListener(Event.
			
			//liveModel = new LiveModel(CAPACITY);
			newCA = new RGCellularAutomata(CAPACITY);
				
			
        }         
		
		private function __onMouseDown($e:MouseEvent):void{
            stage.removeEventListener(MouseEvent.MOUSE_DOWN,__onMouseDown);
            stage.addEventListener(MouseEvent.MOUSE_UP,__onMouseUp);
			newCA.nextIteration();

			__render();
						
        }
        
        private function __onMouseUp($e:MouseEvent):void{
            stage.removeEventListener(MouseEvent.MOUSE_UP,__onMouseUp);
            stage.addEventListener(MouseEvent.MOUSE_DOWN,__onMouseDown);
			//liveModel.nextIteration();
			//liveModel = new LiveModel(CAPACITY);
			
			//newCA = new RGCellularAutomata(CAPACITY);
			//newCA.nextIteration();

			__render();
            
        }
		
		private function __onButtonClick($e:MouseEvent):void{
            //__btn.removeEventListener(MouseEvent.MOUSE_UP,__onMouseUp);
            //__btn.addEventListener(MouseEvent.MOUSE_DOWN,__onMouseDown);
			//liveModel.nextIteration();
			//liveModel = new LiveModel(CAPACITY);
			
			//newCA = new RGCellularAutomata(CAPACITY);
			//newCA.nextIteration();

			__render();
            
        }
		
		private function __render():void{  
			__screen.bitmapData.draw(__blankBitmapData);
			//liveModel.drawModel(__screen.bitmapData);
			newCA.drawModel(__screen.bitmapData);
			
			//__screen.bitmapData.applyFilter(__screen.bitmapData, __screen.bitmapData.rect, new Point(), filter);
	
		}
		
		// Listeners
		private function __onEnterFrame($e:Event):void{   
			
			//__info.capacity = liveModel.capacity;
			//__amountInfo.text = __amountInfo.str + liveModel.capacity;
			//__generationInfo.text = __generationInfo.str + liveModel.generation;
			
			//liveModel.nextIteration();
			//newCA.nextIteration();
			
            __render();
        }  
		
		
	}
	
}

import flash.filters.DropShadowFilter;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextField;
import fl.motion.Color;



internal class Info extends TextField{
	
	
    public var format:TextFormat = new TextFormat("_sans",16, 0x0066AA ,true);
	public var str:String;
    public function Info(){        
        filters = [new DropShadowFilter(2,45,0,.7,6,6,1.5,3)];   
        selectable = false;      
        defaultTextFormat = format;
        autoSize = TextFieldAutoSize.LEFT;
        text="capacity";
    }
    
    public function set capacity($amount:uint):void {
        text= "amount == " + $amount;
    }

}

