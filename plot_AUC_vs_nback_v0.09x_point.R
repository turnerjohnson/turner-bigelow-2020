# making plot of annual AUC average by number of background points

library(dplyr)
library(eubatools)
library(readr)
library(ggplot2)
library(dismotools)
library(tidyr)

versions = c('v0.090','v0.091','v0.092','v0.093','v0.094','v0.095','v0.096','v0.097','v0.098','v0.099')

#load summary files for each version
version_path = version_path(versions,'model_summary.csv')

#sum_stack  <- sapply(version_path,
#                     function(vp){
#                       x <- suppressMessages(readr::read_csv(vp)) %>%
#                         dplyr::mutate(doy = basename(path),
#                                       version = basename(dirname(vp)))
#                     },
#                     simplify = FALSE)




#v0.090
v90_table = read_csv(version_path[1])
v90_mean_auc <- mean(v90_table$auc)
v90_IQR <- IQR(v90_table$auc)
v0.090 = c(v90_mean_auc,v90_IQR)
names(v0.090) <- c('mean_auc','IQR')
  

#v0.091
v91_table = read_csv(version_path[2])
v91_mean_auc <- mean(v91_table$auc)
v91_IQR <- IQR(v91_table$auc)
v0.091 = c(v91_mean_auc,v91_IQR)
names(v0.091) <- c('mean_auc','IQR')


#v0.092
v92_table = read_csv(version_path[3])
v92_mean_auc <- mean(v92_table$auc)
v92_IQR <- IQR(v92_table$auc)
v0.092 = c(v92_mean_auc,v92_IQR)
names(v0.092) <- c('mean_auc','IQR')


#v0.093
v93_table = read_csv(version_path[4])
v93_mean_auc <- mean(v93_table$auc)
v93_IQR <- IQR(v93_table$auc)
v0.093 = c(v93_mean_auc,v93_IQR)
names(v0.093) <- c('mean_auc','IQR')

#v0.094
v94_table = read_csv(version_path[5])
v94_mean_auc <- mean(v94_table$auc)
v94_IQR <- IQR(v94_table$auc)
v0.094 = c(v94_mean_auc,v94_IQR)
names(v0.094) <- c('mean_auc','IQR')

#v0.095
v95_table = read_csv(version_path[6])
v95_mean_auc <- mean(v95_table$auc)
v95_IQR <- IQR(v95_table$auc)
v0.095 = c(v95_mean_auc,v95_IQR)
names(v0.095) <- c('mean_auc','IQR')


#v0.096
v96_table = read_csv(version_path[7])
v96_mean_auc <- mean(v96_table$auc)
v96_IQR <- IQR(v96_table$auc)
v0.096 = c(v96_mean_auc,v96_IQR)
names(v0.096) <- c('mean_auc','IQR')

#v0.097
v97_table = read_csv(version_path[8])
v97_mean_auc <- mean(v97_table$auc)
v97_IQR <- IQR(v97_table$auc)
v0.097 = c(v97_mean_auc,v97_IQR)
names(v0.097) <- c('mean_auc','IQR')

#v0.098
v98_table = read_csv(version_path[9])
v98_mean_auc <- mean(v98_table$auc)
v98_IQR <- IQR(v98_table$auc)
v0.098 = c(v98_mean_auc,v98_IQR)
names(v0.098) <- c('mean_auc','IQR')

#v0.099
v99_table = read_csv(version_path[10])
v99_mean_auc <- mean(v99_table$auc)
v99_IQR <- IQR(v99_table$auc)
v0.099 = c(v99_mean_auc,v99_IQR)
names(v0.099) <- c('mean_auc','IQR')


table_sum_90 <- rbind(v0.090,v0.091,v0.092,v0.093,v0.094,v0.095,v0.096,v0.097,v0.098,v0.099)
nback = c(100,250,400,550,700,850,1000,1150,1300,1450)
table_sum_90 <- cbind(nback, table_sum_90)
colnames(table_sum_90) <- c('nback','mean_auc','IQR')


pdf('/mnt/ecocast/projects/eubalaena/turner/AUC_vs_nback_v0.09x_point.pdf')
ggplot(as.data.frame(table_sum_90), aes(x=nback, y = mean_auc)) +
  geom_point() +
  labs(
    title="Mean AUC vs. number of bkg points \npresence max=200 \npoly=bathy1000m",
    subtitle='v0.090, v0.091, v0.092, v0.093, v0.094, v0.095, v0.096') + 
  xlab('# background points') +
  ylab('yearly mean AUC')

dev.off()
