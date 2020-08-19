
  #this one doesn't just do a normal histogram; it only counts each participant once
  #FIX ME
  long = filter(reaction_time, narrativeName=="Narrative2" & noiseCondition=="quiet")
  long$Reaction.Time = as.numeric(long$Reaction.Time)/1000
  length = durations$duration[durations$narrative=="Narrative2" & durations$noise.condition=="quiet"]
  size_bins = 5;
  num_bins = length/size_bins;
  #make dataframe with 1 or 0 for each participant for each bin (to use in histogram)
  num_pts = length(unique(long$Participant.Private.ID));
  presses = matrix(ncol=2, nrow=num_pts*(num_bins+1));
  colnames(presses) <- c("Participant.Private.ID","press")
  iteration = 1;
  for(pt in unique(long$Participant.Private.ID)){
    for(time in 0:num_bins-1){
      start_sec = time*size_bins;
      end_sec = time*size_bins+size_bins;
      has_click = FALSE;
      for(rt in long$Reaction.Time[long$Participant.Private.ID==pt]){#this takes a lot of extra time :/
        if(rt>=end_sec){#went past our window so leave
          break;
        }
        if(rt>=start_sec){
          has_click = TRUE;
        }
      }
      presses[iteration,"Participant.Private.ID"] = pt;
      if(has_click){
        if(start_sec==0){
          presses[iteration,"press"] = 1;
        }
        else{
          presses[iteration,"press"] = start_sec;
        }
      }
      else{
        presses[iteration,"press"] = 0;
      }
      iteration = iteration+1;
    }
  }
  presses = data.frame(presses);
  presses = filter(presses, press!=0);
  
  title = paste0("Button Presses for all Participants for Narrative ",gsub("[[:alpha:]]", "", "Narrative2")," in ","quiet")
  subtitle = "Each participant only counted once per box"
  hist(presses$press, main=title, sub=subtitle, xlab="Time (seconds)", xlim=c(0,length+50), breaks=num_bins)
