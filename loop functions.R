############ LOOP FUNCTIONS

###### lapply
# "lapply" takes in a list, applies a function on it and then returns a list.
# if the input is not a list, it can be coerced into a list by as.list()


temp1 <- list( a=1:5 , b= rnorm(10))
lapply(temp1,mean)
# $a                          it can be seen that name remains the same
# [1] 3
#
# $b
# [1] -0.2588774



temp2 <- list(a=1:4, b= rnorm(10), c = rnorm(20,1), d=rnorm(100,5))
lapply(temp2,mean)
#$a
#[1] 2.5
#
#$b
#[1] 0.4193821
#
#$c
#[1] 0.8976007
#
#$d
#[1] 4.966621



temp3<- 1:4
lapply(temp3, runif)
# "runif" generates random numbers whose count is equal to the argument of the function between 0 and 1.
# hence, for first element = 1, one number is generated, 2 for second and so on.
#[[1]]
#[1] 0.1718645
#
#[[2]]
#[1] 0.1755420 0.3293615
#
#[[3]]
#[1] 0.007111878 0.506192629 0.411158935
#
#[[4]]
#[1] 0.86507642 0.07478488 0.20234675 0.57319762


#if we want to change the arguments of the runif function
# and want the numbers between 0 and 10, we can do it within the lapply

lapply(temp3,runif,min=0,max=10)
#[[1]]
#[1] 3.070004
#
#[[2]]
#[1] 8.5040801 0.3839298
#
#[[3]]
#[1] 2.258902 4.000445 1.515055
#
#[[4]]
#[1] 3.249323 4.295856 8.004369 8.878084




# can define the function within the lapply function, called "anonymous functions"

temp4<- list( a = matrix(c(1,2,3,4),nrow=2,ncol=2), b = matrix(c(5,6,7,8),nrow=2,ncol=2))
# $a
#     [,1] [,2]
#[1,]    1    3
#[2,]    2    4
#
# $b
#     [,1] [,2]
#[1,]    5    7
#[2,]    6    8

lapply(temp4,function(p){p[,1]})
# $a
#[1] 1 2
#
# $b
#[1] 5 6

########### sapply
#it simplifies the answer of lapply
#if lapply has the answer where a list contains elements of length 1, it gives out a vector answer
#if the answer for lapply is list with lenght>1, a matrix is returned

temp1 <- list( a=1:5 , b= rnorm(10))
lapply(temp1,mean)
# $a                          
# [1] 3
#
# $b
# [1] -0.2588774
sapply(temp1,mean)
#     a            b 
# 3.0000000  -0.2588774



######## apply
# usually used to apply on rows or columns of matrices
temp5 <- matrix(rnorm(200),nrow=20,ncol=10)
apply(temp5,MARGIN = 1,mean)      #margin =1 corresponds to keeping the first 
# dimension which means retaining rows ie. taking mean across 20 rows

#[1] -0.462577119  0.011856489  0.194347885  0.876095869
#[5]  0.023691798  0.002147713 -0.435080886  0.050105687
#[9]  0.827307838  0.138013448  0.225225022  0.029794721
#[13] -0.163760010  0.128631778  0.001161728 -0.038202257
#[17]  0.169969403  0.466771566 -0.122474070  0.355432264

apply(temp5,MARGIN = 2,mean)      #margin =2 corresponds to keeping the second 
# dimension which meansretaining columns ie. taking mean across 10 columns

[#1]  0.11570741  0.02195094  0.27396319 -0.10422059
#[5]  0.15017908  0.02715597  0.16658932  0.21645109
#[9]  0.17509333  0.09635968

# we have some predefined functions that use apply in a highly optimised way
  
#     rowSums = apply(x,1,sum)
#     rowMeans = apply(x,1,mean)
#     colSums = apply(x,2,sum)
#     colMeans = apply(x,2,mean)
  

########### mapply
# simultaneous operation of diff arguments


temp7 <- list( rep(1,7),rep(2,8),rep(3,9),rep(4,10))
#  [[1]]
#  [1] 1 1 1 1 1 1 1
#  
#  [[2]]
#  [1] 2 2 2 2 2 2 2 2
#  
#  [[3]]
#  [1] 3 3 3 3 3 3 3 3 3
#  
#  [[4]]
#  [1] 4 4 4 4 4 4 4 4 4 4
  
#or we can just use mapply to arguments (1:4) and (7:10) ie. 1-to-1 mapping
mapply(rep,(1:4),(7:10))
#  [[1]]
#  [1] 1 1 1 1 1 1 1
#  
#  [[2]]
#  [1] 2 2 2 2 2 2 2 2
#  
#  [[3]]
#  [1] 3 3 3 3 3 3 3 3 3
#  
#  [[4]]
#  [1] 4 4 4 4 4 4 4 4 4 4


# mapply is generally used to vectorize a function

noise<-function(n,meann,sd){
  rnorm(n,meann,sd)
}

noise(5,1,2)
# [1] 2.258348 2.400261 1.582946 0.388753 2.252792

# now consider we want to input vectors in such a way that we compute 
# noise(1,1,2) , noise(2,2,2), noise(3,3,2) and so on.
# this wont work if we pass the vector to the function as it takes single arguments
# instead, we can use mapply to do the 1-to-1 mapping

mapply(noise,1:5,1:5,2)
#[[1]]
#[1] -3.567989
#
#[[2]]
#[1]  3.5900125 -0.9761823
#
#[[3]]
#[1] 6.381890 4.149841 3.271242
#
#[[4]]
#[1] 4.770591 7.705636 4.980567 2.049779
#
#[[5]]
#[1] 8.768483 2.345995 7.169901 4.452875 6.581495




######### tapply
# used to operate on subsets if vectors

temp8 <- c(rnorm(10), runif(10), rnorm(10,1))    # consider 3 different groups

#[1]  0.40740577 -0.61306578 -1.74967410 -0.87849804
#[5]  0.18993324 -1.90236610  1.33450364  1.17146295
#[9] -0.53676088  0.25602162  0.26539827  0.95773511
#[13]  0.41836023  0.02508026  0.01956644  0.91611893
#[17]  0.52681392  0.12201121  0.36824754  0.21027279
#[21]  3.04163573  2.33424556  1.28009808  1.04131945
#[25]  0.63120108  2.37514034 -1.12982102  1.34929809
#[29]  2.38468635  0.22636465

f <- gl(3,10)     # creates a factor vector of 3 levels repeated 10 times each
#  [1] 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3
#  [30] 3
#  Levels: 1 2 3

tapply(temp8,f,mean)   #mapped group 1 to level 1, calculated mean of each pair
#     1          2          3 
# -0.2321038  0.3829605  1.3534168 

# tapply is simplified by default to return a vector

tapply(temp8,f,mean, simplify = FALSE)   # Tthis would return a vector
# $`1`
# [1] -0.2321038
#
# $`2`
# [1] 0.3829605
#
# $`3`
# [1] 1.353417



############ split
# takes a vector input, takes a factor variable that has different levels 
# and then splits the vector input as per the fector variable.
# for example, if f=3, split will split input x into 3 groups
# we can work on these 3 diff groups using lapply,sapply etc

temp8 <- c(rnorm(10), runif(10), rnorm(10,1))    # consider 3 different groups

#[1]  0.40740577 -0.61306578 -1.74967410 -0.87849804
#[5]  0.18993324 -1.90236610  1.33450364  1.17146295
#[9] -0.53676088  0.25602162  0.26539827  0.95773511
#[13]  0.41836023  0.02508026  0.01956644  0.91611893
#[17]  0.52681392  0.12201121  0.36824754  0.21027279
#[21]  3.04163573  2.33424556  1.28009808  1.04131945
#[25]  0.63120108  2.37514034 -1.12982102  1.34929809
#[29]  2.38468635  0.22636465

f <- gl(3,10)     # creates a factor vector of 3 levels repeated 10 times each

split(temp8,f)
# $`1`
# [1]  0.4074058 -0.6130658 -1.7496741 -0.8784980  0.1899332
# [6] -1.9023661  1.3345036  1.1714630 -0.5367609  0.2560216
#
# $`2`
# [1] 0.26539827 0.95773511 0.41836023 0.02508026 0.01956644
# [6] 0.91611893 0.52681392 0.12201121 0.36824754 0.21027279
#
# $`3`
# [1]  3.0416357  2.3342456  1.2800981  1.0413194  0.6312011
# [6]  2.3751403 -1.1298210  1.3492981  2.3846863  0.2263646

lapply(split(temp8,f),sum)
# $`1`
# [1] -2.321038
#
# $`2`
# [1] 3.829605
#
# $`3`
# [1] 13.53417



## spliting a data frame
# consider the airquality dataset. it contains info like ozone levels,
# wind levels etc for different months with each moth having multiple
# observations. we now want to calculate mean of each column head corresponding to a single month.

s <- split( airquality,airquality$Month)
lapply(s,function(x){colMeans(x)})
# $`5`
# Ozone  Solar.R     Wind     Temp    Month      Day 
#  NA       NA    11.62258  65.54839  5.00000  16.00000 

# $`6`
# Ozone   Solar.R      Wind      Temp     Month       Day 
#  NA    190.16667  10.26667   79.10000   6.00000   15.50000 

# $`7`
# Ozone    Solar.R       Wind       Temp      Month     Day 
#  NA    216.483871   8.941935  83.903226   7.000000  16.000000


# $`8`
# Ozone   Solar.R      Wind      Temp     Month       Day 
#   NA        NA    8.793548   83.967742  8.000000  16.000000 

# $`9`
# Ozone  Solar.R     Wind     Temp    Month      Day 
#  NA    167.4333  10.1800  76.9000   9.0000   15.5000 

sapply(s,function(x){colMeans(x)})
#               5         6          7         8        9
#Ozone         NA        NA         NA        NA       NA
#Solar.R       NA 190.16667 216.483871        NA 167.4333
#Wind    11.62258  10.26667   8.941935  8.793548  10.1800
#Temp    65.54839  79.10000  83.903226 83.967742  76.9000
#Month    5.00000   6.00000   7.000000  8.000000   9.0000
#Day     16.00000  15.50000  16.000000 16.000000  15.5000

sapply(s,function(x){colMeans(x, na.rm=TRUE)})
#             5         6          7          8         9
#Ozone    23.61538  29.44444  59.115385  59.961538  31.44828
#Solar.R 181.29630 190.16667 216.483871 171.857143 167.43333
#Wind     11.62258  10.26667   8.941935   8.793548  10.18000
#Temp     65.54839  79.10000  83.903226  83.967742  76.90000
#Month     5.00000   6.00000   7.000000   8.000000   9.00000
#Day      16.00000  15.50000  16.000000  16.000000  15.50000
 
## splitting at more than 2 levels ie. combinations of two different levels

f1<- gl(2,5)
# [1] 1 1 1 1 1 2 2 2 2 2
# Levels: 1 2
f2<- gl(5,2)
# [1] 1 1 2 2 3 3 4 4 5 5
# Levels: 1 2 3 4 5

interaction(f1,f2)
#[1] 1.1 1.1 1.2 1.2 1.3 2.3 2.4 2.4 2.5 2.5
#Levels: 1.1 2.1 1.2 2.2 1.3 2.3 1.4 2.4 1.5 2.5  ( 2 x 5 - 10 levels)

temp9<- 20:39
# [1] 20 21 22 23 24 25 26 27 28 29 

split(temp9,list(f1,f2))
# $`1.1`
# [1] 20 21 30
# $`2.1`
# integer(0)
# $`1.2`
# [1] 22 23
# $`2.2`
# integer(0)
# $`1.3`
# [1] 24
# $`2.3`
# [1] 25
# $`1.4`
# integer(0)
# $`2.4`
# [1] 26 27
# $`1.5`
# integer(0)
# $`2.5`
# [1] 28 29

str( split (temp9, list(f1,f2) , drop=TRUE) )   #makes a list and drops the empty levels
# List of 6
# $ 1.1: int [1:3] 20 21 30
# $ 1.2: int [1:2] 22 23
# $ 1.3: int 24
# $ 2.3: int 25
# $ 2.4: int [1:2] 26 27
# $ 2.5: int [1:2] 28 29
