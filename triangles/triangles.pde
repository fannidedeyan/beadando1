import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;



HColorPool colors;
HDrawablePool pool;

float ringScale = 400;
int   ringSteps = 20;

void setup() {
	size(640,640,P3D);
	H.init(this).background(0).use3D(true);
	smooth();
  

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #ff3300, #ff3300, #242424, #333333, #666666);

	pool = new HDrawablePool(10);
	pool.autoAddToStage()
		.add (
			new HShape("triangles.svg")
		)

		.layout (
			new HGridLayout()
			.startX(width/2)
			.startY(height/2)
			.spacing(15,15)
			.cols(10)
		)

		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HShape d = (HShape) obj;
					d
						.enableStyle(false)
						.stroke(#b8b8f3)
						.noFill()
						.size( ringScale )
						.anchorAt(H.CENTER)
						.z(0)
					;

					ringScale = ringScale - ringSteps;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(-360,360)
						.speed(0.1)
						.freq(3)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(-360, cos(360))
						.speed(0.125)
						.freq(1)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(sin(360), cos(360))
						.speed(0.25)
						.freq(1)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0.5, 1)
						.speed(0.3)
						.freq(5)
						.currentStep(i*2)
					;
				}
			}
		)

		.requestAll()
	;
  
}

void draw() {
	H.drawStage();
  //saveFrame("../frames/#########.tif"); if (frameCount == 900) exit();
}
