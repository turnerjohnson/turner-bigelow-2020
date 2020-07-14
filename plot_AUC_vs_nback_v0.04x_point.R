# making plot of annual AUC average by number of background points

library(dplyr)
library(eubatools)
library(readr)
library(ggplot2)
library(dismotools)
library(tidyr)

versions = c('v0.040','v0.041','v0.042','v0.043','v0.045','v0.046')

#load summary files for each version
version_path = version_path(versions,'model_summary.csv')

#sum_stack  <- sapply(version_path,
#                     function(vp){
#                       x <- suppressMessages(readr::read_csv(vp)) %>%
#                         dplyr::mutate(doy = basename(path),
#                                       version = basename(dirname(vp)))
#                     },
#                     simplify = FALSE)




#v0.040
v40_table = read_csv(version_path[1])
v40_mean_auc <- mean(v40_table$auc)
v40_IQR <- IQR(v40_table$auc)
v0.040 = c(v40_mean_auc,v40_IQR)
names(v0.040) <- c('mean_auc','IQR')


#v0.041
v41_table = read_csv(version_path[2])
v41_mean_auc <- mean(v41_table$auc)
v41_IQR <- IQR(v41_table$auc)
v0.041 = c(v41_mean_auc,v41_IQR)
names(v0.041) <- c('mean_auc','IQR')


#v0.042
v42_table = read_csv(version_path[3])
v42_mean_auc <- mean(v42_table$auc)
v42_IQR <- IQR(v42_table$auc)
v0.042 = c(v42_mean_auc,v42_IQR)
names(v0.042) <- c('mean_auc','IQR')


#v0.043
v43_table = read_csv(version_path[4])
v43_mean_auc <- mean(v43_table$auc)
v43_IQR <- IQR(v43_table$auc)
v0.043 = c(v43_mean_auc,v43_IQR)
names(v0.043) <- c('mean_auc','IQR')



#v0.045
v45_table = read_csv(version_path[5])
v45_mean_auc <- mean(v45_table$auc)
v45_IQR <- IQR(v45_table$auc)
v0.045 = c(v45_mean_auc,v45_IQR)
names(v0.045) <- c('mean_auc','IQR')


#v0.046
v46_table = read_csv(version_path[6])
v46_mean_auc <- mean(v46_table$auc)
v46_IQR <- IQR(v46_table$auc)
v0.046 = c(v46_mean_auc,v46_IQR)
names(v0.046) <- c('mean_auc','IQR')


table_sum_40 <- rbind(v0.040,v0.041,v0.042,v0.043,v0.045,v0.046)
nback = c(100,250,400,550,850,1000)
table_sum_40 <- cbind(nback, table_sum_40)
colnames(table_sum_40) <- c('nback','mean_auc','IQR')


pdf('/mnt/ecocast/projects/eubalaena/turner/AUC_vs_nback_v0.04x.pdf')
ggplot(as.data.frame(table_sum_40), aes(x=nback, y = mean_auc)) +
  geom_point() +
  labs(
    title="Mean AUC vs. number of bkg points \npresence max=null\npoly=~",
    subtitle="v0.040, v0.041, v0.042, v0.043, v0.045, v0.046") + 
  xlab('# background points') +
  ylab('yearly mean AUC')

dev.off()
