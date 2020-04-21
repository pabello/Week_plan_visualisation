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
  
  void drawSleep(Float[][] sleepTimes, String[] dayNames) {
    Float arcWidth = 50f;
    Float radius = 100f;
    pushMatrix();
      translate(width*3/4, height/2-30);
      
      colorMode(HSB, 360, 100, 100, 100);
      noStroke();
      float glowRadius = 205;
      float steps = 50;
      for(int step=0; step<steps; step++, glowRadius-=((glowRadius+5) / steps)) {
        float saturation = 120 - (step * (100 / steps));
        float alpha = (step + 1) * 150 / ((steps - step) * (steps - step));
        alpha = map(alpha, 0, 100, 1, 0);
        if(alpha > 0.5) {
          fill(270, saturation, 100, alpha);
          circle(0, 0, 3*glowRadius);
        }
      }
      
      colorMode(HSB, 360, 1, 100, 1);
      rotate(-HALF_PI);
      int dayNumber = 0;
      int stepsNumber = 16;
      //radius = 100f;
      textAlign(CENTER, CENTER);
      
      for(Float[] day : sleepTimes) {
        float arcStart = radians(day[0] * 30);
        float arcEnd = radians((day[0] + day[1]) * 30);
        noFill();
        strokeCap(SQUARE);
        
        for(int step=0; step<stepsNumber; step++) {
          float layerWidth = arcWidth - (step * ((arcWidth) / stepsNumber));
          float alpha = pow(tan(map(float(step+1), 0, stepsNumber, PI/36, PI/4)), 2);
          float saturation = tan(map(float(step), 0, stepsNumber, PI/4, PI/36));
          color col = color(300, saturation, 100, alpha);
          
          stroke(col);
          strokeWeight(layerWidth);
          arc(0, 0, radius, radius, arcStart, arcEnd, OPEN);
        }
        
        pushMatrix();
          rotate(HALF_PI);
          translate(0, (radius + dayNumber)/2-5);
          fill(300, 0, 0, 1);
          text(dayNames[dayNumber], 0, 0);
        popMatrix();
        radius += 1.1 * arcWidth;
        dayNumber += 1;
      }
      
      Float[] inviolableHours = getInviolableHours(sleepTimes);
      float arcStart = radians(inviolableHours[0] * 30);
      float arcEnd = radians(inviolableHours[1] * 30);
      radius = 520f;
      noFill();
      
      for(int step=0; step<stepsNumber; step++) {
        float layerWidth = arcWidth - (step * ((arcWidth) / stepsNumber));
        float alpha = pow(tan(map(float(step+1), 0, stepsNumber, PI/36, PI/4)), 2);
        float saturation = tan(map(float(step), 0, stepsNumber, PI/4, PI/36));
        color col = color(270, saturation, 100, alpha);
        
        stroke(col);
        strokeWeight(layerWidth);
        arc(0, 0, radius, radius, arcStart, arcEnd, OPEN);
      }
      
      strokeWeight(3);
      stroke(270, 1, 100, 0.5);
      rotate(radians(inviolableHours[0] * 30) - HALF_PI);
      line(0, 0, 0, radius/2 +15);
      println(inviolableHours[1]);
      rotate(radians((inviolableHours[1] - inviolableHours[0]) * 30));
      line(0, 0, 0, radius/2 +15);
      
      colorMode(RGB, 255, 255, 255, 100);
    popMatrix();
  }
  
  Float[] getInviolableHours(Float[][] sleepHours) {
    Float[] result = new Float[2];
    
    float maxStart = 0;
    float minEnd = 12;
    for(Float[] sleep : sleepHours) {
      if(sleep[0] > maxStart) maxStart = sleep[0];
      float endHour = sleep[0] + sleep[1];
      if(minEnd > endHour) minEnd = endHour;
    }
    result[0] = maxStart;
    result[1] = minEnd;
    
    return result;
  }
  
  void showFace(float centerWidth, float centerHeight, float radius, float hourMarkLength, boolean showHourNumbers) {
    PFont verdana24 = createFont("Verdana", 24);
    PFont verdana16 = createFont("Verdana", 16);
    textAlign(CENTER, CENTER);
    for( int i=0; i<12; i++ ) {
      pushMatrix();
        translate(centerWidth, centerHeight);        
        stroke(255);
        strokeWeight(1);
        point(0,0);
        rotate(i * (TWO_PI / 12));
        translate(0, -radius);
        int stroke = 3;
        stroke(255);
        if(i % 3 == 0) {
          stroke += 1;
          textFont(verdana24);
        } else {
          textFont(verdana16);
        }
        strokeWeight(stroke);
        line(0, 0, 0, hourMarkLength);
        if(i %3 == 0) {
          stroke(0);
          strokeWeight(2);
          strokeCap(ROUND);
          line(0, 2, 0, hourMarkLength-2);
        }
        if(showHourNumbers) {
          translate(0, -20);
          rotate(-i*PI/6);
          fill(255);
          if(i == 0) {
            text("12", 0, -3);
          } else {
            text(i, 0, -3);
          }
        }
        
      popMatrix();
    }
  }
  
  void show(int width, int height) {
    int hourMarkLength = height/40;
    
    showFace(width/4, height/2-30, height/8, hourMarkLength, false);
    
    pushMatrix();
      translate(width/4, height/2-30);
      colorMode(HSB, 360, 100, 100, 100);
      noStroke();
      float radius = 100;
      float steps = 50;
      for(int step=0; step<steps; step++, radius-=((radius+5) / steps)) {
        float saturation = 120 - (step * (100 / steps));
        float alpha = (step + 1) * 150 / ((steps - step) * (steps - step));
        alpha = map(alpha, 0, 100, 1, 0);
        if(alpha > 0.5) {
          fill(270, saturation, 100, alpha);
          circle(0, 0, 3*radius);
        }
      }
      colorMode(RGB, 255, 255, 255, 100);
    popMatrix();
    
    // cyan glow - left clock
    //pushMatrix();
    //  translate(width/4, height/2-30);
    //  colorMode(HSB, 360, 100, 100, 100);
    //  noStroke();
    //  radius = 100;
    //  steps = 50;
    //  for(int step=0; step<steps; step++, radius-=((radius+5) / steps)) {
    //    //float saturation = 100 - (step * (70 / steps));
    //    float base = 10;
    //    float power = 1f/25;
    //    float power2 = step+1;
    //    float saturation = 80 - pow( pow(base, power), power2 );
    //    if(saturation < 0) saturation = 0;
    //    //float alpha = (step + 1) * 100 / ((steps - step) * (steps - step));
    //    //float saturation = 100 / (step + 1);
    //    float alpha = 1.5; 
    //    fill(180, saturation, 100, alpha);
    //    circle(0, 0, 2*radius);
    //  }
    //  colorMode(RGB, 255, 255, 255, 100);
    //popMatrix();
    
    // hour pointer
    pushMatrix();
      translate(width/4, height/2-30);
      rotate(hour * (TWO_PI / 12) + minute * (TWO_PI / 720));
      fill(255);
      stroke(0);
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
      translate(width/4, height/2-30);
      rotate(minute * (TWO_PI / 60) + second * (TWO_PI / 3600));
      fill(255);
      stroke(0);
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
      translate(width/4, height/2-30);
      rotate(second * (TWO_PI / 60));  //standard 
      //rotate(millis() * (TWO_PI / 60000));  //fluent 
      strokeWeight(1);
      stroke(218, 46, 130);
      line(0, hourMarkLength, 0, -height/8 + hourMarkLength/2);
      stroke(0);
    popMatrix();
    
    pushMatrix();
      translate(width/4, height/2-30);
      fill(0);
      strokeWeight(0);
      circle(0, 0, 5);
    popMatrix();
    
    showFace(width*3/4, height/2-30, 4*height/13, hourMarkLength*8/3, true);
  }
  
}
