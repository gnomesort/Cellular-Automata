package  code{
	
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
	
	
	public class RGCellularAutomata {
		
		public static const N:uint = 50;
		public static const M:uint = 50;
		public static const MAX_VALUE:uint = 24;
		
		public var barSize:uint = 3;
		public var capacity:uint;
		public var generation:Number = 0; 
			
		//private var cell:Vector.<Vector.<int>> = new Vector.<Vector.<int>>;	
		//private var raw:Vector.<int>;
			
		private var cell:Array = new Array();
		private var next:Array = new Array();
		private var summ:Array = new Array();
	
		public function RGCellularAutomata(_capacity:uint) {
			
			generation = 0;
			for (var n:int = 0; n<N; n++){
				cell.push(new Array());
				next.push(new Array());
				summ.push(new Array());
				
				
				for (var m:int = 0; m<M; m++){
					cell[i].push(0);
					next[i].push(0);
					summ[i].push(0);
					
				
				}
			}
			
			for (var n:int = 0; n<N; n++)
				for (var m:int = 0; m<M; m++){
				cell[n][m] = 0;
				cell[n][m] = Math.round(Math.random()*(MAX_VALUE-1));
				next[n][m] = cell[n][m];
				summ[n][m] = 0;
				}
				
			for (var i:uint=0; i<_capacity; i++){
				n = Math.round(Math.random()*(N-1));
				m = Math.round(Math.random()*(M-1));
				cell[n][m] = Math.round(Math.random()*(MAX_VALUE-1));
				}
			
		}
		
		public function nextIteration(){
			
			generation++;
			
			for (var n:int = 0; n<N; n++)
				for (var m:int = 0; m<M; m++){
					
					for (var i:int = -1; i<=1; i++)
						for (var j:int = -1; j<=1; j++)
							//if (n+i >= 0 && n+i < N && m+j >= 0 && m+j < M)
							if ((cell[(N + n+i)%N][(M + m+j)%M]+1)%MAX_VALUE == (cell[n][m])) next[(N + n+i)%N][(M +m+j)%M] = cell[n][m];
							//if (cell[(N + n+i)%N][(M + m+j)%M] != 0) next[n][m] = (cell[n][m] + 1)%MAX_VALUE;
						
						
					/*	
					for (var i:int = -2; i<=2; i++)
						for (var j:int = -2; j<=2; j++)
						if (n+i >= 0 && n+i < N && m+j >= 0 && m+j < M)
						summ[n][m] += cell[n+i][m+j];
					*/
					}		
			capacity = 0;
			for (var n:int = 0; n<N; n++)
				for (var m:int = 0; m<M; m++){
				cell[n][m] = next[n][m];
				//cell[n][m] = (cell[n][m] + 1)%MAX_VALUE;
				//next[n][m] = 0;
				if (cell[n][m] != 0) capacity++;
					
			}
		}
		
		public function drawBarToBitmap(bmp:BitmapData, x:uint, y:uint, d:uint, color:uint){
			for (var i:int = -d; i <= d; i++ )
				for (var j:int = -d; j <= d; j++ )
				bmp.setPixel(x+i, y+j, color);
			
			}
		public function drawModel(context:BitmapData){
			
			var size:uint = Math.min(context.width, context.height);
			var K:uint = Math.max(M,N);
			
			var ratio:Number = size/(K+1);
			
			var cx:uint = context.width/2;
			var cy:uint = context.height/2;
			
			//drawBarToBitmap(context, 100,100,30,256*256*256 + 100*256);
			
			
			
			
			for (var n:int = 0; n<N; n++)
				for (var m:int = 0; m<M; m++){
					//context.setPixel(cx + (n - N/2)*ratio, cy + (m - M/2)*ratio);
					if (cell[n][m] != 0){
						//var colorValue:uint = cell[n][m] * 256 * 256 + 256*256*256;
						var colorValue:uint = 0x001111 * cell[n][m];
						
						drawBarToBitmap(context, cx + Math.round((n - N/2)*ratio), cy + Math.round((m - M/2)*ratio), barSize, colorValue); 
						
					} else {;}
						
						
				}
				
			}

	}
	
}
