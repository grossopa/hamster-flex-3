// ActionScript file
			import flash.display.GradientType;
			import flash.display.Graphics;
			import flash.display.SpreadMethod;
			import flash.filters.GlowFilter;
			import flash.geom.Matrix;
			
			import noorg.magic.utils.CommonGraphicsUtil;
			
			override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
			{
				super.updateDisplayList(unscaledWidth, unscaledHeight);
				
				var g:Graphics = this.mainImg.graphics;
				var m:Matrix = new Matrix();
				m.rotate(Math.PI / 2);
				g.clear();
				g.endFill();
				g.beginGradientFill(GradientType.LINEAR, [0x000000, 0x7f7f7f, 0xffffff],
									[1,1, 1], [0x00,0x7f ,0xFF], m);
				g.lineStyle(3);
				//g.lineStyle(1);
				//CommonGraphicsUtil.drawTipRect(g, 0, 0, this.mainImg.width, this.mainImg.height,
				//							   20, 40, 
				//							   60, 50, 70, 150, 0x1000);
				CommonGraphicsUtil.drawTipRoundRectComplex(g, 
						0, 0, this.mainImg.width, this.mainImg.height,
						5, 10, 15, 20, 
						30, 50, 
						40, 50, 60, 40, 0x1000);
				g.endFill();
			}
			private function appCompleteHandler():void
			{
				mainImg.filters = [new GlowFilter(0x7f7f7f, 1, 12, 12, 2, 3)];
			}