rm(list = ls())
# url <- "https://stackoverflow.com/questions/22069095/r-get-list-of-files-but-not-of-directories"
library(tidyverse)
library(stringr)
library(stringi)

rDir <- "E:/"
setwd(rDir)
backupDirParent <- "E:/Shahbaz/rfun/"

# all.files1 <- list.files(rDir, pattern = ".R$", all.files = TRUE)


st_time<- Sys.time()

allF <- list.files(rDir, pattern = ".R$", all.files = T, recursive = TRUE)
all.files <- allF[-grep("RECYCLE.BIN", allF)]
# test <- all.files[-grep("RECYCLE.BIN", all.files)]
elementName <- lapply(stri_split_regex(stri_reverse(all.files), pattern = '[/\\s]+', n = 2), stri_reverse)

pb <- txtProgressBar(min = 0, max = length(all.files), style = 3) # to see the completion progress

for( i in seq_along(elementName)){
  
    currentFileName <- elementName[[i]][1]
    backupDir <- elementName[[i]][2]

    if (length(elementName[[i]]) == 2){
        putBackupIn <- paste0(backupDirParent, backupDir)
        
        if (dir.exists(putBackupIn)){
            file.copy(all.files[i], putBackupIn)
          } else {
            dir.create(putBackupIn, recursive = T)
            file.copy(all.files[i], putBackupIn)
            }
    } else {
      putBackupIn <- paste0(backupDirParent, "Misc")
      if (dir.exists(putBackupIn)){
        file.copy(all.files[i], putBackupIn)
        } else {
          dir.create(putBackupIn, recursive = T)
          file.copy(all.files[i], putBackupIn)
        }
    }
    
    setTxtProgressBar(pb, i) # to see the progress
  }


close(pb)
en_time<- Sys.time()
(time_taken<- en_time - st_time)

