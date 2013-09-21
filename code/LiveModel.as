package  code {
	
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
	
	public class LiveModel {

		public static const N:uint = 200;
		public static const M:uint = 200;
		
		public var barSize:uint = 1;
		public var capacity:uint;
		public var generation:Number = 0; 
		
		//private var cell:Vector.<Vector.<int>> = new Vector.<Vector.<int>>;	
		//private var raw:Vector.<int>;
		
		private var cell:Array = new Array();
		private var next:Array = new Array();
		private var summ:Array = new Array();
		
		
		public function LiveModel(capacity:uint) {
			//var n,m:uint;
			
					
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
				next[n][m] = 0;
				summ[n][m] = 0;
				}
			
			
			
				
			for (var i:uint=0; i<capacity; i++){
				n = Math.round(Math.random()*(N-1));
				m = Math.round(Math.random()*(M-1));
				cell[n][m] = 1;
				}
			
			// constructor code
		}
		
 		public function nextIteration(){
			
			generation++;
			var _summ:int = 0;
			for (var n:int = 0; n<N; n++)
				for (var m:int = 0; m<M; m++){
					_summ = 0;
					summ[n][m] = 0;
					for (var i:int = -1; i<=1; i++)
						for (var j:int = -1; j<=1; j++)
						if (n+i >= 0 && n+i < N && m+j >= 0 && m+j < M)
						_summ += cell[n+i][m+j];
					
					_summ -= cell[n][m];
						
						
					for (var i:int = -2; i<=2; i++)
						for (var j:int = -2; j<=2; j++)
						if (n+i >= 0 && n+i < N && m+j >= 0 && m+j < M)
						summ[n][m] += cell[n+i][m+j];
					
					
				next[n][m] = 0;
						
				if (_summ == 3 && cell[n][m] == 0) 
					next[n][m] = 1; 
			
				if ((_summ == 2 || _summ == 3) && cell[n][m] != 0)
					next[n][m] = 1; 
			
				}

			capacity = 0;
			for (var n:int = 0; n<N; n++)
				for (var m:int = 0; m<M; m++){
				cell[n][m] = next[n][m];
				next[n][m] = 0;
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
					if (cell[n][m] != 0)
						drawBarToBitmap(context, cx + Math.round((n - N/2)*ratio), cy + Math.round((m - M/2)*ratio), barSize, 0x001111* summ[n][m]); 
					else
						;//drawBarToBitmap(context, cx + (n - N/2)*ratio, cy + (m - M/2)*ratio, barSize, 0x00000000); 
						
				}
				
			}
			
	}
	
}
