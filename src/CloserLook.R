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
