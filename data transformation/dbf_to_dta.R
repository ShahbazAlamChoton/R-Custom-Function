rm(list = ls())
library(tidyverse)
library(foreign)
current_path <- rstudioapi::getSourceEditorContext()$path
dataParentFolder <- "rawData"
setwd(paste0(dirname(current_path), "/", dataParentFolder)) -> dataDir


# getting all files an folders that are visible in parent folder
all.files <- list.files(rec = FALSE)
# extract all sub folder from parent folder
subFolder <-  all.files[file.info(all.files)$isdir]

#=============== Folder wise dbf files Backup ==================================================

for(i in seq_along(subFolder)){
  
    dataFrom <- paste0(dataDir,"/", subFolder[i])
    # setwd(dataFrom)
    current_subfolders_dbf_file <- list.files(dataFrom, pattern = ".dbf$", ignore.case = T) # Change it any extension
    
    for(j in seq_along(current_subfolders_dbf_file)){
      
        dbf_file <- read.dbf(paste0(dataFrom,"/", current_subfolders_dbf_file[j]), as.is = TRUE)
        dbf_file_name <- substr(current_subfolders_dbf_file[j], 1, str_length(current_subfolders_dbf_file[j])- 4)
        
        #  change at your own convenience
        backupDir <- paste0(dirname(current_path),"/dumpData/") # if not create a folder 'dumpData' in dirnames(current_path)
        paste_in <- subFolder[i]
        
        if (dir.exists(paste0(backupDir, paste_in))){
          write.dta(dbf_file, paste0(backupDir,"/", paste_in,"/",dbf_file_name, ".dta")) # for .dta transfer
          # write.csv(dbf_file, paste0(dbf_file_name, ".csv"), row.names = FALSE) # for .csv transfer
        } else {
          dir.create(paste0(backupDir, paste_in))
          write.dta(dbf_file, paste0(backupDir,"/", paste_in,"/",dbf_file_name, ".dta")) # for .dta transfer
          # write.csv(dbf_file, paste0(dbf_file_name, ".csv"), row.names = FALSE) # for .csv transfer
        }
        
    }
    
    
  }
