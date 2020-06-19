##Summarize number of Button Presses per condition for Online Story Segmentation
#Author: Cameron Perrin, cperrin@wustl.edu

# Summarize so you still have a long format, but one row per subject per condition (keep which story).
# Then you can summarize/plot so that we have # button presses coded by each acoustic condition
if(!require("dplyr")) install.packages("dplyr"); library(dplyr)
if(!require("ggplot2")) install.packages("ggplot2"); library(ggplot2)
if(!require("tidyverse")) install.packages("tidyverse");library(tidyverse)
if(!require("patchwork")) install.packages("patchwork");library(patchwork)

##load data (change file path if not me)
messy_data = read.csv("C:/Users/CKPer/Box/WashU/Peelle Lab/Story Segmentation/Online Sona data/gorilla data_long version/data_exp_15568-v3_questionnaire-jthw.csv")

