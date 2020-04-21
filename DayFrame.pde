class DayFrame {
  String date;
  String name;
  int weekDayNumber;
  String[][] activities;

  DayFrame(String inputString, int arrayIndex) {
    weekDayNumber = arrayIndex + 1;
    String[] lines = split(inputString, "\n");
    String[] header = split(lines[0], " ");
    date = header[0];
    name = header[1];
    activities = new String[lines.length-1][2];
    for (int i=0; i<lines.length-1; i++) {
      String[] line = split(lines[i+1], " -> ");
      activities[i][0] = line[0];
      activities[i][1] = line[1];
    }
  }

  void printContent() {
    print(date + " " + name + "\n");
    for (int i=0; i<activities.length; i++) {
      print(activities[i][0] + " " + activities[i][1] + "\n");
    }
    print("\n");
  }

  void show() {
      int longestLine = 0;
      
      textAlign(LEFT, TOP);
      text(name, 0, -5);
      int vOffset = 13;
      for (int i=0; i<activities.length; i++) {
        // digit - 7pt; : - 4pt; ' ' - 3pt; '-' - 3pt
        if(activities[i][1].length() > longestLine) longestLine = activities[i][1].length();
        int hOffset = 0;
        if (i == 0 || i == activities.length-1) hOffset = 41;
        text(activities[i][0], hOffset, (i+1) * vOffset);
        text(activities[i][1], 80, (i+1) * vOffset);
      }
      noFill();
      stroke(255);
      strokeWeight(1);
      float boxWidthMultiplier = 6;
      //if(weekDayNumber == 1 || weekDayNumber == 7) boxWidthMultiplier = 9.5;
      //else if(weekDayNumber == 2 || weekDayNumber == 4 || weekDayNumber ==6) boxWidthMultiplier = 8.5;
      //else if(weekDayNumber == 3) boxWidthMultiplier = 10;
      //else boxWidthMultiplier = 9;
      rect(-10, -10, 100 + longestLine * boxWidthMultiplier, (activities.length+1) * vOffset + 20);

    //popMatrix();
  }
}
