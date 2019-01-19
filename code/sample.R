options(digits=3)
options(scipen = 999)
#install.packages("RMark")
library(RMark)

MSUR <- read.table("/Users/alanleach/Documents/Github/mate_survival/lyttleRMark/code/data/sample.txt", header=TRUE, colClasses = 'character',fill = TRUE)
for (i in 3:ncol(MSUR)){
  MSUR[,i] <- as.numeric((MSUR[,i]))
}
MSUR$sex <- as.factor(as.character(MSUR$sex))
#######################################################
# process data
#######################################################
time.intervals = c(0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1)
MSUR.data <- process.data(MSUR, model="RDBarkHug", begin.time = 1990, time.intervals = time.intervals,groups=c('sex'))
MSUR.ddl <- make.design.data(MSUR.data, remove.unused = FALSE)
###SETS UP TIME VARIATION CONSTRAINTS Survival rates
MSUR.ddl$S$Stime<-0
for (i in 1:nrow(MSUR.ddl$S)){
  if(MSUR.ddl$S$Time[i]>=0 & MSUR.ddl$S$Time[i]<=23)  MSUR.ddl$S$Stime[i]  <- MSUR.ddl$S$Time[i] 
  if(MSUR.ddl$S$Time[i]>=24 & MSUR.ddl$S$Time[i]<=25) MSUR.ddl$S$Stime[i]  <- 24
  
}
MSUR.ddl$S$Stime <- as.factor(as.character(MSUR.ddl$S$Stime))
###SETS UP TIME VARIATION CONSTRAINTS reporting rates
MSUR.ddl$r$rtime<-0
for (i in 1:nrow(MSUR.ddl$r)){   
  if(MSUR.ddl$r$Time[i]>=0 & MSUR.ddl$r$Time[i]<=23)   MSUR.ddl$r$rtime[i]  <- MSUR.ddl$r$Time[i] 
  if(MSUR.ddl$r$Time[i]>=24 & MSUR.ddl$r$Time[i]<=25)  MSUR.ddl$r$rtime[i]  <- 24
  
}
MSUR.ddl$r$rtime <- as.factor(as.character(MSUR.ddl$r$rtime))

##Makes 1991 the intercept (reference level) for the capture probabilities 
MSUR.ddl$p$session=relevel(MSUR.ddl$p$session,"1991")

do.RDBarkHug=function()
  
{
  
  #######################################################
  # specify parameters
  #######################################################
  S.dot=list(formula=~1)
  
  r.dot=list(formula=~1)
  #r.t=list(formula=~1+time)
  
  R.dot=list(formula=~1)
  #R.T=list(formula=~1+time, fixed = list(time=c(2015),value=0))
  
  RPrime.fixed=list(formula=~1, fixed=0)
  
  aDoublePrime.dot.=list(formula=~ 1)
  
  aPrime.dot=list(formula=~1)
  #aPrime.0=list(formula=~1+sex)
  
  F.dot=list(formula=~1)
  #F.G=list(formula=~1+sex)
  
  p.dot=list(formula=~ 1+session+time)
  #p.T=list(formula=~ 1+session+time)
  
  c.dot = list(formula=~1)
  #c.s = list(formula=~1+session)
  
  cml=create.model.list("RDBarkHug")
  return(mark.wrapper(cml,data=MSUR.data,ddl=MSUR.ddl))
  
}
MSUR.results=do.RDBarkHug()
##AGL change
