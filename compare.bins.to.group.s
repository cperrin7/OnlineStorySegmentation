# Compare each person's segmentation to that of the group as a whole, for each movie.
# Compare coarse to coarse and fine to fine.
# Use correlations and differences in group proportions between individual BPs & non-BPs.

#Jesse's note - PropDiff = calculate mean, across all bins in which an individual segments, proportion of entire sample segmenting in those bins.
#Do same for bins in which they did NOT segment.  subtract latter from former to get measure of agreement

# These are equivalent, but the difference scores are better for subsequent tests
# because they're normally distributed.

# Weight the three groups equally, correcting for differences in sample size
# This actually favors the smaller group, because people in the smaller group get
# overweighted in the average.  Better than favoring the larger groups, I guess.  In the
# end we'll have equal sample sizes and its moot.

# jmz 6/9/04

# Modified to scale each person's score based on the highest and lowest possible
# given the number of BPs they had.

# jmz 12/18/07

# Adapted for e109 jmz sf 4/2/14
# Adapted for e119 sf 10/16/14
# Adapated for e126 sf 03/03/15

compare.bins.to.group <- function(bins, bphst) {
    WorkerID <-  numeric(0)
    Movie <- numeric(0)
    Cor <- numeric(0)
    CorZ <- numeric(0)
    ScaledCor <- numeric(0)
    PropDiff <- numeric(0)

    bphst$Time <- as.numeric(as.character(bphst$Time))
    
    for (mov in levels(bins$Movie)) {
        cat("Doing", mov,"\n")
                                        # hist <- tapply(bins$Bins[bins$Movie == mov & bins$Grain == grn], bins$Time[bins$Movie == mov & bins$Grain == grn], safe.mean)
        hist <- bphst$Proportion[bphst$Movie == as.character(mov) & !is.na(bphst$Proportion)]
        # quartz ()
        # print (plot (hist,type="l"))
                                        # Calculate best and worst possible correlations for each number of BPs
        bestcor <- worstcor <- rep(NA, length(hist))
        decreasing <- order(hist, decreasing=T)
        increasing <- order(hist)
        bestbps <- worstbps <- rep(0, length(hist))
        for (i in 1:(length(hist)-1)) {
            bestbps[decreasing[i]] <- 1
            worstbps[increasing[i]] <- 1
            bestcor[i] <- cor(hist, bestbps)
            worstcor[i] <- cor(hist, worstbps)
        }
        
        for(sub in levels(bins$WorkerID)) {
            index <- bins$Movie == mov & bins$WorkerID == sub
            if (sum(index) > 0) { 
                WorkerID <- c(WorkerID, sub)
                Movie <- c(Movie, mov)
                if (sum(is.na(bins$Bins[index])) == 0) {
                    thecor <- cor(hist, bins$Bins[index], use="complete.obs")
                    Cor <- c(Cor, thecor)
                    CorZ <- c(CorZ, atanh(thecor))
                    NBPs <- sum(bins$Bins[index], na.rm=T)
                    ScaledCor <- c(ScaledCor, (thecor-worstcor[NBPs])/(bestcor[NBPs]-worstcor[NBPs]))
                    PropDiff <- c(PropDiff,mean(hist[bins$Bins[index] == 1]) - mean(hist[bins$Bins[index] == 0]))
                } else {
                    Cor = c(Cor, NA)
                    CorZ = c(CorZ, NA)
                    PropDiff = c(PropDiff, NA)
                }
            }
        }
    }

    WorkerID <- factor(WorkerID, levels=levels(bins$WorkerID))
    Movie <- factor(Movie, levels=levels(bins$Movie))
    result <- data.frame(WorkerID, Movie, Cor, CorZ, ScaledCor, PropDiff)
    result <- result[order(WorkerID, Movie),]

    return(result)
}
