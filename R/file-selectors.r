select.files <- function(directory)
  list.files(directory, recursive=TRUE, all.files=TRUE)

select.dirs <- function(directory)
  list.dirs(directory, recursive=TRUE)

select.git.repositories <- function(directory) {
  directory <- sub('/*$', '', directory)

  if (dir.exists(file.path(directory, '.git'))) directory
  else unlist(sapply(list.dirs(directory, recursive=FALSE),
                     select.git.repositories), use.names=FALSE)
}

.has.no.subdirectory <- function(directory)
  0 == length(list.dirs(directory, full.names=FALSE, recursive=FALSE))

REPOSITORY.FILES <- c('^.git$', '^DESCRIPTION$', '^README.*$')
select.repositories <- function(directory) {
  directory <- sub('/*$', '', directory)
  files <- list.files(directory, full.names=FALSE, recursive=FALSE,
                      all.files=TRUE)
  matches <- mapply(grepl, rep(REPOSITORY.FILES, each=length(files)),
                    rep(files, length(REPOSITORY.FILES)))
  if (any(matches) || .has.no.subdirectory(directory)) directory
  else unlist(sapply(list.dirs(directory, recursive=FALSE),
                     select.repositories), use.names=FALSE)
}
