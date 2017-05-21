# Most popular airports
table(myDF$Origin)
sort(table(myDF$Origin))
# Look at decreasing order, most popular airport will come first
sort(table(myDF$Origin),decreasing=T)

# Most popular airpot
sort(table(myDF$Origin),decreasing=T)[1]

# Top 10 popular airpot on basis of flight origins
sort(table(myDF$Origin),decreasing=T)[1:10]

# Top 10 popular airpot on basis of flight Destinations
sort(table(myDF$Dest),decreasing=T)[1:10]

dim(myDF)
mostpopular<-names(sort(table(myDF$Origin),decreasing=T)[1:10])
myDF$Origin %in% mostpopular
sum(myDF$Origin %in% mostpopular)
sum(myDF$Origin %in% mostpopular & myDF$Dest %in% mostpopular)

# Total number of originating flights from 200 least popular airports
leastpopular <- sort(table(myDF$Origin))[1:200] 
sum(leastpopular)

dim(myDF)
length(mostpopular)
length(leastpopular)
class(mostpopular)
class(leastpopular)

table(myDF$Origin)[mostpopular]
table(myDF$Origin)[c("SFO","JFK")]
table(myDF$Dest)[c("DCA","IAD")]


# Departure delay
head(myDF$DepDelay < 0)
head(myDF$DepDelay == 0)
head(myDF$DepDelay > 0)

tapply(myDF$DepDelay > 0,myDF$Origin,sum,na.rm=T)
table(myDF$Origin)

# What percentage of flights departed from IND on time or early?
head(myDF$Origin=='IND')
tapply(myDF$DepDelay[myDF$Origin=='IND'] <= 0,myDF$Origin[myDF$Origin=='IND'],sum,na.rm=T) /
table(myDF$Origin[myDF$Origin=='IND'])
28416/42750

v <- table(cut(myDF$DepTime,breaks = seq(0,2400,by=100)))
head(myDF$DepTime/100)
# to get only hour part
head((myDF$DepTime)%%100)
head(((myDF$DepTime-(myDF$DepTime)%%100)/100)*100)
head(ceiling(myDF$DepTime/100))
table(ceiling(myDF$DepTime/100))
w <- table(ceiling(myDF$DepTime/100))
v == w
sum(v == w)
sum(v != w)
plot(v)
plot(w)
# breaking the deperture delay by month
tapply(myDF$DepTime,myDF$Month,length)
t <- tapply(myDF$DepTime,myDF$Month,length)
plot(t)

# breaking the deperture delay by origin
tapply(myDF$DepTime,myDF$Origin,length)
# breaking the deperture delay by origin, month
tapply(myDF$DepTime,list(myDF$Origin,myDF$Month),length)
#Departure time of planes originated from INDIANA and month 'November'
tapply(myDF$DepTime,list(myDF$Origin,myDF$Month),length)['IND',11]
tapply(myDF$DepTime,list(myDF$Origin,myDF$Month),length)['SFO',11] 
# Flights originated from SFO from the month 7 to 11
tapply(myDF$DepTime,list(myDF$Origin,myDF$Month),length)['SFO',7:11]

#  flights departed from ATL, AUS and BDL in Jul-Oct 2008
tapply(myDF$DepTime,list(myDF$Origin,myDF$Month),length)[c('ATL', 'AUS','BDL'),7:10]
#How many flights departed altogether from ATL, AUS, and BDL during the
# months of July 2008 through October 2008?
sum(tapply(myDF$DepTime,list(myDF$Origin,myDF$Month),length)[c('ATL', 'AUS','BDL'),7:10])
#Can you create a table with 3 rows and 12 columns, 
# showing the monthly counts for flights departing from ATL, ORD, and DFW?
tapply(myDF$DepTime,list(myDF$Origin,myDF$Month),length)[c('ATL', 'ORD','DFW'),1:12]
tapply(myDF$DepTime,list(myDF$Origin,myDF$Month),length)[c('ATL', 'ORD','DFW'),]
longDelayDF <- subset(myDF,myDF$DepDelay > 30)
dim(longDelayDF)

# How many flights departed altogether from IND or ORD in 2008 with 
# a delay of more than 30 minutes each?
tapply(longDelayDF$Origin,list(longDelayDF$Origin,longDelayDF$Month),length)[c('IND', 'ORD'),]
sum(tapply(longDelayDF$Origin,list(longDelayDF$Origin,longDelayDF$Month),length)[c('IND', 'ORD'),])


# In which month of 2008 was the percentage 
# of long delays (i.e., flights with more than 30 minute delays) the highest?
M1<-tapply(longDelayDF$Origin,list(longDelayDF$Origin,longDelayDF$Month),length)[c('IND', 'ORD'),]
M2<-tapply(myDF$Origin,list(myDF$Origin,myDF$Month),length)[c('IND', 'ORD'),]
M1/M2
MALL <- tapply(longDelayDF$DepDelay,longDelayDF$Month, length) 
ALLF <- tapply(myDF$DepDelay,myDF$Month, length) 
(sort(MALL/ALLF))

# Breaking departure time into 4 categories 1 - Early Morning (Midnight - 6 AM),
# 2 - Late Morning(6AM - 12PM),3 - Early Evening (12PM - 6PM), 
# 4 - Late Evening (6PM - Midnight)
head(ceiling(myDF$DepTime/600))
head(tapply(ceiling(myDF$DepTime/600), ceiling(myDF$DepTime/600), sum)) 
# Total number of flights each part of the day for the yer 2008
tapply(ceiling(myDF$DepTime/600), ceiling(myDF$DepTime/600), sum)

partsofday <- rep(NA,times=dim(myDF)[1])
v <- ceiling(myDF$DepTime/600)
partsofday[v == 1] <- "Early Morning"
partsofday[v == 2] <- "Late Morning"
partsofday[v == 3] <- "Early Evening"
partsofday[v == 4] <- "Late Evening"
table(partsofday)
length(partsofday)
myDF$timeofday <- partsofday

# How many flights departed from IND early in the morning?
tapply(myDF$Origin,list(myDF$Origin,v),length)['IND',]
tapply(myDF$Origin,list(myDF$Origin,v==1),length)['IND',]

#
tapply(myDF$DepDelay,list(myDF$Origin,myDF$timeofday),length)
tapply(myDF$DepDelay,list(myDF$Origin,myDF$timeofday),length)[c('IND'),]
tapply(myDF$DepDelay,list(myDF$Origin,myDF$timeofday),length)[c('IND','SFO'),]
