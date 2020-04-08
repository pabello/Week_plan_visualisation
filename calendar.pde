import processing.svg.*;

DayFrame[] days;
Clock clock;
boolean saveFrame;
int[][] dayFrameOffsets;

void setup() {
  size(1800, 900);
  frameRate(8);
  saveFrame = true;
  //noLoop();
  
  String[] lines = loadPlan("../plan_tygodnia.txt");
  String[] dayPlans = splitLinesToDays(lines);
  days = new DayFrame[7];
  for(int i=0; i<dayPlans.length; i++) {
    days[i] = new DayFrame(dayPlans[i], i);
  }
  days[3].printContent();
  
  dayFrameOffsets = new int[7][];
  dayFrameOffsets[0] = new int[] {-125, -375};
  dayFrameOffsets[1] = new int[] {155, -210};
  dayFrameOffsets[2] = new int[] {155, -45};
  dayFrameOffsets[3] = new int[] {20, 170};
  dayFrameOffsets[4] = new int[] {-310, 170};
  dayFrameOffsets[5] = new int[] {-435, -20};
  dayFrameOffsets[6] = new int[] {-390, -210};
  
  beginRecord(SVG, "../wizualizacja.svg");
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

void draw() {
  background(82);
  // Draw something good here
  
  clock.update(width, height);
  text("Hello Kinga!", 100, 100);
  
  // // heptagon
  //pushMatrix();
  //  translate(width/4, height/2);
  //  translate(0, -250);
  //  float angle = (PI - TWO_PI/7);
  //  float edgeLength = sqrt( 2*( 250 * 250 ) * (1 - cos(TWO_PI/7)) );
  //  rotate(PI - angle/2);
  //  stroke(255);
  //  strokeWeight(2);
  //  for(int i=0; i<7; i++) {
  //    line(0, 0, 0, -edgeLength);
  //    translate(0, -edgeLength);
  //    rotate(PI - angle);
  //  }
  //popMatrix();
  
  for(int i=0; i<days.length; i++) {
    pushMatrix();
      translate(width/4, height/2);
      translate(dayFrameOffsets[i][0], dayFrameOffsets[i][1]); 
      days[i].show();
    popMatrix();
  }
  //days[0].show(width, height);
  clock.fillGraph();
  
  if(saveFrame) {
    endRecord();
    save("../wizualizacja.png");
    saveFrame = false;
  }
}
