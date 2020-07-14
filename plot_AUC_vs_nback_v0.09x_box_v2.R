# plot_AUC_vs_nback_v0.09x_box_v2.R
# making plot of annual AUC average by number of background points

library(dplyr)
library(eubatools)
library(readr)
library(ggplot2)
library(dismotools)
library(tidyr)
library(hflights)

versions = c('v0.090','v0.091','v0.092','v0.093','v0.094','v0.095','v0.096','v0.097','v0.098','v0.099')
nback = c(100,250,400,550,700,850,1000,1150,1300,1450)

names(nback) = versions


#load summary files for each version


sum_stack <- sapply(versions,
                     function(vp){
                       v_path = version_path(vp,'model_summary.csv')
                       x <- suppressMessages(readr::read_csv(v_path)) %>%
                         dplyr::mutate(doy = basename(path),
                                       version = vp,
                                       nback = nback[vp]) %>%
                         dplyr::select(-path)
                       # "/mnt/ecocast/projectdata/eubalaena/versions/v0/v0.090/model_summary.csv"
                     },
                     simplify = FALSE) %>%
              dplyr::bind_rows() %>%
              dplyr::select(version, nback, doy, auc,p_count,chlor_a.8DR,par.8DR,pic.8DR,sst.8DR,bathy) 

pdf('/mnt/ecocast/projects/eubalaena/turner/AUC_vs_nback_v0.09x_box.pdf')
ggplot(sum_stack, aes(x=nback,y=auc)) +
  geom_boxplot(aes(group = version),
               outlier.colour="orange", outlier.shape=8,
               outlier.size=2) +
  labs(title='AUC vs. # of bkg points for Right Whales \npresence max=200\npoly=bathy1000m',
       subtitle='v0.090, v0.091, v0.092, v0.093, v0.094, v0.095, v0.096',
       x='# background points',
       y='yearly AUC') 

dev.off()
