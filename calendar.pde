import processing.svg.*;

DayGraph[] days;
Clock clock;
boolean saveFrame;
//int[][] dayFrameOffsets;
float karuzela;

void setup() {
  karuzela = 1;
  size(1800, 900);
  frameRate(16);
  //saveFrame = true;
  saveFrame  = false;
  //noLoop();
  
  String[] lines = loadPlan("data.txt");
  String[] dayPlans = splitLinesToDays(lines);
  days = new DayGraph[7];
  
  for(int i=0; i<dayPlans.length; i++) {
    days[i] = new DayGraph(dayPlans[i]);
  }
  days[6].printContent();
  
  //dayFrameOffsets = new int[7][];
  //dayFrameOffsets[0] = new int[] {-125, -375};
  //dayFrameOffsets[1] = new int[] {155, -210};
  //dayFrameOffsets[2] = new int[] {155, -45};
  //dayFrameOffsets[3] = new int[] {20, 170};
  //dayFrameOffsets[4] = new int[] {-310, 170};
  //dayFrameOffsets[5] = new int[] {-435, -20};
  //dayFrameOffsets[6] = new int[] {-390, -210};
  
  //beginRecord(SVG, "wizualizacja.svg");
  clock = new Clock();
}

String[] loadPlan(String path) {
  String[] lines = loadStrings(path);
  return lines;
}

String[] splitLinesToDays(String[] lines) {
  String[] days;
  
  for(int i=0; i<lines.length; i++) {
    lines[i] = lines[i].trim();
  }
  
  days = split(join(lines, "\n"), "\n\n");
  return days;
}

void drawHeptagon(float centerWidth, float centerHeight) {
  pushMatrix();
    translate(centerWidth, centerHeight);
    translate(0, -250);
    float angle = (PI - TWO_PI/7);
    float edgeLength = sqrt( 2*( 250 * 250 ) * (1 - cos(TWO_PI/7)) );
    rotate(PI - angle/2);
    stroke(255);
    strokeWeight(2);
    for(int i=0; i<7; i++) {
      line(0, 0, 0, -edgeLength);
      translate(0, -edgeLength);
      rotate(PI - angle);
    }
  popMatrix();
}

void draw() {
  background(82);
  //background(255);
  // Draw something good here
  
  clock.update(width, height);
  text("Hello Kinga!", 100, 100);
  
  pushMatrix();
    colorMode(HSB, 360, 100, 100);
    translate(width/4, height/2);
    //rotate(radians(karuzela));
    //karuzela = 1.01 * karuzela;
    for(int i=0; i<7; i++) {
      if(i > 0) rotate(TWO_PI/7);
      pushMatrix();
        translate(0, -height*4/14);
        days[i].showGraph(100, 50);
      popMatrix();
    }
    colorMode(RGB, 255, 255, 255);
  popMatrix();
  
  clock.fillGraph();
  
  if(saveFrame) {
    endRecord();
    save("wizualizacja.png");
    saveFrame = false;
  }
}
