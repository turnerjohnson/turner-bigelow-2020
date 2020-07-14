# making plot of annual AUC average by number of background points

library(dplyr)
library(eubatools)
library(readr)
library(ggplot2)
library(dismotools)
library(tidyr)
library(hflights)

versions = c('v0.090','v0.091','v0.092','v0.093','v0.094','v0.095','v0.096')

#load summary files for each version
version_path = version_path(versions,'model_summary.csv')

#sum_stack <- sapply(version_path,
#                     function(vp){
#                       x <- suppressMessages(readr::read_csv(vp)) %>%
#                         dplyr::mutate(doy = basename(path),
#                                       version = basename(dirname(vp)))
#                     },
#                     simplify = FALSE)
#
#sum_stack <- rename(sum_stack,'v0.090'='/mnt/ecocast/projectdata/eubalaena/versions/v0/v0.090/model_summary.csv')
#
#names(sum_stack$'/mnt/ecocast/projectdata/eubalaena/versions/v0/v0.090/model_summary.csv') <- 'v0.090'
#
#sum_stack


#v0.090
v90_table = read_csv(version_path[1])
v90_auc = v90_table$auc

  
#v0.091
v91_table = read_csv(version_path[2])
v91_auc = v91_table$auc


#v0.092
v92_table = read_csv(version_path[1])
v92_auc = v92_table$auc


#v0.093
v93_table = read_csv(version_path[1])
v93_auc = v93_table$auc

#v0.094
v94_table = read_csv(version_path[1])
v94_auc = v94_table$auc

#v0.095
v95_table = read_csv(version_path[1])
v95_auc = v95_table$auc


#v0.096
v96_table = read_csv(version_path[1])
v96_auc = v96_table$auc


box_90 <- cbind(v90_auc,v91_auc,v92_auc,v93_auc,v94_auc,v95_auc,v96_auc)
nback = c(100,250,400,550,700,850,1000)
colnames(box_90) <- nback
doy = c(1:366)
box_90 <- cbind(doy,box_90)



pdf('/mnt/ecocast/projects/eubalaena/turner/AUC_vs_nback_v0.09x_box.pdf')
ggplot(as.data.frame(table_sum_90_box), aes(x=nback)) +
  geom_point() +
  labs(
    title="box plot attempt 1",
    subtitle='v0.090, v0.091, v0.092, v0.093, v0.094, v0.095, v0.096') 

dev.off()
