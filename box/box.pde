import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HPixelColorist colors;
HDrawablePool pool;
int boxSize = 500;


void setup() {
	size(640,640,P3D);
	H.init(this).background(0).use3D(true);
	smooth();

  colors = new HPixelColorist("gradiens.jpg").fillAndStroke();

	pool = new HDrawablePool(10);
	pool.autoAddToStage()
		.add (
			new HBox()
		)

		.layout (
			new HGridLayout()
			.startX(width/2)
			.startY(height/2)
			.spacing(0,0)
			.cols(10)
		)

		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();
					HBox d = (HBox) obj;
					d
						.depth(boxSize)
						.width(boxSize)
						.height(boxSize)
						.fill(#0029FA,20)
						.stroke(#0029FA)
						.strokeWeight(1.5)
						.z(-500)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONX)
						.range(-360, 360)
						.speed(0.2)
						.freq(1)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONY)
						.range(-360, 360)
						.speed(0.1)
						.freq(1)
						.currentStep(i)
					;

					new HOscillator()
						.target(d)
						.property(H.ROTATIONZ)
						.range(-360, 360)
						.speed(0.5)
						.freq(1)
						.currentStep(i*2)
					;

					new HOscillator()
						.target(d)
						.property(H.SCALE)
						.range(0.5, 1)
						.speed(1)
						.freq(2.5)
						.currentStep(i*3)
					;
				}
			}
		)

		.requestAll()
	;
    //colors.applyColor(d);
 
}

void draw() {
	//pointLight(0, 51, 0,  0, height/2, -100);        // orange
	//pointLight(0, 149, 168,  width, height/2, -100);   // teal
	//pointLight(255, 204, 0,  width/2, 0, -50); // yellow

	H.drawStage();
  //saveFrame("../frames/#########.tif"); if (frameCount == 900) exit();
}
