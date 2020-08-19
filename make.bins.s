# Based on exp5/make_bins.s from Stanford

# In this version, I'm trying to use a more reasonable data structure
# than in the original.
# jmz 1/14/97

# Adapted for WU jmz 3/1/01
# Modified to keep track of timepoint 1/11/05 jmz
# Adapted for exp 41 2/19/04
# Fixed floor/ceiling bug, 4/5/04
# Adpated for exp70 jmz cak 10/18/07
# adapted for e77 cak 03/21/08
# adapted for e80 cak 02/10/10
# Adapted for e109 jmz sf 4/2/14
# Adapted for e119 sf 10/15/14
# Adapated for e126 sf 03/03/15

make.bins <- function(raw, binsize) {
    
    durations <-  list(Breakfast=329.06, Party=376.07, WL_DV=354.02, Library=249.0)
    
    WorkerID <- numeric()
    Movie <- character()
    Bins <- numeric()
    Time <- numeric()

    for (subj in levels(raw$WorkerID)) {
        cat(subj," ",sep="")
        for (mov in levels(raw$Movie)) {
            len <- ceiling(durations[[mov]]*1000/binsize)
            rawindex <- raw$WorkerID == subj & raw$Movie == mov & raw$MS < durations[[mov]] * 1000
            if (sum(rawindex) > 0) {
                index <- (length(Bins)+1):(length(Bins)+len)
                WorkerID[index] <- subj
                Movie[index] <- mov
                tmpbins <- rep(0,len)
                for (i in raw$MS[rawindex]) {
                                        # tmpbins[floor(i/binsize)] <- 1
                    tmpbins[ceiling(i/binsize)] <- 1
                }
                                        # cat(len,length(tmpbins),"\n")
                Bins[index] <- tmpbins
                Time[index] <- 1:len
            }
        }
    }
    Movie <- factor(Movie)
    return(data.frame(WorkerID,Movie,Bins,Time))
}
  
