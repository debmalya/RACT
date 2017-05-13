Last login: Sat May 13 17:38:18 on ttys000
Debmalyas-MBP-2:RACT debmalyajash$ cd ~/git/RACT
Debmalyas-MBP-2:RACT debmalyajash$ cd src
Debmalyas-MBP-2:src debmalyajash$ ls -lart
total 24
-rw-r--r--@ 1 debmalyajash  staff    85 May 10 18:19 Welcome.R
-rw-r--r--  1 debmalyajash  staff  3753 May 13 22:41 tApplyFunctions.R
-rw-r--r--  1 debmalyajash  staff  2292 May 13 22:41 IndyFlights.R
drwxr-xr-x  5 debmalyajash  staff   170 May 13 22:41 .
drwxr-xr-x  9 debmalyajash  staff   306 May 13 22:41 ..
Debmalyas-MBP-2:src debmalyajash$ vi tApplyFunctions.R











































# introduction of tapply function
# R has many apply functions
myDF <- read.csv("/Users/debmalyajash/git/RACT/data/2008.csv")

# how to apply tapply function
# 1. Vector on which functin will work
# 2. Way to break up data into pieces
# 3. The function we want to apply to the data
tapply(myDF$DepDelay, myDF$Origin, mean)

# above one will take 'NA' value also how to ignore 'NA' values
tapply(myDF$DepDelay, myDF$Origin, mean, na.rm=TRUE)

# with lowest average departure delay
head(sort(tapply(myDF$DepDelay, myDF$Origin, mean, na.rm=TRUE)))

# with highest average departure delay
tail(sort(tapply(myDF$DepDelay, myDF$Origin, mean, na.rm=TRUE)))

# with longest average arrival delay
head(sort(tapply(myDF$ArrTime , myDF$Dest, mean, na.rm=TRUE)))

# with longest average arrival delay
tail(sort(tapply(myDF$ArrTime , myDF$Dest, mean, na.rm=TRUE)))

# When considering all flights to an airport, take an average of the distances (in miles)
# of the flights to that airport. Suppose that we do such an analysis of all airports.
# Which airport has the longest average distance of flights (in miles) arriving to that
# airport?
tail(sort(tapply(myDF$Distance, myDF$Dest, mean)))

# smallest distance
head(sort(tapply(myDF$Distance, myDF$Dest, mean)))

# Average arrival delay weekday wise (1- Monday and so on)
tapply(myDF$ArrDelay,myDF$DayOfWeek,mean,na.rm=TRUE)
plot(tapply(myDF$ArrDelay,myDF$DayOfWeek,mean,na.rm=TRUE))

# Average arrival delay weekday wise (1- Monday and so on) for Indianopolis
tapply(myDF$ArrDelay[myDF$Dest=='IND'],myDF$DayOfWeek[myDF$Dest=='IND'],mean,na.rm=TRUE)


plot(table(round(tapply(myDF$DepDelay, myDF$Origin, mean, na.rm = TRUE))))
plot(round(tapply(myDF$DepDelay, myDF$Origin, mean, na.rm = TRUE)))
plot(tapply(myDF$DepDelay, myDF$Origin, mean, na.rm=TRUE))
# The abline function draws a horizontal line across the plot.
abline(h=mean(tapply(myDF$ArrDelay, myDF$DayOfWeek, mean, na.rm=TRUE)))

myTable2 <- table(list(myDF$Origin,myDF$Dest,myDF$Year,myDF$Month))

# which airlines have the best average arrival delay
head(sort(tapply(myDF$ArrDelay,myDF$UniqueCarrier,mean, na.rm=TRUE)))
# which airlines have the worst average arrival delay

# which airlines have the best average arrival delay
head(sort(tapply(myDF$ArrDelay,myDF$UniqueCarrier,mean, na.rm=TRUE)))
# which airlines have the worst average arrival delay
tail(sort(tapply(myDF$ArrDelay,myDF$UniqueCarrier,mean, na.rm=TRUE)))

# Which month have most of the flight
table(myDF$Month)
tapply(myDF$Month,myDF$Month,length)
sort(table(myDF$Month))

# Which airline has the worst average departure delay?
tail(sort(tapply(myDF$DepDelay,myDF$UniqueCarrier,mean,na.rm=TRUE)),1)

# Which airline has the best average departure delay?
head(sort(tapply(myDF$DepDelay,myDF$UniqueCarrier,mean,na.rm=TRUE)),1)

# On which day of the month Dec were the average departure delays the worst?
myDate<-paste(myDF$Month,myDF$DayofMonth,myDF$Year,sep="/")
length(myDate)
length(myDF$DayofMonth)
sort(tapply(myDF$ArrDelay,myDate,mean,na.rm=TRUE))
tail(tapply(myDF$ArrDelay,myDate,mean,na.rm=TRUE),1)
head(tapply(myDF$ArrDelay,myDate,mean,na.rm=TRUE),1)
sort(tapply(myDF$ArrDelay[myDF$Month==12],myDate[myDF$Month==12],mean,na.rm=TRUE))

# On which day of the year were the average departure times the worst for flights departing from O’Hare (ORD)?
sort(tapply(myDF$ArrDelay[myDF$Month==12 & myDF$Origin=='ORD'],myDate[myDF$Month==12 & myDF$Origin=='ORD'],mean,na.rm=TRUE))


#Average Delays by flight path
## Vectors dest = 'IND' and origin 'ORD'
ord2ind <- myDF$Dest == 'IND' & myDF$Origin == 'ORD'
sort(tapply(myDF$ArrDelay[ord2ind],myDate[ord2ind],mean,na.rm=TRUE))


# Consider flights that departed from ATL and landed at LAX in 2008.
#For how many days of the year were the average departure delays more than 90 minutes?
atl2lax = myDF$Dest== 'LAX' & myDF$Origin == 'ATL'
sort(tapply(myDF$DepDelay[atl2lax],myDate[atl2lax],mean,na.rm=TRUE))
