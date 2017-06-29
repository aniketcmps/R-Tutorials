# this tutorial is about linear regression
data <- read.csv("USOpenFinals_2016.csv")
View(data)

Y<-data$winner_totalPointWon
X<-data$loser_totalPointWon

rg<-lm(X ~ Y)
summary(rg)
plot(X ~ Y, main="Linear Regression")
abline(rg,col="green")

# lm(formula, data)
# formula: will contain the model specification formula between the two vectors like 
# winner_totalPointWon ~ loser_totalPointWon
# data: the data frame (table) whose vectors we use in the formula
with(data,plot(winner_totalPointWon,loser_totalPointWon))
p=lm(formula = winner_totalPointWon~loser_totalPointWon, data = data)
p
plot(winner_totalPointWon~loser_totalPointWon,data=data,main="linear Regression")
abline(p,col="red")
