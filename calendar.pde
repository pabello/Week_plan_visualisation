import processing.svg.*;
import processing.pdf.*;

DayGraph[] days;
Clock clock;
boolean saveFrame;
//int[][] dayFrameOffsets;
float karuzela;
int steps;
int increment;
PImage img;
Float[][] sleepTimes;
String[] dayNames = { "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun" };

void setup() { //<>//
  size(1800, 900);
  frameRate(2);
  saveFrame = true;
  //karuzela = 1;
  steps = 30;
  increment = 10;
  //img = loadImage("img/1858113.jpg");
  //img.resize(width, height);
  //noLoop();
  
  String[] dayPlans = loadDayPlans("data.txt");
  days = new DayGraph[7];
  
  sleepTimes = getSleepTimes("sleep_times.txt");
  
  for(int i=0; i<dayPlans.length; i++) {
    days[i] = new DayGraph(dayPlans[i]);
  }
  
  //beginRecord(SVG, "wizualizacja.svg");
  beginRecord(PDF, "wizualizacja.pdf");
  clock = new Clock();
}

String[] loadDayPlans(String path) {
  String[] lines = loadStrings(path);
  String[] days;
  
  for(int i=0; i<lines.length; i++) {
    lines[i] = lines[i].trim();
  }
  
  days = split(join(lines, "\n"), "\n\n");
  return days;
}

Float[][] getSleepTimes(String path) {
  String[] lines = loadStrings(path);
  Float[][] days = new Float[7][];
  
  for(int i=0; i<lines.length; i++) {
    String[] line = lines[i].split("\\s+");
    Float[] day = {float(line[1]), float(line[2])};
    days[i] = day;
  }
  
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

void drawDaysGraphs() {
  colorMode(HSB, 360, 100, 100, 100);
  pushMatrix();
    translate(width/4, height/2-30);
    rotate(radians(karuzela));
    karuzela = 1.1 * karuzela;
    fill(255);
    textAlign(CENTER, CENTER);
    //PFont arialBold = createFont("Arial Bold", 18);
    PFont verdanaBold = createFont("Verdana" , 18);
    textFont(verdanaBold);
    
    for(int i=0; i<7; i++) {
      if(i > 0) rotate(TWO_PI/7);
      pushMatrix();
        translate(0, -height*4/14);
        pushMatrix();
          if(i < 5) fill(180, 100, 100);
          else fill(300, 100, 100);
          rotate(-i*TWO_PI/7);
          translate(-2, 0);
          text(dayNames[i], 0, 0);
        popMatrix();
        days[i].showGraph(100, 100, steps);
      popMatrix();
    }
    
  popMatrix();
  
  //if(steps == 50) steps = 10;
  //steps += increment;
  colorMode(RGB, 255, 255, 255, 100);
}

void drawLegend() {
  String[] activities = {"Sleeping", "Eating", "Studying", "Journeys", "Socializing", "Others"}; 
  float[] colors = {300, 60, 180, 35, 130, 225};
  
  pushMatrix();
    //translate(width/2 -55, 5*height/7-30);
    //translate(width/2 -70, 5*height/7+30);
    translate(350, 850);
    //colorMode(HSB, 360, 100, 100, 1);
    colorMode(HSB, 360, 1, 100, 1);
    
    float radius = 24;
    float strokeWidth = 24;
    int stepsNumber = int(strokeWidth);
    strokeCap(SQUARE);
    noFill();
    
    for(int activity=0; activity<activities.length; activity++) {
      float hue = colors[activity];
      noFill();
      
      for(int step=0; step<stepsNumber; step++) {
        float layerWidth = strokeWidth - (step * ((strokeWidth) / stepsNumber));
        float alpha = pow(tan(map(float(step+1), 0, stepsNumber, PI/24, PI/4)), 2);
        float saturation = tan(map(float(step), 0, stepsNumber, PI/4, PI/36));
        color col = color(hue, saturation, 100, alpha);
        
        stroke(col);
        strokeWeight(layerWidth);
        circle(0, 0, radius);
      }
        
      fill(colors[activity], 1, 100, 1);
      textAlign(LEFT, CENTER);
      textFont(createFont("Verdana", 24));
      text(activities[activity], radius, -3);
      
      //translate(0, 2*radius);
      //translate(radius, 1.5*radius);
      translate(200, 0);
    }
    
    colorMode(RGB, 255, 255, 255, 100);
  popMatrix();
}

void drawBackground(int greyValue) {
  colorMode(RGB, 255, 255, 255, 100);
  noStroke();
  fill(greyValue);
  rect(0, 0, width, height);
  
  //image(img, 0, 0);
}

void draw() {
  drawBackground(0);
  
  clock.update(width, height);
  drawDaysGraphs();
  clock.drawSleep(sleepTimes, dayNames);
  drawLegend();
  
  if(saveFrame) {
    endRecord();
    save("wizualizacja.png");
    save("viz_image.png");
    saveFrame = false;
  }
}
