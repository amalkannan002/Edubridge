# vaccination data:

library(ggplot2)
library(dplyr)
library(choroplethr)
library(choroplethrMaps)
library(openintro)
library(tidyverse)
library(scales)
library(corrgram)
print(getwd)

# read the dataset named vaccination data
d<-read.csv("C:/Users/harisankar k/Desktop/vaccination_data.csv")
print(d)

# print head and tail rows
print(head(d))
print(tail(d))

# summary of the dataset
print(summary(d))
print(summary(d$Total.Cases))
plot(d$Total.Cases)

# dimention of dataset
print(dim(d))

# column names of the dataset
print(names(d))

# details of death
print(d$Deaths)

# length of the dataset
print(length(d$Active))

# structure of the dataset
print(str(d))

# glimpse of the dataset
print(glimpse(d))



#  check unique values
print(unique(d))


# statistical values
print(is.na(d))
print(is.data.frame(d))
print(is.name(d))
print(ncol(d))
print(nrow(d))
print(max(d$Active))
print(min(d$Active))
print(sort(d$Active))
print(which.max(d$Active))
print(which.min(d$Active))
print(mean(d$Active))
print(mean(d$Active,trim=0.10))
print(var(d$Active))
print(median(d$Active))
print(mad(d$Active))# mean absolute division
print(sd(d$Active))
print(mode(d$Active))
print(range(d$Active))
print(scale(d$Active))
print(sd(d$Total.Cases/sqrt(length(d$Active))))
print(max(d$Total.Cases-min(d$Active)))
print(quantile(d$Active))
print(quantile(d$Active,c(0.75)))
print(IQR(d$Active))
print(t.test(d$Active))

# data visualisation


# plotting of total cases
plot(d$Total.Cases,col="red",xlab="X-axis",ylab="Y-axis",main="total cases")


# plotting of total vaccination doses
plot(d$Total.vaccination.doses,col="red",xlab="X-axis",ylab="Y-axis",main="total vaccination doses taken")


# fisrt dose and second dose vaccination
plot(x=d$Dose.1,y=d$Dose.2,main="first and second dose vaccines",xlab="dose1",ylab="dose2",col="blue")


# geographical plot of states releated to total cases
statewise_totalcase=d %>% group_by(State) %>% summarise(Total.Cases)
View(statewise_totalcase)


# geographical plot of states releated to active cases
statewise_activecases=d %>% group_by(State) %>% summarise(Active)
View(statewise_activecases)



# statewise total vaccination
statewise_vaccination=d %>% group_by(State) %>% summarise(Total.vaccination.doses) %>% arrange((desc
                                                                                (Total.vaccination.doses)))
View(statewise_vaccination)


# statewise vaccination details(dose1 and dose2)
statewise_vaccination_doses=d %>% group_by(State) %>% summarise(Dose.1,Dose.2) 
View(statewise_vaccination_doses)


# statewise covid details(total,active and discharged cases)
statewise_details=d %>% group_by(State) %>% summarise(Total.Cases,Active,Discharged) 
View(statewise_details)


# statewise dose 1 vaccination using ggplot
statewisedose1=ggplot(d,aes(x=Dose.1,y=State,fill=Dose.1))+geom_col()
print(statewisedose1)


# statewise dose 2 vaccination using bargraph
statewisedose2=ggplot(d,aes(x=Dose.2,y=State,fill=Dose.2))+geom_col()
print(statewisedose2)


# statewise total vaccination doses  using scatter plot
statewisetotalvaccination=ggplot(d,aes(x=Total.vaccination.doses,y=State,fill=Total.vaccination.doses))+geom_point()
print(statewisetotalvaccination)



# statewise total cases using scatter plot
statewisetotalcases=ggplot(d,aes(x=Total.Cases,y=State,fill=Total.Cases))+geom_point()
print(statewisetotalcases)



# statewise active cases in dotplot
statewiseactivecases=ggplot(d,aes(x=Active,y=State,fill=Active))+geom_jitter()
print(statewiseactivecases)



# active cases compared to total cases using lineplot
totalcases=ggplot(d,aes(x=Active,y=Total.Cases,fill=Active))+geom_line()
print(totalcases)



# statewise active cases using boxplot
totalcases=ggplot(d,aes(x=Active,y=State,fill=Active),size=3.0)+geom_boxplot()
print(totalcases)



# active cases compared to total cases using barplot
vaccination<-table(d$Active,d$Total.Cases)
barplot(vaccination,main='active cases compared to total cases',xlab='totalcases',ylab='active')


# discharged static  using histogram
hist(d$Discharged,col='steelblue',main='discharged patients',xlab='discharged')


# plotting active cases vs the total cases:
print(plot(Active~Total.Cases,data=d))


# linear regression:
lr=lm(Active~Total.Cases,data=d)
print(lr)

summary(lr)

par(mfrow=c(1,1))
plot(lr)


i<-ggplot(d,aes(x=Active,y=Total.Cases))+geom_point()
print(i)

i<-i+geom_smooth(method="lm",col="blue")
print(i)