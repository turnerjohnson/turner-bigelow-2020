# AUC_plotter.R
# plots AUCs by DOY/index

library(dplyr)
library(eubatools)
library(readr)
library(ggplot2)
library(dismotools)

completed_versions=c('v0.013','v0.014','v0.020','v0.021','v0.030','v0.031','v0.040','v0.041','v0.042','v0.043','v0.045','v0.046')
version_path = version_path(completed_versions,'model_summary.csv')
SS = lapply(version_path,read_csv)
names(SS) = completed_versions
ok = lapply(completed_versions,
            function(v='v0.014'){
              pdf(file = file.path('/mnt/ecocast/projectdata/eubalaena/versions/v0',v,"model_summary.pdf"))
              dismotools::plot_model_summary(SS[[v]],
                                             version = v,
                                             model_name = 'day of year')
              dev.off()
            })


# Here is a slight alternative path to gathering the list of summaries (SS)
# it adds two columns for 'version' and 'doy' that works just for the eubalaena datasets
# it also uses 'sapply' with the argument simply = FALSE instead 'lapply' followed by names(SS) = blah
# 
# sapply nicely attached names to the returned values, but as it's name suggests it tries to 
# simplify the returned results (like making some awful matrix when you wanted a lost of tables)
# so, we use sapply for the naming feature (it takes the names from the input), but we tell 
# it not to simplify (somewhat ironically)
#
# result <- sapply(set_of_elements, function_to_do_something_to_each_element, simplify = FALSE)
# 
# 
# lapply is a workhorse that, like all of the *apply functions (sapply, lapply, mapply, tapply and apply),
# is an iterator (runs a loop but sort of in the abstract).  'lapply' always returns a list, but 
# it doesn't nicely attach names to each element of the result.  So, you end up doing...
#
#  result <- lapply(set_of_elements, function_to_do_something_to_each_element)
#  names(result) <- my_list_of_names
#
completed_versions=c('v0.013','v0.014','v0.020','v0.021','v0.030','v0.031',
                     'v0.040','v0.041','v0.042','v0.043','v0.045','v0.046')
version_path = version_path(completed_versions,'model_summary.csv')
names(version_path) <- completed_versions
SS  <- sapply(version_path,
              function(vp){
                x <- suppressMessages(readr::read_csv(vp)) %>%
                  dplyr::mutate(doy = basename(path),
                                version = basename(dirname(vp)))
              },
              simplify = FALSE)
               