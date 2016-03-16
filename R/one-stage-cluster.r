filesvy.simple.cluster <- function(directory, n=8, f=file.count) {
  subdirs <- select.immediate.subdirs(directory)
  if (length(subdirs) <= 20) {
    stop('There are few enough subdirectories that you might as well do a census.')
  }

  subdirs.sample <- sample(subdirs, size=n)
  svydesign(ids=~subdir,
            probs=~prob,
            data=data.frame(dir=directory,
                            subdir=subdirs.sample,
                            value=sapply(subdirs.sample, f),
                            prob=n/length(subdirs)))
}
