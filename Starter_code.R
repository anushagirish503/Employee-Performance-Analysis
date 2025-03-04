####################################################################
#Welcome to the Starter code for your People Analytics TEAM Report

#-----------------------------------------
#UNIT:        People Analytics (HRMT5502)
#TASK:        Starter Code for TEAM Report (30%)
#DESCRIPTION: Predicting Customer Satisfaction and Business Performance
#DATA:        Kenexa.csv
#AUTHOR:      Catherine Leighton 
#-----------------------------------------

############ WARNING ####################
#Below is the starter code for your team report. 
#Some of it will be useful (but not all of it).
#You will need to add to, and adjust, this code to complete your project.
#Note there may be errors and parts missing. 
#Be careful as you work through this code.

#########################################

rm(list=ls())
setwd(choose.dir())
getwd()

#-----------------------------------------
#SETUP & GLOBAL SETTINGS
#-----------------------------------------
# Here we are trying to keep the number of packages to a minimum

install.packages("GGally", "ggpubr", "ggplot2", "corrplot", "corrgram", "QuantPsyc", "Hmisc", "psych")

library(GGally)
library(ggpubr)
library(ggplot2)
library(corrplot)
library(corrgram)
library(QuantPsyc)
library(Hmisc)
library(psych) #it is important that the psych package is loaded last


kenexa <- read.csv(paste("Kenexa.csv", sep=""))

head(kenexa)
tail(kenexa)

##look at the structure of the data
str(kenexa)
kenexa$bloc #int
kenexa$ccon #int

#change to character
kenexa$bloc <- as.character(kenexa$bloc, 
                                 levels = c(0,1),
                                 labels = c("non-metro","metro"))
kenexa$ccon <- as.character(kenexa$ccon,
                                  levels = c(0,1),
                                  labels = c("less frequent","more frequent"))
str(kenexa)

summary(kenexa) 
sapply(kenexa, function(x) sum(is.na(x))) #checking for missing values

#descriptive statistics for all variables
describe(kenexa)
describe(kenexa~bloc)
describe(kenexa~ccon)

#simple histogram for Employee Customer Orientation with normal curve overlay
ggplot(kenexa, aes(ecuso)) +
  geom_histogram(aes(y=..density..), binwidth = 0.1) + stat_function(fun=dnorm, args=list(mean = mean(kenexa$ecuso), sd =sd(kenexa$ecuso)), col="#1b98e0", size=1)

#simple histogram for Customer Loyalty with normal curve overlay
ggplot(kenexa, aes(cloy)) +
  geom_histogram(aes(y=..density..), binwidth = 0.1) + stat_function(fun=dnorm, args=list(mean = mean(kenexa$cloy), sd =sd(kenexa$cloy)), col="#1b98e0", size=1)

#simple histogram for Overall Branch Productivity with normal curve overlay
ggplot(kenexa, aes(prod)) +
  geom_histogram(aes(y=..density..), binwidth = 20) + stat_function(fun=dnorm, args=list(mean = mean(kenexa$prod), sd =sd(kenexa$prod)), col="#1b98e0", size=1)

#Correlation matrix for all numeric variables including p-values
correlation.matrix<-rcorr(as.matrix(kenexa[,4:21]))
correlation.matrix

#Fancy correlation plots
corrplot<-corrplot(corr=cor(kenexa[ , c(4:18)], use="complete.obs"), 
                          method ="ellipse")


correlations.plot <- corrplot(corr=cor(kenexa[ , c(4:18)], use="complete.obs"), 
                          method="number")

# display a pair plot for multiple columns of data
GGally::ggpairs(kenexa[,5:15])

#Corrgram of all the variables

corrgram(kenexa, order=TRUE,
         main="Corrgram of all the Variables",
         lower.panel=panel.shade, upper.panel=panel.pie,
         diag.panel=panel.minmax, text.panel=panel.txt) 

#Scatterplots
plot1a<-ggscatter(kenexa, x = "einvol", y = "eeng",
          add = "reg.line", conf.int = TRUE,
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Employee Involvement", ylab = "Employee Engagement")
plot1a

plot1b<-ggscatter(kenexa, x = "etra", y = "eeng",
                 add = "reg.line", conf.int = FALSE,
                 cor.coef = TRUE, cor.method = "pearson",
                 xlab = "Employee Training", ylab = "Employee Engagement")
plot1b

plot2a<-ggscatter(kenexa, x = "eteam", y = "cloy",
                  add = "reg.line", conf.int = FALSE,
                  cor.coef = TRUE, cor.method = "pearson",
                  xlab = "Employee Teamwork", ylab = "Customer Loyalty")
plot2a

plot2b<-ggscatter(kenexa, x = "ecomm", y = "cloy",
                  add = "reg.line", conf.int = TRUE,
                  cor.coef = TRUE, cor.method = "pearson",
                  xlab = "Employee Communication", ylab = "Customer Loyalty")
plot2b

plot3a<-ggscatter(kenexa, x = "cloy", y = "prod",
                 add = "reg.line", conf.int = TRUE,
                 cor.coef = TRUE, cor.method = "pearson",
                 xlab = "Customer Loyalty", ylab = "Overall Branch Productivity")
plot3a

plot3b<-ggscatter(kenexa, x = "cloy", y = "teltr",
                 add = "reg.line", conf.int = FALSE,
                 cor.coef = TRUE, cor.method = "pearson",
                 xlab = "Customer Loyalty", ylab = "Teller Productivity")
plot3b

#Regression Predicting Customer Satisfaction-Personal Bankers with some Branch Factors {branch size) and some Employee Factors {quality, involvement, teamwork, engagement, communcation}

###########################################################################

X_1 <- lm(eteam ~ ecuso + equal + etra + einvol, data = kenexa)
summary(X_1)
coef(X_1)
X_1$coefficients
residuals(X_1)
lm.beta(X_1)



X_2 <- lm(ecomm ~ ecuso + equal + etra + einvol, data = kenexa)
summary(X_2)
coef(X_2)
X_2$coefficients
residuals(X_2)
lm.beta(X_2)


X_3 <- lm(eeng ~ ecuso + equal + etra + einvol, data = kenexa)
summary(X_3)
coef(X_3)
X_3$coefficients
residuals(X_3)
lm.beta(X_3)



X_4 <- lm(eitl ~ ecuso + equal + etra + einvol, data = kenexa)
summary(X_3)
coef(X_3)
X_3$coefficients
residuals(X_3)
lm.beta(X_3)



summary(X_1)
summary(X_2)
summary(X_3)
summary(X_4)



###########################################################################


Y_1_a <- lm(cbr ~ eteam + ecomm + eeng + eitl + ecuso + equal + etra, data = kenexa)
summary(Y_1_a)
coef(Y_1_a)
Y_1_a$coefficients
residuals(Y_1_a)
lm.beta(Y_1_a)


Y_1_b <- lm(cbr ~ eteam + ecomm + eeng + eitl , data = kenexa)
summary(Y_1_b)
coef(Y_1_b)
Y_1_b$coefficients
residuals(Y_1_b)
lm.beta(Y_1_b)



summary(Y_1_a)
summary(Y_1_b)



Y_2_a <- lm(cloy ~ eteam + ecomm + eeng + eitl + ecuso + equal + etra, data = kenexa)
summary(Y_2_a)
coef(Y_2_a)
Y_2_a$coefficients
residuals(Y_2_a)
lm.beta(Y_2_a)


Y_2_b <- lm(cloy ~ eteam + ecomm + eeng + eitl , data = kenexa)
summary(Y_2_b)
coef(Y_2_b)
Y_2_b$coefficients
residuals(Y_2_b)
lm.beta(Y_2_b)



summary(Y_2_a)
summary(Y_2_b)



Y_3_a <- lm(cserq ~ eteam + ecomm + eeng + eitl + ecuso + equal + etra, data = kenexa)
summary(Y_3_a)
coef(Y_3_a)
Y_3_a$coefficients
residuals(Y_3_a)
lm.beta(Y_3_a)


Y_3_b <- lm(cserq ~ eteam + ecomm + eeng + eitl , data = kenexa)
summary(Y_3_b)
coef(Y_3_b)
Y_3_b$coefficients
residuals(Y_3_b)
lm.beta(Y_3_b)



summary(Y_3_a)
summary(Y_3_b)






Y_3 <- lm(cserq ~ eteam + ecomm + eeng + eitl, data = kenexa)
summary(Y_3)
coef(Y_3)
Y_3$coefficients
residuals(Y_3)
lm.beta(Y_3)

summary(Y_1)
summary(Y_2)
summary(Y_3)





###########################################################################


Z_1 <- lm(prod ~ cbr + cloy + cserq + equal + ecomm, data = kenexa)
summary(Z_1)
coef(Z_1)
Z_1$coefficients
residuals(Z_1)
lm.beta(Z_1)






#Regression Predicting Customer Satisfaction-Personal Bankers with some Branch Factors {branch size) and some Employee Factors {quality, involvement, teamwork, engagement, communcation}

regr1 <- lm(cbrpb ~ bloc + equal + einvol + eteam + eeng + ecomm, data = kenexa)
summary(regr1)
coef(regr1)
regr1$coefficients
residuals(regr1)
lm.beta(regr1)

#Regression Predicting Customer Loyalty with some Employee Factors {quality, involvement, teamwork, engagement, communcation} and some Customer Factors {customer satisfaction}
regr2 <- lm(cloy ~ equal + einvol + eteam + eeng + ecomm +cserq + cbrtel + cbr + cbrpb, data = kenexa)
summary(regr2)
coef(regr2)
regr2$coefficients
residuals(regr2)
lm.beta(regr2)

#Regression Predicting Overall Branch Productivity with some Employee Factors {quality, involvement, teamwork, engagement, communcation} and some Customer Factors {customer satisfaction, customer loyalty}
regr3 <- lm(prod ~ equal + einvol + eteam + eeng + ecomm + cserq + cbrtel + cbr + cbrpb + cloy, data = kenexa)
summary(regr3)
coef(regr3)
regr3$coefficients
residuals(regr3)
lm.beta(regr3)

#Regression Predicting Teller Productivity with some Employee Factors {quality, involvement, teamwork, engagement, communcation} and some Customer Factors {customer satisfaction, customer loyalty}
regr4 <- lm(teltr ~ equal + einvol + eteam + eeng + ecomm + cserq + cbrtel + cbr + cbrpb + cloy, data = kenexa)
summary(regr4)
coef(regr4)
regr4$coefficients
residuals(regr4)
lm.beta(regr4)

#Regression Predicting Employee Engagement with some Branch Factors {branch size) and some Employee Factors {quality, teamwork, communcation} and some Customer Factors {customer loyalty}
regr5 <- lm(eeng ~ bloc + equal + eteam + ecomm + cloy, data = kenexa)
summary(regr5)
coef(regr5)
regr5$coefficients
residuals(regr5)
lm.beta(regr5)

#Now it's your turn. 
#You will need to.... 
        #adjust the R code above
        #write new R code
        #test other regression models
        #discern which output is important and which is not
        #test your logic model!

#All the best, Catherine :-) 