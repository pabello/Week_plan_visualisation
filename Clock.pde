class Clock {
  int hour;
  int minute;
  int second;
  
  Clock() {
    hour = hour();
    minute = minute();
    second = second();
  }
  
  void update(int width, int height) {
    int newSec = second();
    if( newSec < second ) {
      int newMin = minute();
      if( newMin < minute) {
        hour = hour();
      }
      minute = newMin;
    }
    second = newSec;
    
    show(width, height);
  }
  
  void fillGraph() {
    pushMatrix();
      translate(width*3/4, height/2);
      noStroke();
      fill(218, 46, 130, 40);
      arc(0, 0, height/3-height/30, height/3-height/30, -PI/3, PI, PIE);
    popMatrix();
  }
  
  void showFace(float centerWidth, float centerHeight, float radius, float hourMarkLength) {
    for( int i=0; i<12; i++ ) {
      pushMatrix();
        translate(centerWidth, centerHeight);
        stroke(255);
        strokeWeight(1);
        point(0,0);
        rotate(i * (TWO_PI / 12));
        translate(0, -radius);
        int stroke = 3;
        stroke(0);
        if(i % 3 == 0) {
          stroke += 1;
        }
        strokeWeight(stroke);
        line(0, 0, 0, hourMarkLength);
        if(i %3 == 0) {
          stroke(255);
          strokeWeight(1);
          line(0, 2, 0, hourMarkLength-2);
          stroke(0);
        }
        
      popMatrix();
    }
  }
  
  void show(int width, int height) {
    int hourMarkLength = height/40;
    
    showFace(width/4, height/2, height/8, hourMarkLength);
    
    pushMatrix();
      translate(width/4, height/2);
      noStroke();
      int radius = 100;
      int step = 1;
      fill(2*step, 255, 255, step);
      for(; radius>0; radius-=step) {
        circle(0, 0, 2*radius);
      }
    popMatrix();
    
    // hour pointer
    pushMatrix();
      translate(width/4, height/2);
      rotate(hour * (TWO_PI / 12) + minute * (TWO_PI / 720));
      fill(0);
      strokeWeight(0);
      beginShape();
        vertex(0, hourMarkLength);
        vertex(hourMarkLength/4, 0);
        vertex(0, -height/12);
        vertex(-hourMarkLength/4, 0);
      endShape(CLOSE);
      //strokeWeight(4);
      //line(0, hourMarkLength, 0, -height/6 + hourMarkLength/2);
    popMatrix();
    
    // minute pointer
    pushMatrix();
      translate(width/4, height/2);
      rotate(minute * (TWO_PI / 60) + second * (TWO_PI / 3600));
      fill(0);
      strokeWeight(0);
      beginShape();
        vertex(0, hourMarkLength);
        vertex(hourMarkLength/4, 0);
        vertex(0, -height/8 + 3*hourMarkLength/4);
        vertex(-hourMarkLength/4, 0);
      endShape(CLOSE);
      //strokeWeight(4);
      //line(0, hourMarkLength, 0, -height/6 + hourMarkLength/2);
    popMatrix();
    
    // second pointer
    pushMatrix();
      translate(width/4, height/2);
      rotate(second * (TWO_PI / 60));  //standard 
      //rotate(millis() * (TWO_PI / 60000));  //fluent 
      strokeWeight(1);
      stroke(218, 46, 130);
      line(0, hourMarkLength, 0, -height/8 + hourMarkLength/2);
      stroke(0);
    popMatrix();
    
    pushMatrix();
      translate(width/4, height/2);
      fill(255);
      strokeWeight(0);
      circle(0, 0, 5);
    popMatrix();
    
    showFace(width*3/4, height/2, height/3, hourMarkLength*8/3);
    
  }
  
}
