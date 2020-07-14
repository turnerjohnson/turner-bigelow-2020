# AUC deviation plot

library(dplyr)
library(eubatools)
library(readr)
library(ggplot2)
library(dismotools)
library(tidyr)


versions = c('v0.014','v0.045','v0.064','v0.095')
supergroups = c('a','a','b','b')
names(supergroups) <- versions

#load summary files for each version
path_of_versions = version_path(versions,'model_summary.csv')

SS <- lapply(path_of_versions,
                    function(v_path){
                      suppressMessages(readr::read_csv(v_path)) %>%
                      dplyr::mutate(doy = basename(path),
                                    version = basename(dirname(v_path))) %>%
                        dplyr::select(-path)
                    }
             ) %>%
  dplyr::bind_rows() %>%
  dplyr::mutate(vgroup=supergroups[version]) %>%
  dplyr::select(vgroup,version, doy, auc,p_count,chlor_a.8DR,par.8DR,pic.8DR,sst.8DR,bathy) %>%
  dplyr::mutate(doy=as.numeric(doy)) %>%
  dplyr::group_by(vgroup,version)  #group_keys(SS)
  

pdf('/mnt/ecocast/projects/eubalaena/turner/AUC_vs_presence.pdf')

ggplot(data=SS, aes(x=p_count,y=auc,color=doy)) +
  scale_color_gradient(low='orange',high='blue') +
  geom_text(aes(label=doy,size='tiny')) +
  facet_wrap(~version,scales='free_x')

dev.off()

