options(digits=3)
options(scipen = 999)
#install.packages("RMark")
library(RMark)
install.packages("doParallel") ### install package in dockerfile
install.packages("dplyr")  ### install package in dockerfile
library(doParallel)

MSUR <- read.table("/Users/alanleach/Documents/Github/mate_survival/lyttleRMark/code/data/sample.txt", header=TRUE, colClasses = 'character',fill = TRUE)
#MSUR <- read.table("kitematic/sample/data/sample.txt", header=TRUE, colClasses = 'character',fill = TRUE)

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

##creates a list of models to run
model_list = list(list(S=list(formula=~1),
                       r=list(formula=~1),
                       R=list(formula=~1),
                       RPrime=list(formula=~1, fixed=0),
                       aDoublePrime=list(formula=~ 1),
                       aPrime=list(formula=~1),
                       F=list(formula=~1),
                       p=list(formula=~ 1+time),
                       c = list(formula=~1)),
                 
                   list(S=list(formula=~1),
                        r=list(formula=~1),
                        R=list(formula=~1),
                        RPrime=list(formula=~1, fixed=0),
                        aDoublePrime=list(formula=~ 1),
                        aPrime=list(formula=~1),
                        F=list(formula=~1),
                        p=list(formula=~ 1+time),
                        c = list(formula=~1+session)))
 
### runs mark models in parallel
no_cores <- detectCores() - 1  
cl <- makeCluster(no_cores, type="FORK")  
registerDoParallel(cl)  
system.time(result_par <- foreach(i=1:length(model_list)) %dopar% mark(MSUR.data,ddl=MSUR.ddl,
                                                                       model.parameters = model_list[[i]],brief = FALSE,invisible = TRUE,threads=7))
##user  system elapsed 
##0.579   1.683 337.707 ##run time for parallel on AGL's CPU

##collects and compares models
m1<-result_par[[1]]
m2<-result_par[[2]]
collect.models()
identical(m1,m2)


system.time(test_mark <- mark(MSUR.data,ddl=MSUR.ddl,
                              model.parameters = list(S=list(formula=~1),r=list(formula=~1),R=list(formula=~1),
                                                      RPrime=list(formula=~1, fixed=0),aDoublePrime=list(formula=~ 1),
                                                      aPrime=list(formula=~1),F=list(formula=~1),
                                                      p=list(formula=~ 1+time),c = list(formula=~1)),brief = FALSE,invisible = TRUE))
#user  system elapsed 
#96.18    0.34   30.79 ##run time for test_mark on AGL's CPU
system.time(test_mark2 <- mark(MSUR.data,ddl=MSUR.ddl,
                               model.parameters = list(S=list(formula=~1),
                                                       r=list(formula=~1),
                                                       R=list(formula=~1),
                                                       RPrime=list(formula=~1, fixed=0),
                                                       aDoublePrime=list(formula=~ 1),
                                                       aPrime=list(formula=~1),
                                                       F=list(formula=~1),
                                                       p=list(formula=~ 1+time),
                                                       c = list(formula=~1+session)),brief = TRUE,invisible = TRUE))

##1091.46    2.74  294.45 ##run time for test_mark2 on AGL's CPU