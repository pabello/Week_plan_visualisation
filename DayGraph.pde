class DayGraph {
  String name;
  float[] times;
  String[] categories;
  float hoursTotal;
  float[] colors = {300, 225, 35, 60, 180, 130};
  
  DayGraph(String dayPlan) {
    String[] lines = split(dayPlan, '\n');
    name = lines[0];
    
    this.times = new float[lines.length-1];
    this.categories = new String[lines.length-1];
    
    for(int i=0; i<times.length; i++) {
      times[i] = float(trim(split(lines[i+1], " ")[0]));
      categories[i] = trim(split(lines[i+1], " ")[1]);
    }
    
    hoursTotal = 0;
    for(float time : times) hoursTotal += time;
  }
  
  void showGraph(float radius, float arcWidth) {
    for(int i=0; i<times.length; i++) {
      float arcRadLength = radians(times[i] / hoursTotal * 360);
      noFill();
      color col = color(colors[i], 100, 100);
      stroke(col, 50);
      strokeCap(SQUARE);
      strokeWeight(arcWidth);
      arc(0, 0, radius, radius, 0, arcRadLength, OPEN);
      rotate(arcRadLength);
    }
  }
  
  void printContent() {
    print(name + '\n');
    for(int i=0; i<times.length; i++) {
      print(times[i] + " " + categories[i] + "\n");
    }
  }
}
