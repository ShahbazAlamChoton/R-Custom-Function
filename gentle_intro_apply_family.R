m1 <- matrix(1:10, nrow = 5, ncol = 6)
m1


# apply(array_or_matrix, margin(1 for row, 2 for column), function_name(it can be both default or user defined))

(apply_m1_row<- apply(m1, 1,sum))
(apply_m1_col<- apply(m1, 2,sum))

# lapply(list_vector_data.frame, Function name(can be both built in or user defined))
# It always returns a list
# It cannot use "Margin" as it deals with list
# list is the object which contains elements of different types - 
# like strings, numbers, vectors and another list inside it.
# R list can also contain a matrix or a function as its elements

movie_name <- c("BATMAN", "SPIDERMAN", "IRONMAN")
(lowercase_movie_name <- lapply(movie_name, tolower))
class(lowercase_movie_name)
str(lowercase_movie_name)

# to unlist this output list and see it as a vector, use "unlist()" command
(lowercase_movie_name <- unlist(lapply(movie_name, tolower)))
class(lowercase_movie_name)
str(lowercase_movie_name)


# sapply does the same job as lapply() but it returns a vector
# It can deals with list, vector, data.frame
dt <- cars
(l_min_cars <- lapply(dt, min))
(s_min_cars <- sapply(dt, min))

class(s_min_cars)
str(s_min_cars)


avg <- function(x){
  (max(x)+ min(x))/2
}

(l_avg_dt <- lapply(dt, avg))
(s_avg_dt<- sapply(dt, avg))

# Slice vector

blw_avg <- function(x){
  in_sort <- sort(x)
  de_sort <- sort(x, decreasing = T)
  min <- in_sort[1]
  max<- de_sort[1]
  avg <- (max + min)/2
  blw <- x[x < avg]
  return(blw)
}


# both returns a list
(l_blw_avg_dt <- lapply(dt, blw_avg))
(s_blw_avg_dt<- sapply(dt, blw_avg))

# to see if lapply and sapply can produce the same reult or not:
identical(l_blw_avg_dt, s_blw_avg_dt)
is.logical(l_blw_avg_dt[[2]] == s_blw_avg_dt[[2]])


# tapply() computes a measure (mean, median, min, max, etc..) or 
# a function for each factor variable in a vector. 
# It is a very useful function that lets us create a subset of a vector and then
# apply some functions to each of the subset. 
str(iris)
tapply(iris$Sepal.Length, iris$Species, median)
tapply(iris$Sepal.Length, iris$Species, mean)

groups <- as.factor(rbinom(32, n = 5, prob = 0.4))
tapply(groups, groups, length) #- is almost the same as

tapply(warpbreaks$breaks, warpbreaks[,-1], sum)
tapply(warpbreaks$breaks, warpbreaks[, 3, drop = FALSE], sum)


# mapply() 

