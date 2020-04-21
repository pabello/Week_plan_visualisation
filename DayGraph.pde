class DayGraph {
  String name;
  float[] times;
  String[] categories;
  float hoursTotal;
  float[] colors = {300, 60, 180, 35, 130, 225};

  DayGraph(String dayPlan) {
    String[] lines = split(dayPlan, '\n');
    name = lines[0];

    this.times = new float[lines.length-1];
    this.categories = new String[lines.length-1];

    for (int i=0; i<times.length; i++) {
      times[i] = float(trim(split(lines[i+1], " ")[0]));
      categories[i] = trim(split(lines[i+1], " ")[1]);
    }

    hoursTotal = 0;
    for (float time : times) hoursTotal += time;
  }

  void showGraph(float radius, float arcWidth, int steps) {
    for (int i=0; i<times.length; i++) {
      float arcRadLength = radians(times[i] / hoursTotal * 360);
      noFill();

      int stepsNumber = steps;
      for (int step=0; step<stepsNumber; step++) {
        float saturation = 100 - (step * (100 / stepsNumber));
        float alpha = (step + 1) * 100 / ((stepsNumber - step) * (stepsNumber - step)); 
        color col = color(colors[i], saturation, 100, alpha);
        stroke(col);
        strokeCap(SQUARE);
        float layerWidth = arcWidth - (step * ((arcWidth) / stepsNumber));
        strokeWeight(layerWidth);
        arc(0, 0, radius, radius, 0, arcRadLength, OPEN);
      }
      rotate(arcRadLength);
    }
  }

  void printContent() {
    print(name + '\n');
    for (int i=0; i<times.length; i++) {
      print(times[i] + " " + categories[i] + "\n");
    }
  }
}
