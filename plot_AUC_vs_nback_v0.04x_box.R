# plot_AUC_vs_nback_v0.04x_box.R
# making plot of annual AUC average by number of background points

library(dplyr)
library(eubatools)
library(readr)
library(ggplot2)
library(dismotools)
library(tidyr)
library(hflights)

versions = c('v0.040','v0.041','v0.042','v0.043','v0.045','v0.046')
nback = c(100,250,400,550,850,1000)

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
                      # "/mnt/ecocast/projectdata/eubalaena/versions/v0/v0.040/model_summary.csv"
                    },
                    simplify = FALSE) %>%
  dplyr::bind_rows() %>%
  dplyr::select(version, nback, doy, auc,p_count,chlor_a.8DR,par.8DR,pic.8DR,sst.8DR,bathy) 

pdf('/mnt/ecocast/projects/eubalaena/turner/AUC_vs_nback_v0.04x_box.pdf')
ggplot(sum_stack, aes(x=nback,y=auc)) +
  geom_boxplot(aes(group = version),
               outlier.colour="orange", outlier.shape=8,
               outlier.size=2) +
  labs(title='AUC vs. # of bkg points for Right Whales \npresence max=200\npoly=bathy1000m',
       subtitle='v0.040, v0.041, v0.042, v0.043, v0.045, v0.046',
       x='# background points',
       y='yearly AUC') 

dev.off()
