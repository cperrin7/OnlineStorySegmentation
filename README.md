# OnlineStorySegmentation
 Code I created to look at the Online Story Segmentation data
 (https://github.com/cperrin7/OnlineStorySegmentation)


Demographic_Summary (complete):
 Takes in data from the demographics questionnaire, converts it to a usable format, and prints out the summary of the data

Button Presses_Summary (complete):
 Takes in data from the event segmentation task, converts it to usable format, and sums up the number of presses per participant on each task, then graphs it

Raster Plot (complete):
 Can create a raster plot of button presses, as lines on a graph for each button press, for each participant for each story. Does this for one specific participant, and also for all participants for a specific story, with histogram below.

Narrative Comparisons (complete):
  Creates raster plots for each story in each noise condition, uses raster_plot function.

Narrative Comparisons_histogram only (complete):
  Only shows the histogram for each story/condition, uses hist_only function.

Narrative Comparisons_participants once each (complete):
  Creates raster plots for each story in each noise condition, each participant is only counted once for each histogram box, uses hist_one_or_zero function. This is the best one. (histograms only)

Narrative Comparisons_with wav files (in progress):
  Plots raster and histograms with the corresponding wav files

-currently everything is drawn with basic r graphing, but should change to ggplot2
