##Summarize number of Button Presses per condition for Online Story Segmentation
#Author: Cameron Perrin, cperrin@wustl.edu

# Summarize so you still have a long format, but one row per subject per condition (keep which story).
# Then you can summarize/plot so that we have # button presses coded by each acoustic condition
if(!require("dplyr")) install.packages("dplyr"); library(dplyr)
if(!require("ggplot2")) install.packages("ggplot2"); library(ggplot2)
if(!require("tidyverse")) install.packages("tidyverse");library(tidyverse)
if(!require("patchwork")) install.packages("patchwork");library(patchwork)

##load data (change file path if not me)
messy_data = read.csv("C:/Users/CKPer/Box/WashU/Peelle Lab/Story Segmentation/Online Sona data/gorilla data_long version/data_exp_15568-v3_task-j2vq.csv")
messy_data = select(messy_data, Participant.Private.ID, narrativeName, noiseCondition, Response, Attempt)
long_data = filter(messy_data, Response=="space")
long_data = subset(long_data, select = -Response)


#now want sum of button presses
button_presses = pivot_wider(long_data, names_from = narrativeName, values_from = Attempt, values_fn = list(Attempt = length))
#^gives us a weird looking thing, but has all narrative and noise info

#get sum off button presses for each pt for each narrative (not what we're looking for)
button_press_by_narrative = pivot_wider(subset(long_data, select = -noiseCondition), names_from = narrativeName, values_from = Attempt, values_fn = list(Attempt = length))
#^looks better, but lose the noise info

# #by noise condition?
# button_press_by_noise = pivot_wider(subset(filter(long_data, narrativeName!="Lecture1"), select = -narrativeName), names_from = noiseCondition, values_from = Attempt, values_fn = list(Attempt = length))
# #NO: issue is that each pt gets two of a noise condition, rn it sums up both instead of keeping the sums separate
#might have to do this by hand :(


#now to use info from button_presses to get noise info stats

ggplot(data=button_presses, mapping = aes(x=noiseCondition, y=???, fill=noiseCondition)) + geom_boxplot(width=0.2, alpha=0.5)




