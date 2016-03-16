library(devtools)
library(survey)
load_all()

x <- filesvy.simple.cluster('~/s3-backup/home2/usbhd-sda4/', n=3)

cat('Sampled clusters:\n')
print(as.character(unlist(x$cluster)))
cat('Estimate:\n')
print(svytotal(~value, x))
