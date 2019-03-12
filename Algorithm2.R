numRegions <- 6
numRegions <- numRegions + 6 #do not remove this line
numRep     <- 20             #do not change

#create the generator function
indVec <- 1 : numRegions
tmpVec <- rep(0,numRegions)
sumVec <- rep(0,numRegions)
for (ind in 1:numRep){
  smpInd <- sample(indVec,round(0.1*numRegions))
  tmpVec[smpInd] <- runif(1)
  sumVec <- sumVec + tmpVec
}
flt <- c(0,0,1.5, 3 ,1.5,0,0)/6    #do not change
funGen <- convolve(tmpVec, flt, type = 'filter')
funGen <- funGen/max(funGen*1.2)


#create the subjects
numSubjects <- 200
subjects <- matrix(rep(0,(numRegions-6)*numSubjects), nrow=numSubjects)

for (indSub in 1:numSubjects){
  for (indRegion in 1:(numRegions-6)){
    subjects[indSub,indRegion] <- rbinom(1,1,funGen[indRegion])
  }
}


#write the data base of the subjects
write.csv(subjects)