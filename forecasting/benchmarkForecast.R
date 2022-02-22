benchmarks <- function(y, h) {
  require(forecast)
  # Compute  benchmark methods
  m_Ed<- function(y, h){
    stl_decomposition = stl(y, t.window=13, s.window="periodic",robust=TRUE)
    return(forecast(stl_decomposition,method = "ets", h= h))
  }
  
  m_Rd <- function(y, h){
    stl_decomposition = stl(y, t.window=13, s.window="periodic",robust=TRUE)
    return(forecast(stl_decomposition,method = "naive", h= h))
  }
  
  m_Ad<- function(y, h){
    stl_decomposition <- stl(y, t.window= 13, s.window= "periodic", robust=TRUE)
    stl_arima<-auto.arima(seasadj(stl_decomposition), stepwise = FALSE, approximation = FALSE)
    return(forecast(stl_arima, h = h))
  }
  
  m_Tb <- function(y, h){
    return(forecast(tbats(y), h=h))}
  
  # combine forecast outputs for all forecast methods
  fcasts <- rbind(
    Sn = snaive(y, h)$mean,
    E = forecast(ets(y), h)$mean,
    Sa = forecast(auto.arima(y), h)$mean,
    T = thetaf(y, h)$mean, 
    Ed = m_Ed(y, h)$mean,
    Rd = m_Rd(y, h)$mean,
    Ad = m_Ad(y,h)$mean,
    Tb = m_Tb(y, h)$mean
  )
  
  colnames(fcasts) <- seq(h)
  method_names <- rownames(fcasts)
  
  # Compute all possible combinations
  method_choice <- rep(list(0:1), length(method_names))
  names(method_choice) <- method_names
  combinations <- expand.grid(method_choice) %>% tail(-1) %>% as.matrix()
  
  # Construct names for all combinations
  for (i in seq(NROW(combinations))) {
    rownames(combinations)[i] <- paste0(method_names[which(combinations[i, ] > 0)],
                                        collapse = "") # collapse in case need any special seperator. current is blank
  }
  # Compute combination weights
  combinations <- sweep(combinations, 1, rowSums(combinations), FUN = "/")
  # Compute combinations of forecasts
  return(combinations %*% fcasts)
}
