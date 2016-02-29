
## Control Structures
# if-else constructs
x <- 3
y <- 0

if (x > 3) {
  y<- 10
}


y <- if (x>3){
  10
  } else {
  0
  }

y

#for loop

for (i in 1:10){
  print(i)
}

x <- c("a","b","c","d")

for (i in 1:4){
  print(x[i])
}

for (i in seq_along(x)){
  print(x[i])
}
# seq_along creates an interger vector equal to the length of the input vector, in this case: x

for (letter in x){
  print(letter)
}

#nested for loop

x <- matrix(1:6, 2,3)

for (i in seq_len(nrow(x))) {
  for (j in seq_len(ncol(x))){
    print(x[i,j])
  }
}


coin <- rbinom(1,1,0.5)
coin

z <- 5

while(z>=3 && z<=10) {
  print(z)
  coin <- rbinom(1,1,0.5)
  if (coin == 1){
    z <- Z+1
  }else{
    z<- z-1
  }
}

head(data)
names(data)
sd <- head(data["Amount"][,1])
sd
class(sd)
sd(sd)

#Functions

#functions in R are "first class objects", which means that they can be treated much 
#like any other R object 
# Functions can be passed as arguments to other functions
# Functions can be nexted, so you can define a function inside of another function
# The return value of a function is always the last value that is evaluated in the function

f <- function(a,b){
  a^2
}
f(3)
# arguments to functions are evaluated lazily

f<- function(a,b){
  print(a)
  print(b)
}

f(45)

lm <- function (x){
  x*x
  
}

lm(2)
search()


make.power <- function(n){
   pow <- function(x){
     x^n
   }
   pow
}

cube <- make.power(3)
square <- make.power(2)

cube(2)

ls(environment(cube))
ls(environment(pow))

b <- seq(1.7, 1.9, len=100)

# Closure and Partial application

add_two_numbers <- function(num1, num2){
  num1+num2
}

add_two_numbers(2,3)

incrementBy1 <- function(num){
  add_two_numbers(num,1);
}

make.incrementByN <- function(n){
   function(num){
     add_two_numbers(num, n)
   }
}

incBy10 = make.incrementByN(10) 
incBy10(1)

incBy20 = make.incrementByN(20)


















