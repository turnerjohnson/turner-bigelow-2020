library(rasterVis)
library(eubatools)
library(RColorBrewer)

versions = c('v0.090','v0.091','v0.092','v0.093','v0.094','v0.095','v0.096','v0.097','v0.098','v0.099')
date=as.Date('2019-07-10')

v_path = version_path(versions,'xcast',format(date,'%Y'),format(date,'%Y-%m-%d.tif'))

SS <- raster::stack(v_path)
names(SS) <- versions


#seems like these are going to be a lot of negative numbers...
Smean <- mean(SS, na.rm=TRUE)
dSS <-  SS - Smean
names(dSS) <- versions
turnerTheme = rasterVis::rasterTheme(region=RColorBrewer::brewer.pal(11,"PRGn"))

rasterVis::levelplot(dSS,par.settings=turnerTheme,
                     main=sprintf("Departure from Mean on %s",format(date,'%Y-%m-%d')))

diff1 = SS$v0.091 - SS$v0.090
diff2 = SS$v0.092 - SS$v0.090
diff3 = SS$v0.093 - SS$v0.090
diff4 = SS$v0.094 - SS$v0.090
diff5 = SS$v0.095 - SS$v0.090
diff6 = SS$v0.096 - SS$v0.090
diff7 = SS$v0.097 - SS$v0.090
diff8 = SS$v0.098 - SS$v0.090
diff9 = SS$v0.099 - SS$v0.090

DD <- raster::stack(c(diff1,diff2,diff3,diff4,diff5,diff6,diff7,diff8,diff9))
versionsDD = c('91-90','92-90','93-90','94-90','95-90','96-90','97-90','98-90','99-90')
names(DD) <- versionsDD

pdf('/mnt/ecocast/projects/eubalaena/turner/nback_diff.pdf')
rasterVis::levelplot(DD)
#late spring, summer, fall (by chlorophyll)
dev.off()
