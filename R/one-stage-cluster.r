filesvy.simple.cluster <- function(directory, n=8, f=file.count) {
  subdirs <- select.immediate.subdirs(directory)
  if (length(subdirs) <= 20) {
    stop('There are few enough subdirectories that you might as well do a census.')
  }

  subdirs.sample <- sample(subdirs, size=n)
  y <- list(ids=~subdir,
            weights=~weight,
            data=data.frame(dir=directory,
                            subdir=subdirs.sample,
                            value=sapply(subdirs.sample, f),
                            weight=n/length(subdirs)))
  do.call(svydesign, y)
}
