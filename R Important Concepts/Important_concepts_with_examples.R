#Lexical scoping concept demo
#Unlike dynamic environment where the value is assumed from the parent environment, 
#lexical scoping assumes the value of a variable from the environment where the 
#function is defined. 

y<-3
f <- function(x) {
  y <-2
  y ^ 2 + g(x)
}
g <- function(x) {
  x*y
}

f(6)


#You have been assigned to check two race tracks. 
#To complete this task you are expected to find the means of the total time 
#taken by cars to cross the track. In the following data assignment, 
#“b” is the vector of total time taken by different cars and 
#“a” is the vector of track on which this time is taken. 
#The first element of the vector “b” corresponds to the first element of vector 
#“a” (and so on).

a<- c(1,1,1,1,2,2,2,2,2)
b<- c(10,12,15,12, NA, 30, 42, 38,40)

S <- split(b,a)
mean < - lapply(a,mean)
lapply()