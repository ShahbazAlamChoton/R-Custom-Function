temp_interval <- function(lowerVal, upperVal){
  
  tempConverter <- function(x){
    return(round(((x-32)*5)/9, 1))
  }
  
  return(paste0("average temprature lies between [", tempConverter(lowerVal), "°C, ", tempConverter(upperVal), "°C]"))
}


# paste0("Arkansas: ", temp_interval(58,63))
# paste0("Charlotte: ", temp_interval(63, 73))
# paste0("Maryland: ", temp_interval(30, 89))
# paste0("Michigan: ", temp_interval(17, 82))
# paste0("Alabama: ", temp_interval(60, 64))
# paste0("Lousville: ", temp_interval(66, 73.9))
# paste0("North Dakota: ", temp_interval(37, 43))
# paste0("Nevada: ", temp_interval(90, 105))
# paste0("South Carolina: ", temp_interval(34, 92.1))
# paste0("Utah: ", temp_interval(17, 89))
# paste0("Idaho: ", temp_interval(14, 87))
# paste0("Duluth, Minnesota: ", temp_interval(35, 89))
# paste0("Montana: ", temp_interval(12, 85))
# 



