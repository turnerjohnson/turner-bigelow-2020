library(eubatools)
library(dplyr)
library(readr)

V = c(.003,.010,.011,.012,.013,.014,.020,.021,.030,.031,.040,.041,.042,.043,.044,.045,.046,.050,.051,.052,.053,.054,.055,.056,.057,.058,.060,.061,.062,.063,.064,.070,.071,.080,.081,.090,.091,.092,.093,.094,.095,.096,.097,.098,.099)
V = sprintf("v%0.3f",V)

predictor_namer = function(x){
  # obpg.sst.8DR, obpg.chlor_a.8DR, ..., bathy.etopo1
  R = sapply(names(x),
             function(name){ #obpg or bathy 
               if(is.list(x[[name]])){
                 nms = names(x[[name]])
                 vals = sapply(x[[name]],
                               "[[",1)
                 paste(name,nms,vals,sep ='.')
               } else {
                 paste(name,x[[name]],sep = '.')
               } 
             })
  paste(unname(unlist(R)),collapse=', ')
}

x = lapply(V,
            function(x){
              cat(x,'\n')
              y = eubatools::read_config(x=x)
              z = dplyr::tibble(
                version = y$version,
                region = y$region,
                polygons = ifelse(is.null(y$polygons), NA, y$polygons),
                predictors = predictor_namer(y$predictors),
                model_range = paste(y$model$doy_range,collapse=', '),
                model_window = paste(y$model$window,collapse=', '),
                model_nback = y$model$nback,
                obs_min = y$obs$min,
                obs_species = y$obs$species,
                obs_score = y$obs$score,
                obs_type = y$obs$type,
                obs_seed = ifelse(is.null(y$obs$seed),NA,y$obs$seed),
                obs_train = y$obs$train
              )
              z
              }
            ) %>%
  dplyr::bind_rows() %>%
  readr::write_csv('/mnt/ecocast/projects/eubalaena/turner/yamls.csv')


