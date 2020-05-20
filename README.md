# Week plan visualisation

### A work for Data reporting and visualisation course

#### The goal of this project was to visualise statistics on how I spent my time during a week of choice and to emphasise on one of the activiteies. The output was supposed to be a vector graphic.
My idea was to emphasise on the sleep times during that week and that's what the right part of the visualisation presents.

I chose to create this visualisation in Processing because its relatively easy to build things with and I wanted some challenge in this task rather than frustration from using drawing tools.

#### What I have learned in this project is:
- the power of value mapping functions and the convenience it gives you,
- how to make this cool neon effect
- different color schemes (mainly HSV)
- that visualisations need to be *very* clear as other people may interpret it in a different way

# Run the project
## Input data
Week time spending summary on the left side is generated from `data.txt` file. It should contain summed up time values spent on particular activity type labeled with day name and ordered:
- sleeeping,
- eating,
- studying,
- journeys,
- socializing,
- others.

Here is an example:
``` 
Monday: 23
6.5 sleep
2.0 eating
10.5 studying
1.0 journeys
0.0 socializing
3.0 others

Tuesday: 25.5
8.0 sleep
1.5 eating
14.0 studying
0.0 journeys
0.0 socializing
2.0 others
```

To emphasise on part of the data (in this case sleeping times) it needs to be stored in separated file `sleep_times.txt`.
The file should contain *day name*, *starting hour*, *ending hour*. Where hours are formatted as floats, so *8.5* would be *8:30*.

Sample:
```
Monday:		  2.0 6.5
Tuesday:	  1.0 8.0
Wednesday:	2.5 7.5
Thursday:	  1.5 8.0
Friday:		  3.5 7.0
Saturday:	  2.0 8.0
Sunday: 	  2.5 6.5
```


## Usage
To use the program you need to have **Processing** installed on your device. You can get it [here](https://processing.org/download/).
Then you just place all the files in `calendar` folder, open calendar.pde with Processing and click *Run* button.

### Preview
![Output image preview](/viz_image.png)
