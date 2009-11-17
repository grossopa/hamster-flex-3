// ActionScript file
			import flash.display.GradientType;
			import flash.display.Graphics;
			import flash.filters.GlowFilter;
			import flash.geom.Matrix;
			
			import noorg.magic.utils.TipArrowImpl;
			import noorg.magic.utils.TipArrowUtil;
			
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
//				TipArrowUtil.drawTipRoundRectComplex(g, 
//						0, 0, this.mainImg.width, this.mainImg.height,
//						5, 10, 15, 20, 
//						30, 50, 
//						40, 50, 60, 40, 0x1000);
//				TipArrowUtil.drawTipRect(g, 0, 0, this.mainImg.width, this.mainImg.height,
//						[
//						new TipArrowImpl(TipArrowUtil.LEFT, 10, 20, 12, 8), 
//						//new TipArrowImpl(TipArrowUtil.TOP, 400, 420, 440, 40),
//						//new TipArrowImpl(TipArrowUtil.RIGHT, 40, 80, 70, 30),
//						//new TipArrowImpl(TipArrowUtil.RIGHT, 300, 350, 310, 40),
//						new TipArrowImpl(TipArrowUtil.BOTTOM, 10, 20, 12, 8)
//						]);
				TipArrowUtil.drawTipRoundRectComplex(g, 0, 0, this.mainImg.width, this.mainImg.height,
						[
						//	new TipArrowImpl(TipArrowUtil.LEFT, 170, 240, 130, 70),
						//	new TipArrowImpl(TipArrowUtil.RIGHT, 170, 240, 130, 70),
						//	new TipArrowImpl(TipArrowUtil.TOP, 170, 240, 130, 70),
							new TipArrowImpl(TipArrowUtil.BOTTOM, 170, 240, 130, 70),
							new TipArrowImpl(TipArrowUtil.TOP, 270, 350, 130, 40)
						], 10, 20, 30, 40);
				g.endFill();
			}
			private function appCompleteHandler():void
			{
				mainImg.filters = [new GlowFilter(0x7f7f7f, 1, 12, 12, 2, 3)];
			}