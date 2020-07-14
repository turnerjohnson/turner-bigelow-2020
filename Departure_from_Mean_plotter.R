library(rasterVis)
library(eubatools)
library(RColorBrewer)
library(dplyr)

turnerTheme = rasterVis::rasterTheme(region=RColorBrewer::brewer.pal(11,"PRGn"))

# 
departure_from_mean_version_date = function(
        versions=c('v0.090','v0.091','v0.092','v0.093','v0.094','v0.095','v0.096','v0.097','v0.098','v0.099'),
        date='2019-07-10') {
  
  if (!inherits(date,'Date')) date=as.Date(date)
  v_path = version_path(versions,'xcast',format(date,'%Y'),format(date,'%Y-%m-%d.tif'))

  SS <- raster::stack(v_path)
  names(SS) <- versions
  
  Smean <- mean(SS,na.rm=TRUE)
  dSS <- SS - Smean
  names(dSS) = versions
  rSS <- c(minValue(dSS),maxValue(dSS))
  rangeSS <- max(abs(range(rSS)))*c(-1,1)
  
  
  version_series = substr(versions[1],1,5) %>%
    paste0('x')
  
  filename = sprintf('/mnt/ecocast/projects/eubalaena/turner/depart_from_mean_%s_%s.pdf',version_series,format(date,'%Y-%m-%d'))
  
  pdf(filename)
  print(rasterVis::levelplot(dSS,par.settings=turnerTheme,main=sprintf('Departure from Mean on %s',format(date,'%Y-%m-%d'))))
  dev.off()
  dSS
}
